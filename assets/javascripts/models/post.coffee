Backbone = require("backbone")
User = require("./user.coffee")

class Post extends Backbone.Model
  idAttribute: "_id"
  backend: "posts"
  defaults:
    author: new User().toJSON()
    text: "Sisältöä ei ole saatavilla."
    sent: new Date().toUTCString()
    attachment: null

module.exports = Post
