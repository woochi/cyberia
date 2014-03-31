Marionette = require("marionette")

class UserList extends Marionette.CompositeView
  template: require("../../templates/users/list.jade")
  itemViewContainer: "#user-list"
  itemView: require("./item.coffee")
  id: "users"

  initialize: (opts) ->
    @listenTo opts.unreads, "change:value", @setUnread

  toggleCurrent: (model) ->
    @clearCurrent()
    @children.findByModel(model).$el.addClass "current"

  clearCurrent: ->
    @$(".user.current").removeClass "current"

  setUnread: (unread) ->
    @children.findByModel(App.users.get(unread.id)).setUnread unread

  onRender: ->
    App.unreads.each @setUnread.bind(@)

module.exports = UserList
