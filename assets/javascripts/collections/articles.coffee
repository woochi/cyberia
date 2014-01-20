Backbone = require("backbone")

class Articles extends Backbone.Collection
  backend: "articles"
  model: require("../models/article.coffee")

  initialize: ->
    @bindBackend()

module.exports = Articles
