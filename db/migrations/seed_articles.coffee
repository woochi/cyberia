mongoose = require("mongoose")
Article = mongoose.model("Article")

articles = require("../fixtures/articles")

exports.up = (next) ->
  articles = articles.map (article) ->
    words = article.content.replace(/<(?:.|\n)*?>/gm, '').split " "
    article.excerpt = words.slice(0, 24).join " "
    article
  Article.create articles, next

exports.down = (next) ->
  Article.remove {}, next
