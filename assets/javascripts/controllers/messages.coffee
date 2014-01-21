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
    ChatLayout = require("../views/layouts/chat.coffee")
    MessageList = require("../views/messages/list.coffee")
    MessageForm = require("../views/messages/form.coffee")
    Messages = require("../collections/messages.coffee")
    Message = require("../models/message.coffee")
    layout = new ChatLayout()
    messages = new Messages((new Message() for i in [0..10]))
    messages.at(5).set "from", App.user.toJSON()
    message = new Message()

    App.content.show layout
    layout.list.show new MessageList(collection: messages)
    layout.form.show new MessageForm(model: message)

    App.appRouter.navigate "messages/#{userId}"

module.exports = MessagesController
