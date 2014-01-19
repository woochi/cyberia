Marionette = require("marionette")

class Profile extends Marionette.ItemView
  template: require("../../templates/users/profile.jade")
  tagName: "article"
  className: "profile"
  events:
    "click .edit-profile": "toggleEdit"
    "click .cancel-edit": "toggleEdit"

  toggleEdit: ->
    @$el.toggleClass "editing"

module.exports = Profile
