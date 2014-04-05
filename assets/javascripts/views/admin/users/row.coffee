Marionette = require("marionette")

class AdminUserRow extends Marionette.ItemView
  template: require("../../../templates/admin/users/row.jade")
  tagName: "tr"
  events:
    "click .disable-user": "disable"
    "click .enable-user": "enable"
  modelEvents:
    "change": "render"

  onRender: ->
    @$el.toggleClass "disabled", @model.get("disabled")

  disable: ->
    @model.save disabled: true

  enable: ->
    @model.save disabled: false

module.exports = AdminUserRow
