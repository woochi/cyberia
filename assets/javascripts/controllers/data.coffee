class DataController

  renderLayout: ->
    NavigationLayout = require("../views/layouts/navigation_layout.coffee")
    DataNavigation = require("../views/data/navigation.coffee")
    @layout = new NavigationLayout()
    App.content.show @layout
    @layout.navigation.show new DataNavigation()

  index: ->
    @news()

  timeline: ->
    App.appRouter.navigate "data/timeline"
    @renderLayout()
    Timeline = require("../views/data/timeline.coffee")
    @layout.content.show new Timeline()

  news: ->
    App.appRouter.navigate "data/news"
    @renderLayout()
    Loader = require("../views/shared/loader.coffee")
    ArticleList = require("../views/data/article_list.coffee")
    Articles = require("../collections/articles.coffee")
    articles = new Articles()
    @layout.content.show new Loader()
    articles.fetch
      success: (collection) =>
        @layout.content.show new ArticleList(collection: articles)
      error: (err) -> console.error err

  showArticle: (id) ->
    App.appRouter.navigate "data/news/#{id}"
    @renderLayout()
    Article = require("../models/article.coffee")
    ArticleView = require("../views/data/article.coffee")
    article = new Article(id: id)
    article.fetch()
    @layout.content.show new ArticleView(model: article)

module.exports = DataController
