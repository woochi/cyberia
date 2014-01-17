Marionette = require("marionette")

class Overlay extends Marionette.ItemView
  mask: $("<div>").addClass("overlay-mask")
  container: $("<div>").addClass("overlay-container")

  open: ->
    $("body").append @mask
    @container.on "click", @_tryClose.bind(@)
    @render()

  onClose: ->
    @container.remove()
    @mask.remove()

  onRender: ->
    @container.append @$el.addClass("overlay-content")
    $("body").append @container

  _tryClose: (e) ->
    @close() if $(e.target).is(".overlay-container")

module.exports = Overlay
