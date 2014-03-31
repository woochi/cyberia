class HackingController

  index: ->
    KeyForm = require("../views/hacking/form.coffee")
    App.content.show new KeyForm()
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

  puzzle: (code) ->
    Puzzle = require("../views/hacking/puzzle.coffee")
    App.content.show new Puzzle(model: code)
    App.appRouter.navigate "hacking/puzzle/#{code.key}"

  reward: (code) ->
    Reward = require("./reward.coffee")
    App.content.show new Reward(model: @model)

  penalty: (code) ->
    Penalty = require("./penalty.coffee")
    App.content.show new Penalty(model: @model)

module.exports = HackingController
