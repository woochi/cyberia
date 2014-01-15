Marionette = require("marionette")

class UserList extends Marionette.CollectionView
  itemView: require("./item.coffee")
  tagName: "ul"
  id: "user-list"

module.exports = UserList
