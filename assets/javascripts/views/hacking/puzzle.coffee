Marionette = require("marionette")

class Puzzle extends Marionette.ItemView
  template: require("../../templates/hacking/puzzle.jade")
  id: "puzzle"
  events:
    "click .show-success": "onSuccess"
    "click .show-failure": "onFailure"

  initialize: ->
    console.log "Puzzle for", @model.get("key")

  timeLimit: ->
    limit = switch @model.get("difficulty")
      when "easy" then 3
      when "normal" then 5
      when "hard" then 10
      when "impossible" then 0

    limit * 60 * 1000 # Minutes

  onSuccess: ->
    App.hackingRouter.controller.reward @model

  onFailure: ->
    App.hackingRouter.controller.penalty @model

module.exports = Puzzle
