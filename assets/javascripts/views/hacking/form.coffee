Marionette = require("marionette")

class KeyForm extends Marionette.ItemView
  template: require("../../templates/hacking/form.jade")
  tagName: "form"
  id: "key-form"
  events:
    "submit": "onSubmit"
  ui:
    key: "input[name='key']"

  onClose: ->
    @code = null

  onSubmit: (e) ->
    e.preventDefault()
    @code = new Code(key: @ui.key.val())
    @code.fetch
      success: @showPuzzle
      error: @onError

  onError: (e) ->
    console.error e

  showPuzzle: ->
    App.hackingRouter.controller.puzzle @code

module.exports = KeyForm
