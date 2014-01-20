Marionette = require("marionette")

class Overlay extends Marionette.ItemView
  mask: $("<div>").addClass("overlay-mask")
  container: $("<div>").addClass("overlay-container")

  open: ->
    $("body").append @mask
    @container.on "click", @_tryClose.bind(@)
    $(document).on "keyup", @_keyClose.bind(@)
    @render()

  onClose: ->
    $(document).off "keyup"
    @container.remove()
    @mask.remove()

  onRender: ->
    @container.append @$el.addClass("overlay-content")
    $("body").append @container

  _tryClose: (e) ->
    @close() if $(e.target).is(".overlay-container")

  _keyClose: (e) ->
    @close() if e.keyCode is 27

module.exports = Overlay
