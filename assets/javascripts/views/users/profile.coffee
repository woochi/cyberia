Marionette = require("marionette")

class Profile extends Marionette.ItemView
  template: require("../../templates/users/profile.jade")
  tagName: "article"
  className: "profile"

module.exports = Profile
