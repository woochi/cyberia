Marionette = require("marionette")

class Navigation extends Marionette.ItemView
  template: require("../../templates/sidebar/navigation.jade")
  tagName: "nav"
  id: "nav"
  events:
    "click .show-posts": "showPosts"
    "click .show-profile": "showProfile"
    "click .show-data": "showData"
    "click .show-messages": "showMessages"
    "click .show-hacking": "showHacking"
    "click .show-admin": "showAdmin"
    "click .logout": "logout"
    "click .dropdown-toggle": "toggleMenu"
    "mouseleave": "closeMenu"

  onRender: ->
    @toggleCurrent Backbone.history.fragment

  toggleCurrent: (rel) ->
    @clearCurrent()
    @$("a[rel='#{rel}']").closest("li").addClass "current"

  clearCurrent: ->
    @$("li.current").removeClass "current"

  showPosts: (e) ->
    @toggleCurrent("posts")
    App.postsRouter.controller.index()

  showData: (e) ->
    @toggleCurrent("data")
    App.dataRouter.controller.index()

  showProfile: (e) ->
    @toggleCurrent("profile")
    App.usersRouter.controller.profile()

  showHacking: (e) ->
    @toggleCurrent("hacking")
    App.hackingRouter.controller.index()

  showAdmin: (e) ->
    @toggleCurrent("admin")
    App.adminRouter.controller.index()

  logout: ->
    window.location = "/logout"

  toggleMenu: ->
    @$(".dropdown").toggleClass "open"

  closeMenu: ->
    @$(".dropdown").removeClass "open"

module.exports = Navigation
