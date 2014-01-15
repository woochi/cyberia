Backbone = require("backbone")

class Post extends Backbone.Model
  defaults:
    author: "Anonyymi"
    text: "Sisältöä ei ole saatavilla."
    sent: new Date()
    attachment: null

module.exports = Post
