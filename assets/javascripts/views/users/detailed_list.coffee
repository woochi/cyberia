Marionette = require("marionette")

class DetailedUserList extends Marionette.CollectionView
  className: "user-list"
  itemView: require("./detailed_item.coffee")

module.exports = DetailedUserList
