Marionette = require("marionette")
Message = require("../../models/message.coffee")

class MessageForm extends Marionette.ItemView
  template: require("../../templates/messages/form.jade")
  tagName: "form"
  id: "message-form"
  ui:
    input: "#message-input"
  events:
    "submit": "sendMessage"

  sendMessage: (e) ->
    e.preventDefault()
    message = new Message
      from: @model.get("from").toJSON()
      to: @model.get("to").toJSON()
      text: @ui.input.val()
    message.save {},
      success: (model) =>
        @collection.add model
        @clearInput()
      error: (model, response) ->
        console.error "Error saving message: ", response.error.message

  clearInput: ->
    @ui.input.val("")

module.exports = MessageForm
