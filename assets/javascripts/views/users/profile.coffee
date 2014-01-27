Marionette = require("marionette")

class Profile extends Marionette.ItemView
  template: require("../../templates/users/profile.jade")
  tagName: "article"
  className: "profile"
  events:
    "click .edit-profile": "openEdit"
    "click .cancel-edit": "toggleEdit"
    "click .save-profile": "saveProfile"
  modelEvents:
    "change:status": "renderStatus"
  ui:
    input: ".profile-status-edit"
    status: ".profile-status"

  toggleEdit: ->
    @$el.toggleClass "editing"

  openEdit: ->
    @toggleEdit()
    @ui.input.focus()

  saveProfile: ->
    @model.save
      status: @ui.input.val()
    @renderStatus()
    @toggleEdit()

  renderStatus: ->
    @ui.status.text @model.get("status")

module.exports = Profile
