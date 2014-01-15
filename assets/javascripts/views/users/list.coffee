Marionette = require("marionette")

class UserList extends Marionette.CompositeView
  template: require("../../templates/users/list.jade")
  itemViewContainer: "#user-list"
  itemView: require("./item.coffee")
  id: "users"

module.exports = UserList
