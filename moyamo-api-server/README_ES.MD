#elasticsearch 설정방법

## 은전한닢 다운로드
```aidl
ES_VERSION = 5.6.16 
bash <(curl -s https://bitbucket.org/eunjeon/seunjeon/raw/master/elasticsearch/scripts/downloader.sh) -e 5.6.16 -p 5.4.1.1
```


## 은전한닢 설치

./bin/elasticsearch-plugin install file:///....{plugin}/.zip


## analyzer 설정

- aws elasticsearch 는 _close 명령을 실행할 수 없어 사용할 수 없음 alias 를 통한 설정 필요


```
curl -XPOST 'http://localhost:9200/moyamo_3/_close'

curl -XPUT 'http://localhost:9200/moyamo_3/_settings' -d '
{
  "settings" : {
    "index":{
      
      "analysis":{
        "char_filter": {
          "old_nickname_filter": {
            "type": "pattern_replace",
            "pattern": "\\[.*\\]",
            "replacement": ""
          }
        },
        "analyzer":{
          "posting_korean_text_analyzer":{
            "type":"custom",
            "tokenizer":"mecab_ko_standard_tokenizer"
          },
        "goods_korean_text_analyzer":{
            "type":"custom",
            "tokenizer":"mecab_ko_standard_tokenizer"
          },
        "attachment_korean_text_analyzer":{
            "type":"custom",
            "tokenizer":"mecab_ko_standard_tokenizer"
          },
          "comment_korean_text_analyzer":{
            "type":"custom",
            "tokenizer":"mecab_ko_standard_tokenizer",
            "char_filter": [
              "old_nickname_filter"
            ]
          }
        },
        "tokenizer": {
            "mecab_ko_standard_tokenizer": {
              "decompound": "true",
              "type": "seunjeon_tokenizer",
              "index_eojeol": false,
              "user_words": []
            }
        }
      }
    }
  }
}'

curl -XPOST 'http://localhost:9200/moyamo_3/_open'

```

