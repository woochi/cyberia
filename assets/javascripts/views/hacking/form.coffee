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
    App.hackingRouter.controller.puzzle @ui.key.val()

module.exports = KeyForm
