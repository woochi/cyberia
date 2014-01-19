class HackingController

  index: ->
    HackingTools = require("../views/hacking/tools.coffee")
    App.content.show new HackingTools()
    App.appRouter.navigate "hacking"

  level: ->
    App.appRouter.navigate "hacking/level"

  search: ->
    App.appRouter.navigate "hacking/search"
    
  block: ->
    App.appRouter.navigate "hacking/block"

  code: ->
    App.appRouter.navigate "hacking/code"

module.exports = HackingController
