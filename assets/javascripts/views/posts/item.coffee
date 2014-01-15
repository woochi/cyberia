Marionette = require("marionette")
moment = require("moment")

class PostItem extends Marionette.ItemView
  template: require("../../templates/posts/item.jade")
  tagName: "li"
  className: "post"

  initialize: (opts, attrs) ->
    super
    @updater = setInterval =>
      @updateTimestamp()
    , 60*1000

  serializeData: ->
    if @model.get("attachment")?
      _.extend @model.toJSON(),
        sent: moment(@model.get("sent")).fromNow(true)
        attachment: @model.get("attachment").toJSON()
    else
      _.extend @model.toJSON(),
        sent: moment(@model.get("sent")).fromNow(true)

  updateTimestamp: ->
    @$(".post-timestamp .time").text moment(@model.get("sent")).fromNow(true)

  onClose: ->
    clearInterval @updater

module.exports = PostItem
