Marionette = require("marionette")

class ChatLayout extends Marionette.Layout
  template: require("../../templates/layouts/chat.jade")
  id: "chat"
  regions:
    list: "#list-wrapper"
    form: "#form-wrapper"

module.exports = ChatLayout
