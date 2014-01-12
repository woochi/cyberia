Marionette = require("marionette")
AppController = require("../controllers/app.coffee")

class AppRouter extends Marionette.AppRouter
  controller: new AppController()
  appRoutes:
    "": "index"
    "/": "index"

module.exports = AppRouter
