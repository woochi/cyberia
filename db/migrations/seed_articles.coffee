mongoose = require("mongoose")
Article = mongoose.model("Article")

users = require("../fixtures/articles")

exports.up = (next) ->
  Article.create articles, next

exports.down = (next) ->
  Article.remove articles, next
