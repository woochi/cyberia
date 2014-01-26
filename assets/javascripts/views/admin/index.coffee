Marionette = require("marionette")

class AdminIndex extends Marionette.ItemView
  template: require("../../templates/admin/index.jade")
  id: "admin"
  events:
    "click .end-game": "endGame"

  endGame: ->
    console.log "emitting quit"
    App.socket.emit "quit", {}

module.exports = AdminIndex
