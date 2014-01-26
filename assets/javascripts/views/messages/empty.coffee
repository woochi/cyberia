Marionette = require("marionette")

class EmptyMessageList extends Marionette.ItemView
  template: require("../../templates/messages/empty.jade")
  tagName: "li"
  className: "empty-message"

module.exports = EmptyMessageList
