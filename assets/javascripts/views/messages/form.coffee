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
    @collection.create
      from: @model.get("from").toJSON()
      to: @model.get("to").toJSON()
      text: @ui.input.val()
    ,
      success: (model) =>
        @clearInput()
      error: (model, response) ->
        console.error "Error saving message: ", response.error.message

  clearInput: ->
    @ui.input.val("")

module.exports = MessageForm
