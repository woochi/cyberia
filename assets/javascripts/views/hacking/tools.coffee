Marionette = require("marionette")

class HackingTools extends Marionette.ItemView
  template: require("../../templates/hacking/tools.jade")
  id: "tools"
  tagName: "article"
  events:
    "click .tool-link": "openTool"

  openTool: (e) ->
    App.hackingRouter.controller[$(e.target).closest("a").attr("rel")]()

module.exports = HackingTools
