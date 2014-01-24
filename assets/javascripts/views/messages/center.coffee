Marionette = require("marionette")

class MessageCenter extends Marionette.CollectionView
  itemView: require("./item.coffee")

module.exports = MessageCenter
