class HackingController

  index: ->
    App.content.close()
    App.appRouter.navigate "hacking"

module.exports = HackingController
