class MessagesController

  index: ->
    User = require("../models/user.coffee")
    Users = require("../collections/users.coffee")
    UserList = require("../views/users/list.coffee")
    users = new Users((new User() for i in [0..10]))
    App.content.close()
    App.additional.show new UserList(collection: users)
    App.appRouter.navigate "messages"

  showConversation: (userId) ->
    App.content.close()
    App.appRouter.navigate "messages/#{userId}"

module.exports = MessagesController
