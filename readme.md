HelloWork Scraper
====
[ハローワークインターネットサービス](https://www.hellowork.mhlw.go.jp/kensaku/GECA110010.do?action=initDisp&screenId=GECA110010)の求人情報をCSVフォーマットで出力します。

## 簡単な説明
厚生労働省が運営するハローワークインターネットサービスは、インターネットからハローワークの求人情報を閲覧できる便利なサービスですが、情報の絞り込みやソート、比較などの機能が乏しくお世辞にも使いやすいとは言えません。
このハローワークスクレイパーは、ハローワークインターネットサービスから求人情報を取得し、CSVフォーマットに整形してやることで任意の表計算ソフトでの絞り込みやソート、比較を行いやすくするものです。

仕様として、[岡崎市立中央図書館事件](http://librahack.jp/)対策として1アクセスにつき3秒のクールダウンを設定しています。(2000件の求人情報で約100分ほどかかります。)

## 要求事項
- Ruby 3.x
- [Nokogiri](https://nokogiri.org/)

## 使用方法
1. `config.yml.sample`を`config.yml`という名前でコピーします。
1. 設定ファイルを編集します。(config.yml, job_info.rb)
1. `ruby main.rb`を実行します。

## インストール
``` 
git clone
cd Hellowork_scraper
bundle install
```

## ライセンス
このソフトウェアは[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)ライセンスを使用しています。

## 作者

[JO3QMA](https://github.com/jo3qma)