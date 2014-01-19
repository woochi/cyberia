Marionette = require("marionette")

class PostsList extends Marionette.CompositeView
  template: require("../../templates/posts/list.jade")
  itemViewContainer: "#post-list"
  itemView: require("./item.coffee")
  emptyView: require("./empty.coffee")
  id: "posts"
  events:
    "click .new-post": "showForm"

  onRender: ->
    @off "after:item:added", @animateInView
    @on "after:item:added", @animateInView

  onClose: ->
    @off "after:item:added", @animateInView

  animateInView: (itemView) ->
    itemView.$el.addClass "fade-in-right"

  showForm: ->
    App.postsRouter.controller.new()
  
  appendHtml: (compositeView, itemView, index) ->
    if compositeView.isBuffering
      compositeView.elBuffer.appendChild itemView.el
      compositeView._bufferedChildren.push itemView
    else
      # If we've already rendered the main collection, just
      # append the new items directly into the element.
      $container = @getItemViewContainer(compositeView)
      $container.prepend itemView.el

module.exports = PostsList
