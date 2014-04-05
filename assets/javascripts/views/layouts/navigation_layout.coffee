Marionette = require("marionette")

class NavigationLayout extends Marionette.Layout
  template: require("../../templates/layouts/navigation_layout.jade")
  id: "nav-layout"
  regions:
    navigation: ".navigation"
    content: ".content"

module.exports = NavigationLayout
