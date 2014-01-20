Backbone = require("backbone")

class Article extends Backbone.Model
  defaults:
    text: ""
    publishedAt: new Date()

module.exports = Article
