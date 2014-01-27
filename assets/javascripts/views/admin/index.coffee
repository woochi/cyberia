Marionette = require("marionette")

class AdminIndex extends Marionette.ItemView
  template: require("../../templates/admin/index.jade")
  id: "admin"
  events:
    "click .show-users": "showUsers"
    "click .show-messages": "showMessages"
    "click .end-game": "endGame"

  showUsers: ->
    App.adminRouter.controller.users()

  showMessages: ->
    App.adminRouter.controller.messages()

  endGame: ->
    console.log "emitting quit"
    App.socket.emit "quit", {}

module.exports = AdminIndex
