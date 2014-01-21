Marionette = require("marionette")
moment = require("moment")

class MessageItem extends Marionette.ItemView
  template: require("../../templates/messages/item.jade")
  tagName: "li"
  className: "message"

  initialize: (opts, attrs) ->
    super
    @updater = setInterval =>
      @updateTimestamp()
    , 60*1000

  serializeData: ->
    _.extend @model.toJSON(),
        sent: moment(@model.get("sent")).fromNow(true)

  updateTimestamp: ->
    @$(".post-timestamp .time").text moment(@model.get("sent")).fromNow(true)

  onRender: ->
    @$el.addClass("self") if @model.get("from")._id is App.user.id

  onClose: ->
    clearInterval @updater

module.exports = MessageItem
