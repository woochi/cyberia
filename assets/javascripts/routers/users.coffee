Marionette = require("marionette")
UsersController = require("../controllers/users.coffee")

class UsersRouter extends Marionette.AppRouter
  controller: new UsersController()
  appRoutes:
    "profile": "profile"

module.exports = UsersRouter
