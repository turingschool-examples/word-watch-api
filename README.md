# Word Watch API

Word Watch tracks frequently used words. You can POST words to the database, and
GET the most used word to date.

## Base URL: `https://word-watch-api.herokuapp.com/`

*Note*: If you visit `https://word-watch-api.herokuapp.com/` in the browser, you will see a 'page not found' message - type in the `/api/v1/top_word` to view what is in the DB for the top word.

|Verb|Path|Body|Response|
|---|---|---|---|
|`GET`|`/api/v1/top_word`||`"{\"word\":{\"sample\":26}}"`*|
|`POST`|`/api/v1/words`|`{ word: { value: "sample" } }`|`{ message: "sample added!" }`|

* Where `26` is the frequency of `sample` in the database.

*Note*: the word values are stored as `citext` types, so "Chair", "ChAiR", and
"chair" all count towards the count of "chair".

## Environment Setup

```shell
bundle install
rake db:{create,migrate,seed}
rspec
rails s
```
