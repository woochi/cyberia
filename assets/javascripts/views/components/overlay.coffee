Marionette = require("marionette")

class Overlay extends Marionette.ItemView
  mask: $("<div>").addClass("overlay-mask")
  container: $("<div>").addClass("overlay-container")

  open: ->
    $("body").append @mask
    @mask.on "click", @close.bind(@)
    @render()

  close: ->
    super
    @mask.off "click"
    @mask.remove()

  onRender: ->
    $("body").append @$el.addClass("overlay-content")
    @$el.wrap @container

module.exports = Overlay
