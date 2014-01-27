Marionette = require("marionette")

class DetailedUserItem extends Marionette.ItemView
  template: require("../../templates/users/detailed_item.jade")
  tagName: "li"
  className: "detailed-user"

module.exports = DetailedUserItem
