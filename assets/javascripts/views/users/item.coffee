Marionette = require("marionette")

class UserItem extends Marionette.ItemView
  template: require("../../templates/users/item.jade")
  tagName: "li"
  className: "user"
  events:
    "click": "openConversation"
  modelEvents:
    "change": "render"

  onRender: (model, changes) ->
    @$el.toggleClass "online", @model.get("online")

  openConversation: ->
    App.messagesRouter.controller.showConversation @model.id

  setUnread: (unread) ->
    value = unread.get "value"
    @$el.toggleClass "unread", value > 0
    @$(".unread-count").text value

module.exports = UserItem
