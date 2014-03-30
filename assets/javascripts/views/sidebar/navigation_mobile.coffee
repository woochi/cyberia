Marionette = require("marionette")

class NavigationMobile extends Marionette.ItemView
  template: require("../../templates/sidebar/navigation.jade")
  tagName: "nav"
  id: "nav"
  events:
    "click .toggle-menu": "toggleMenu"
    "click .toggle-user-menu": "toggleUserMenu"

  toggleMenu: (e) ->
    e.stopPropagation()
    $("body").toggleClass "menu-visible"
    @bindExit()

  toggleUserMenu: (e) ->
    e.stopPropagation()
    $("body").toggleClass "user-menu-visible"
    @bindExit()

  bindExit: ->
    wrapper = $("#content-wrapper")
    wrapper.off "click", @closeMenus
    $("#content-wrapper").one "click", @closeMenus
    App.content.off "show", @closeMenus
    App.content.on "show", @closeMenus

  closeMenus: ->
    $("body").removeClass "menu-visible user-menu-visible"

module.exports = NavigationMobile
