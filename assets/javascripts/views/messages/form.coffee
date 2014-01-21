Marionette = require("marionette")

class MessageForm extends Marionette.ItemView
  template: require("../../templates/messages/form.jade")
  tagName: "form"
  id: "message-form"

module.exports = MessageForm
