# Word Watch API

You can do two things here:

|Verb|Path|Body|
|---|---|---|
|`GET`|`/api/v1/top_word`||
|`POST`|`/api/v1/words`|`{ word: "sample" }`|

## Environment Setup

```shell
bundle install
rake db:{create,migrate}
rspec
rails s
```
