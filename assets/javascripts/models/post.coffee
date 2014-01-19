Backbone = require("backbone")
User = require("./user.coffee")

class Post extends Backbone.Model
  idAttribute: "_id"
  backend: "posts"
  defaults:
    author: {}
    text: "Sisältöä ei ole saatavilla."
    sent: {}
    attachment: null

module.exports = Post
