Marionette = require("marionette")

class PostsList extends Marionette.CollectionView
  itemView: require("./item.coffee")
  emptyView: require("./empty.coffee")
  tagName: "ul"
  id: "post-list"

  onBeforeItemAdded: (itemView) ->
    itemView.$el.addClass "animate-in"

module.exports = PostsList
