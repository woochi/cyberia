Marionette = require("marionette")

class UserItem extends Marionette.ItemView
  template: require("../../templates/users/item.jade")
  tagName: "li"
  className: "user"
  events:
    "click": "openConversation"
  modelEvents:
    "change": "onRender"

  onRender: (model, changes) ->
    @$(".status-icon").toggleClass "green", @model.get("online")

  openConversation: ->
    App.messagesRouter.controller.showConversation @model.id

module.exports = UserItem
