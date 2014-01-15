class UsersController

  profile: ->
    Profile = require("../views/users/profile.coffee")
    App.content.show new Profile(model: App.user)
    App.appRouter.navigate "profile"

module.exports = UsersController
