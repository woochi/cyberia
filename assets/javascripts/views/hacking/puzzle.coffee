Marionette = require("marionette")
ValuePicker = require("./value_picker.coffee")

class Puzzle extends Marionette.ItemView
  @CLOCK_INTERVAL: 1000
  template: require("../../templates/hacking/puzzle.jade")
  id: "puzzle"
  ui:
    table: ".puzzle-table"
    clockValue: ".clock-value"
    disconnect: ".disconnect"
  events:
    "click .show-success": "onSuccess"
    "click .show-failure": "onFailure"
    "click .puzzle-cell": "showPicker"
    "click .clear-cell": "clearCell"

  initialize: ->
    Sudoku = require("sudoku")
    @puzzle = new Sudoku()
    @puzzle.level = @model.get("difficulty")
    @puzzle.newGame()
    @startTime = localStorage.getItem "cb-#{@model.id}"
    if not @startTime
      @startTime = new Date().getTime()
      localStorage.setItem "cb-#{@model.id}", @startTime
    @endTime = parseInt(@startTime) + @model.timeLimit()
    @onFailure() if @endTime - new Date().getTime() < 0
    @clock = @startClock()

  startClock: ->
    setInterval @updateClock, Puzzle.CLOCK_INTERVAL

  updateClock: =>
    if @endTime - new Date().getTime() < 0
      clearInterval @clock
      @onFailure()
    @ui.clockValue.text @formatRemainingTime()

  formatRemainingTime: ->
    remaining = @endTime - new Date().getTime()
    Math.floor(remaining / 1000) + "s"

  serializeData: ->
    admin: App.user.isAdmin()
    time: @formatRemainingTime()

  onRender: ->
    puzzle = @puzzle
    @ui.table.find("tr").each (row, el) ->
      $(el).find("td").each (col, el) ->
        value = puzzle.getVal(row, col)
        unless value is 0
          $(el).addClass("disabled").find(".value").text value

  showPicker: (e) ->
    el = $(e.target)
    return if el.is ".disabled"
    if el.is ".puzzle-cell"
      e.stopImmediatePropagation()
      row = el.data("row")
      col = el.data("col")
      available = []
      puzzle = @puzzle
      puzzle.getAvailable @puzzle.matrix, row * 9 + col, available
      picker = new ValuePicker(available: available)
      @listenTo picker, "pick", (value) ->
        puzzle.setVal row, col, value
      el.append picker.render().$el
    else
      parent = el.closest(".puzzle-cell")
      row = parent.data("row")
      col = parent.data("col")
      value = el.data("cell")
      @puzzle.setVal row, col, value
      parent.removeClass("empty").find(".value").text value
      @onSuccess() if @puzzle.gameFinished()

  clearCell: (e) ->
    e.stopImmediatePropagation()
    el = $(e.target).closest(".puzzle-cell")
    row = el.data("row")
    col = el.data("col")
    @puzzle.setVal row, col, 0
    el.addClass("empty").find(".value").text ""

  onSuccess: ->
    App.hackingRouter.controller.reward @model

  onFailure: ->
    App.hackingRouter.controller.penalty @model

module.exports = Puzzle
