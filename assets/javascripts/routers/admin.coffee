Marionette = require("marionette")
AdminController = require("../controllers/admin.coffee")

class AdminRouter extends Marionette.AppRouter
  controller: new AdminController()
  appRoutes:
    "admin": "index"

module.exports = AdminRouter
