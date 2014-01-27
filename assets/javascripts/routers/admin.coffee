Marionette = require("marionette")
AdminController = require("../controllers/admin.coffee")

class AdminRouter extends Marionette.AppRouter
  controller: new AdminController()
  appRoutes:
    "admin/messages/:ida/:idb": "messages"
    "admin/messages": "messages"
    "admin/users": "users"
    "admin": "index"

module.exports = AdminRouter
