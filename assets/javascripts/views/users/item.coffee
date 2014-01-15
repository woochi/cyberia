Marionette = require("marionette")

class UserItem extends Marionette.ItemView
  template: require("../../templates/users/item.jade")
  tagName: "li"
  className: "user"
  events:
    "click": "openConversation"

  openConversation: ->
    App.messagesRouter.controller.showConversation @model.id

module.exports = UserItem
