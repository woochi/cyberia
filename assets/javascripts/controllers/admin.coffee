class AdminController

  index: ->
    AdminIndex = require("../views/admin/index.coffee")
    App.content.show new AdminIndex()
    App.appRouter.navigate "admin"

module.exports = AdminController
