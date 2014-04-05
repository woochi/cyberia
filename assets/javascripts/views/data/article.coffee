Marionette = require("marionette")

class ArticleView extends Marionette.ItemView
  template: require("../../templates/data/article.jade")
  modelEvents:
    "change": "render"

module.exports = ArticleView
