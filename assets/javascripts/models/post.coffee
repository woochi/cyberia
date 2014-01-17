Backbone = require("backbone")

class Post extends Backbone.Model
  idAttribute: "_id"
  defaults:
    author: "Anonyymi"
    text: "Sisältöä ei ole saatavilla."
    sent: new Date()
    attachment: null

  parse: (response, options) ->
    if response.author._id = App.user.id
      response.author = App.user
    else
      response.author = App.users.get(response.author._id)
    super(response)

  toJSON: (options) ->
    _.extend super(options), author: @get("author").toJSON()

module.exports = Post
