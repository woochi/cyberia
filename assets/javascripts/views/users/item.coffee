Marionette = require("marionette")

class UserItem extends Marionette.ItemView
  template: require("../../templates/users/item.jade")
  tagName: "li"
  className: "user"

module.exports = UserItem
