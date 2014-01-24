Marionette = require("marionette")

class Navigation extends Marionette.ItemView
  template: require("../../templates/sidebar/navigation.jade")
  tagName: "nav"
  id: "nav"
  events:
    "click .show-posts": "showPosts"
    "click .show-profile": "showProfile"
    "click .show-messages": "showMessages"
    "click .show-hacking": "showHacking"
    "click .show-discussions": "showDiscussions"
    "click .show-admin": "showAdmin"
    "click #logout-button": "logout"

  onRender: ->
    @setCurrent @$("a[rel='#{Backbone.history.fragment}']")[0]

  setCurrent: (target) ->
    @$("li.current").removeClass "current"
    $(target).closest("li").addClass "current"

  showPosts: (e) ->
    @setCurrent(e.target)
    App.postsRouter.controller.index()

  showProfile: (e) ->
    @setCurrent(e.target)
    App.usersRouter.controller.profile()

  showMessages: (e) ->
    @setCurrent(e.target)
    App.messagesRouter.controller.index()

  showHacking: (e) ->
    @setCurrent(e.target)
    App.hackingRouter.controller.index()

  showDiscussions: (e) ->
    @setCurrent(e.target)
    App.messagesRouter.controller.index()

  showAdmin: (e) ->
    @setCurrent(e.target)
    App.adminRouter.controller.index()

  logout: ->
    window.location = "/logout"

module.exports = Navigation
