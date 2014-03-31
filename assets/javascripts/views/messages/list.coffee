Marionette = require("marionette")
Message = require("../../models/message.coffee")

class MessageList extends Marionette.CollectionView
  itemView: require("./item.coffee")
  emptyView: require("./empty.coffee")
  tagName: "ul"
  className: "message-list"
  collectionEvents:
    "backend:create": "onCreate"
    "add": "onAdd"

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

  onCreate: (response) ->
    if response.from._id is @collection.to.id and response.to._id is App.user.id
      message = new Message(response)
      @collection.add message

  onAdd: (message) ->
    message.set unread: false
    if message.hasChanged "unread"
      message.save {},
        success: ->
          unread = App.unreads.get message.get("from")
          unread.set "value", unread.get("value") - 1
        error: -> console.error "ERROR", err

module.exports = MessageList
