class AppController

  index: ->
    App.postsRouter.controller.index()

module.exports = AppController
