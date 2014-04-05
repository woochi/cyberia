Backbone = require("backbone")

class Article extends Backbone.Model
  backend: "articles"
  idAttribute: "_id"
  defaults:
    title: "Otsikkoa ei saatavilla"
    content: "Sisältöä ei saatavilla."
    excerpt: "Sisältöä ei saatavilla."
    date: new Date()

module.exports = Article
