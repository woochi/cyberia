Marionette = require("marionette")
moment = require("moment")

class PostItem extends Marionette.ItemView
  template: require("../../templates/posts/item.jade")
  tagName: "li"
  className: "post"
  events:
    "click .dropdown-toggle": "toggleMenu"
    "mouseleave": "closeMenu"
    "click .delete-post": "deletePost"

  initialize: (opts, attrs) ->
    super
    @updater = setInterval =>
      @updateTimestamp()
    , 60*1000

  serializeData: ->
    if @model.get("attachment")?
      _.extend @model.toJSON(),
        sent: moment(@model.get("sent")).fromNow(true)
        canDelete: @model.get("author")._id is App.user.id or App.user.isAdmin()
        attachment: @model.get("attachment").toJSON()
    else
      _.extend @model.toJSON(),
        canDelete: @model.get("author")._id is App.user.id or App.user.isAdmin()
        sent: moment(@model.get("sent")).fromNow(true)

  updateTimestamp: ->
    @$(".post-timestamp .time").text moment(@model.get("sent")).fromNow(true)

  onRender: ->
    if @model.get("author")._id is App.user.id or App.user.isAdmin()
      @$el.addClass("self")

  onClose: ->
    clearInterval @updater

  toggleMenu: ->
    @$(".dropdown").toggleClass "open"

  closeMenu: ->
    @$(".dropdown").removeClass "open"

  deletePost: ->
    @model.destroy()

module.exports = PostItem
