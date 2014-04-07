class AppController

  index: ->
    App.usersRouter.controller.profile()

module.exports = AppController
