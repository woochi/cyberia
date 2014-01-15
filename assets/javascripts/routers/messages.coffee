Marionette = require("marionette")
MessagesController = require("../controllers/messages.coffee")

class MessagesRouter extends Marionette.AppRouter
  controller: new MessagesController()
  appRoutes:
    "messages": "index"
    "messages/:user": "showConversation"

module.exports = MessagesRouter
