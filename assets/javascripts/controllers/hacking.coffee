class HackingController

  index: ->
    HackingTools = require("../views/hacking/tools.coffee")
    App.content.show new HackingTools()
    App.appRouter.navigate "hacking"

  level: ->
    GameView = require("../views/hacking/game.coffee")
    Navigation = require("../views/sidebar/navigation.coffee")
    UserList = require("../views/users/list.coffee")
    App.sidebar.close()
    App.additional.close()
    gameView = new GameView()
    gameView.on "close", ->
      App.sidebar.show new Navigation(model: App.user)
      App.additional.show new UserList(collection: App.users)
    App.content.show gameView
    App.appRouter.navigate "hacking/level"

  search: (query) ->
    HeaderContentLayout = require("../views/layouts/search_results.coffee")
    Search = require("../views/hacking/search.coffee")
    Results = require("../views/hacking/results.coffee")
    Articles = require("../collections/articles.coffee")
    articles = new Articles()
    articles.fetch()
    layout = new HeaderContentLayout()
    App.content.show layout
    layout.search.show new Search()
    layout.results.show new Results()
    App.appRouter.navigate "hacking/search"
    
  block: ->
    App.appRouter.navigate "hacking/block"

  code: ->
    App.appRouter.navigate "hacking/code"

module.exports = HackingController
