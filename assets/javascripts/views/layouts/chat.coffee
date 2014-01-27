Marionette = require("marionette")

class ChatLayout extends Marionette.Layout
  template: require("../../templates/layouts/chat.jade")
  id: "chat"
  regions:
    header: "#header-content"
    list: "#list-content"
    form: "#form-content"

module.exports = ChatLayout
