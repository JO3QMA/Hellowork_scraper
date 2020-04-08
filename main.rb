require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'yaml'

$access_page = 'https://www.hellowork.mhlw.go.jp/kensaku/GECA110010.do' # 求人情報検索画面のURL
$job_offer_page_dir = 'https://www.hellowork.mhlw.go.jp/kensaku/'
sleep_time = 3 # LibraHack対策
param_list = Hash.new # ユーザーで変更できる部分のパラメータ類
param_const = Hash.new # 定数またはシステムで変更されるパラメータ類
param_list2 = Hash.new # 詳細検索条件
job_offer_url_list = Array.new # 求人情報詳細画面のURLリスト
display_count_to_page = 10
cookie_option = ''

config = YAML.load_file("./config.yml")

param_const = config["param_const"]
param_list = config["param_list"]
param_list2 = config["param_list2"]

def create_url_parm(val_name, parm)
    if parm.instance_of?(Array)
        # Array型ならば
        if parm.empty?
            @output_parm = ''
        else
            # Arrayの数だけparamを連結する
            @connected_parm = ''
            parm.each{|var|
                var = var.to_s
                @temp_parm = val_name + '=' + var + '&'
                @connected_parm += @temp_parm
            }
            @output_parm = @connected_parm
        end
    elsif parm.instance_of?(String)
        # String型なら
        if parm == ''
            @output_parm = ''
        else
            # 連結
            @output_parm = val_name + '=' + URI.encode_www_form_component(parm) + '&'
        end
    elsif parm.integer?
        # Int型ならば
        # Stringに変換してから連結
        parm = parm.to_s
        @output_parm = val_name + '=' + parm + '&'
    else
        # それ以外の型
        # もうそれはしらん
        @output_parm = ''
    end
    return @output_parm
end

def param_creater(hash)
    @param = ""
    hash.each{ |key, value|
        @param += create_url_parm(key, value)
    }
    return @param
end
def param2_creater(hash)
    @param = ""
    hash.each{ |key, value|
        @param += create_url_parm(key, value)
    }
    return @param
end

def generate_url(hash,hash2,const)
    target_page = $access_page + '?' + param_creater(hash) + param_creater(hash2) + param_creater(const).chop!
    return target_page
end

def generate_url2(hash,const)
    target_page = $access_page + '?' + param_creater(hash) + param_creater(const).chop!
    return target_page
end

def get_cookie(uri)
    uri = URI(uri)
    res = Net::HTTP.get_response(uri)
    cookie = res['set-Cookie']
 #   puts "Cookie: #{cookie}"
    return cookie
end

target_page = generate_url(param_list, param_list2, param_const)
puts "URL: #{target_page}"
cookie_option = get_cookie(target_page)
doc = Nokogiri::HTML.parse(open(target_page))

nodes = doc.css('div.m05 > span.fb')
index_num = nodes.text.scan(/(\d+)/)[0].join('').to_i
#puts "検索結果: #{index_num} 件"
index_max_num = (index_num/display_count_to_page.to_f).ceil
1.upto(index_max_num){|page_no|
    param_const["fwListNaviBtnNext"] = "次へ＞"
    param_const["kyujinkensu"] = index_num
    param_const["fwListNowPage"] = page_no - 1
    param_const["fwListNaviCount"] = page_no + 5
    param_const["searchBtn"] = ""
    target_page = generate_url2(param_list, param_const)
    p target_page
    p page_no
    doc = Nokogiri::HTML.parse(open(target_page, { 'Cookie' => cookie_option}))
    doc.css('div.flex a#ID_dispDetailBtn').each do |anchor|
        page_url = $job_offer_page_dir + anchor[:href].delete_prefix!('./')
        p page_url
        job_offer_url_list.push(page_url)
    end
    sleep sleep_time
    #p nodes.text
}

#p job_offer_url_list
p "合計:" + job_offer_url_list.count.to_s + "件"


csv_hash = Array.new
array_index = 1

title_line = eval File.read 'job_info.rb'

csv_hash[0] = title_line
#pp csv_hash[0]

def string_scraper(hash, uri)
  @doc = Nokogiri::HTML.parse(open(uri))
  @output = Hash.new
  hash.each{ |key, value|
    @value = @doc.css("#" + key).text.gsub(/\r\n|\r|\n|\s|\t/, "")
    @output[key] = @value
  }
  return @output
end
#csv_hash[1] = string_scraper(title_line,target_page)

#pp csv_hash

job_offer_url_list.each do |uri|
    csv_hash[array_index] = string_scraper(title_line,uri)
    array_index += 1
    sleep sleep_time
end

csv_array = Array.new
index = 0
csv_hash.map{|value|

    value = value.values
    csv_array[index] = value
    index += 1

}

CSV.open('output.csv','w') do |csv| # output to csv file
    csv_array.each do |bo|
        csv << bo
    end        
end
