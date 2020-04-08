HelloWork Scraper
====

Overview

Hellowork Scraper is to output the [HelloWork job page](https://www.hellowork.mhlw.go.jp/kensaku/GECA110010.do?action=initDisp&screenId=GECA110010) in CSV format.

## Description
Convert the information on the job page of HelloWork Internet Service to a CSV file.

## Requirement
- Ruby 2.6.x
- [Nokogiri](https://nokogiri.org/)

## Usage
1. Copy `config.yml.sample` to `config.yml`
1. Configure setting files.(config.yml, job_info.rb)
1. `ruby main.rb`

## Install
``` 
git clone
cd hellowork_scraper
bundle install
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[JO3QMA](https://github.com/jo3qma)