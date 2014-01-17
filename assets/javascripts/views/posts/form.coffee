Overlay = require("../components/overlay.coffee")

class PostForm extends Overlay
  template: require("../../templates/posts/form.jade")
  id: "post-form"
  events:
    "submit": "submit"

  parseForm: ->
    text: @$(".text-input").val()

  submit: (e) ->
    e.preventDefault()

module.exports = PostForm
