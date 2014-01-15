Marionette = require("marionette")

class PostsList extends Marionette.CompositeView
  template: require("../../templates/posts/list.jade")
  itemViewContainer: "#post-list"
  itemView: require("./item.coffee")
  emptyView: require("./empty.coffee")
  id: "posts"

  onBeforeItemAdded: (itemView) ->
    itemView.$el.addClass "animate-in"

module.exports = PostsList
