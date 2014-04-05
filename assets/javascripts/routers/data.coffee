Marionette = require("marionette")
DataController = require("../controllers/data.coffee")

class DataRouter extends Marionette.AppRouter
  controller: new DataController()
  appRoutes:
    "data": "index"
    "data/timeline": "timeline"
    "data/news": "news"
    "data/news/:id": "showArticle"

module.exports = DataRouter
