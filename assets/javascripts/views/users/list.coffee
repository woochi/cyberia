Marionette = require("marionette")

class UserList extends Marionette.CompositeView
  template: require("../../templates/users/list.jade")
  itemViewContainer: "#user-list"
  itemView: require("./item.coffee")
  id: "users"
  collectionEvents:
    "change:online": "render"

  initialize: (opts) ->
    @listenTo opts.unreads, "change:value", @setUnread

  toggleCurrent: (model) ->
    @clearCurrent()
    @children.findByModel(model).$el.addClass "current"

  clearCurrent: ->
    @$(".user.current").removeClass "current"

  setUnread: (unread) =>
    @children.findByModel(App.users.get(unread.id)).setUnread unread

  onBeforeRender: ->
    @collection.sort()

  onRender: ->
    App.unreads.each @setUnread.bind(@)

module.exports = UserList
