Marionette = require("marionette")

class UserList extends Marionette.CompositeView
  template: require("../../templates/users/list.jade")
  itemViewContainer: "#user-list"
  itemView: require("./item.coffee")
  id: "users"

  toggleCurrent: (model) ->
    @clearCurrent()
    @children.findByModel(model).$el.addClass "current"

  clearCurrent: ->
    @$(".user.current").removeClass "current"

module.exports = UserList
