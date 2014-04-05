Marionette = require("marionette")

class ArticleList extends Marionette.CollectionView
  tagName: "ul"
  className: "article-list"
  itemView: require("./article_item.coffee")

module.exports = ArticleList
