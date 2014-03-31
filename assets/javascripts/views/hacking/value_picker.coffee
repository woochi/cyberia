Marionette = require("marionette")

class ValuePicker extends Marionette.ItemView
  template: require("../../templates/hacking/value_picker.jade")
  tagName: "table"
  className: "value-picker"
  events:
    "click .picker-cell": "triggerPick"

  initialize: (opts) ->
    @available = opts.available

  onRender: ->
    $(document).click @close.bind(@)
    @$("td").prop "disabled", true
    @available.forEach (value) =>
      @$("td:contains(#{value})").removeClass "disabled"

module.exports = ValuePicker
