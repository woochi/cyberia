Marionette = require("marionette")

class MessageList extends Marionette.CollectionView
  itemView: require("./item.coffee")
  tagName: "ul"
  className: "message-list"

module.exports = MessageList
