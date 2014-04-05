Marionette = require("marionette")

class ArticleItem extends Marionette.ItemView
  template: require("../../templates/data/article_item.jade")
  tagName: "li"
  className: "article"
  events:
    "click": "showArticle"

  showArticle: ->
    App.dataRouter.controller.showArticle @model.id
    
module.exports = ArticleItem
