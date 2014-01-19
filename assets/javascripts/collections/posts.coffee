Backbone = require("backbone")

class Posts extends Backbone.Collection
  model: require("../models/post.coffee")
  backend: "posts"

  initialize: ->
    @bindBackend()

module.exports = Posts
