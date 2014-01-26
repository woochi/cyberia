Marionette = require("marionette")

class MessageList extends Marionette.CollectionView
  itemView: require("./item.coffee")
  emptyView: require("./empty.coffee")
  tagName: "ul"
  className: "message-list"

  showEmptyView: ->
    EmptyView = @getEmptyView()

    if EmptyView && !@._showingEmptyView
      @_showingEmptyView = true
      @addItemView @model, EmptyView, 0

  animateInView: (itemView) ->
    itemView.$el.addClass "fade-in-right"

  onAfterItemAdded: (itemView) ->
    @animateInView(itemView)
    @scrollDown()

  scrollDown: ->
    wrapper = @$el.closest("#list-wrapper")
    padding = parseInt(@$el.css("padding-bottom"))
    wrapper.scrollTop(@el.scrollHeight + padding)

module.exports = MessageList
