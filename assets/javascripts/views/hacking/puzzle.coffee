Marionette = require("marionette")

class Puzzle extends Marionette.ItemView
  template: require("../../templates/hacking/puzzle.jade")
  id: "puzzle"
  ui:
    table: ".puzzle-table"
  events:
    "click .show-success": "onSuccess"
    "click .show-failure": "onFailure"

  initialize: ->
    console.log "Puzzle for", @model.get("key")
    Sudoku = require("sudoku")
    @puzzle = new Sudoku()
    # @puzzle.checkVal, @puzzle.setVal

  onRender: ->
    puzzle = @puzzle
    @ui.table.find("tr").each (row, el) ->
      $(el).find("td").each (col, el) ->
        $(el).text puzzle.getVal(row, col)

  timeLimit: ->
    limit = switch @model.get("difficulty")
      when 1 then 3
      when 2 then 5
      when 3 then 10
      when 4 then 0

    limit * 60 * 1000 # Minutes

  onSuccess: ->
    App.hackingRouter.controller.reward @model

  onFailure: ->
    App.hackingRouter.controller.penalty @model

module.exports = Puzzle
