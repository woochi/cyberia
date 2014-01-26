Overlay = require("../components/overlay.coffee")
Post = require("../../models/post.coffee")

class PostForm extends Overlay
  template: require("../../templates/posts/form.jade")
  tagName: "form"
  id: "post-form"
  events:
    "submit": "submit"

  parseForm: ->
    author: App.user.toJSON()
    text: @$(".text-input").val()

  submit: (e) ->
    e.preventDefault()
    post = new Post(@parseForm())
    post.save {},
      success: (model) =>
        App.posts.add model
        @close()
      error: (model, response) ->
        # TODO show errors in UI
        console.error "Error saving post: ", response.error.message

module.exports = PostForm
