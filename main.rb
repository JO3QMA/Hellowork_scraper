# frozen_string_literal: true


require 'bundler/setup'
require 'rubygems'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'yaml'

# 検索画面全般の処理
class SearchPage
    def initialize(config_path = './config.yml')
        puts 'Init...'
        @access_page = 'https://www.hellowork.mhlw.go.jp/kensaku/GECA110010.do'
        @job_offer_page_dir = 'https://www.hellowork.mhlw.go.jp/kensaku/'
        @sleep_time = 3 # LibraHack対策
        @job_offer_url_list = [] # 求人情報詳細画面のURLリスト
        @display_count_to_page = 10
        @config = YAML.load_file(config_path)
        @param_const = @config['param_const'] # 定数やシステムによって変更されるパラメーター類
        @param_list  = @config['param_list']  # 検索条件
        @param_list2 = @config['param_list2'] # 詳細検索条件
    end

    def create_url_parm(key, value)
        case value
        when Array
            # Array
            if value.empty?
                output_parm = ''
            else
                connected_parm = ''
                value.each  do |var|
                    connected_parm += key + '=' + var.to_s + '&'
                end
                output_parm = connected_parm
            end
        when String
            # String
            output_parm = if value.empty?
                              ''
                          else
                              key + '=' + URI.encode_www_form_component(value) + '&'
                          end
        when Integer
            # Integer
            output_parm = key + '=' + value.to_s + '&'
        when NilClass
            # NilClass
            output_parm = ''
        end
        output_parm
    end

    def param_creater(hash)
        param = ''
        hash.each do |key, value|
            param += create_url_parm(key, value)
        end
        param
    end

    def url_generator(mode = 1)
        # 初回の検索画面では詳細検索条件まで指定しないと正しく検索されないが、
        # 2ページ目以降は詳細検索条件を指定すると正しく検索されなくなる。
        # 初回を1,2ページ目以降を2とし、詳細検索条件の有無を切り替える。
        case mode
        when 1
            url = @access_page + '?' + param_creater(@param_const) + param_creater(@param_list) + param_creater(@param_list2).chop!
            puts "検索結果URL: #{url}"
        when 2
            url = @access_page + '?' + param_creater(@param_const) + param_creater(@param_list).chop!
        end
        url
    end

    def get_cookie(url)
        # 初回の検索時にクッキーが発行され、それを使うことで詳細検索条件を指定せずとも
        # 2ページ目以降の検索結果を表示することが出来る。
        # 未調査: 一般に公開していない求人情報の表示にも必要？
        res = Net::HTTP.get_response(URI(url))
        sleep @sleep_time
        @cookie = res['set-Cookie']
        puts "Cookie: #{@cookie}"
        @cookie
    end

    def parse_result_num(url)
        page = Nokogiri::HTML.parse(URI.open(url))
        sleep @sleep_time
        nodes = page.css('div.m05 > span.fb')
        @index_num = nodes.text.scan(/(\d+)/)[0].join('').to_i # 検索結果の件数を取ってくる。
        @index_max_num = (@index_num / @display_count_to_page.to_f).ceil # 最大ページ数を計算。
        puts "検索結果: #{@index_num}件"
        puts "検索ページ数: #{@index_max_num}ページ"
        @index_num
    end

    def make_seach_url_array
        @url_array = []
        1.upto(@index_max_num) do |page_no|
            @param_const['fwListNaviBtnNext'] = '次へ＞'
            @param_const['kyujinkensu'] = @index_num
            @param_const['fwListNowPage'] = page_no - 1
            @param_const['fwListNaviCount'] = page_no + 5
            @param_const['searchBtn'] = ''
            @url_array.push url_generator(2)
        end
        @url_array
    end

    def parse_result_url
        job_offer_url_list = []
        @url_array.each do |url|
            document = Nokogiri::HTML.parse(URI.open(url, 'Cookie' => @cookie))
            sleep @sleep_time
            document.css('div.flex a#ID_dispDetailBtn').each do |anchor|
                page_url = @job_offer_page_dir + anchor[:href].delete_prefix!('./')
                job_offer_url_list.push(page_url)
            end
        end
        job_offer_url_list
    end
end

# 求人情報画面全般の処理
class JobPage
    def initialize(cookie, max_count)
        @csv_hash = []
        @csv_hash[0] = eval File.read 'job_info.rb'
        @csv_array = []
        @sleep_time = 3
        @cookie = cookie
        @max_count = max_count
    end

    def string_scraper(url)
        document = Nokogiri::HTML.parse(URI.open(url, 'Cookie' => @cookie))
        output = {}
        @csv_hash[0].each_key do |key|
            value = document.css('#' + key).text.gsub(/\r\n|\r|\n|\s|\t/, '')
            output[key] = value
        end
        output
    end

    def page_accesser(list)
        puts '求人ページから情報を取得しています…'
        hash_index = 1
        list.each do |url|
            @csv_hash[hash_index] = string_scraper(url)
            hash_index += 1
            progress(hash_index)
            sleep @sleep_time
        end
    end

    def generate_csv
        puts 'CSVに変換しています...'
        array_index = 0
        @csv_hash.map do |value|
            value = value.values
            @csv_array[array_index] = value
            array_index += 1
        end
        puts 'CSVへの変換が完了しました。'
    end

    def save_csv(filename = 'output.csv')
        CSV.open(filename, 'w') do |csv|
            @csv_array.each do |bo|
                csv << bo
            end
        end
        puts "#{filename} に保存されました。"
    end

    def progress(count)
        count -= 1
        percent = count / @max_count.to_f * 100
        scale = 2
        bar = percent / scale
        hide_bar = 100 / scale - bar.floor
        print "\r#{count}件目 [#{'=' * bar}#{' ' * hide_bar}] #{percent.floor(1)}%完了"
        puts '' if count == @max_count
    end
end

main = SearchPage.new
result_url = main.url_generator
cookie = main.get_cookie(result_url)
result_num = main.parse_result_num(result_url)
main.make_seach_url_array
url_list = main.parse_result_url

main = JobPage.new(cookie, result_num)
main.page_accesser(url_list)
main.generate_csv
main.save_csv
