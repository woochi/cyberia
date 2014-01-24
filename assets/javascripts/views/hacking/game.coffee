Marionette = require("marionette")

class GameView extends Marionette.ItemView
  template: require("../../templates/hacking/game.jade")
  id: "game"
  events:
    "click #disconnect": "showTools"

  showTools: ->
    App.hackingRouter.controller.index()

module.exports = GameView
