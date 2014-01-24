class MessagesController

  index: ->
    User = require("../models/user.coffee")
    Users = require("../collections/users.coffee")
    UserList = require("../views/users/list.coffee")
    Messages = require("../collections/messages.coffee")
    MessageCenter = require("../views/messages/center.coffee")
    center = new MessageCenter(collection: new Messages())
    center.on "close", -> App.additional.close()
    App.content.show center
    App.additional.show new UserList(collection: App.users)
    App.appRouter.navigate "messages"

  showConversation: (userId) ->
    User = require("../models/user.coffee")
    Users = require("../collections/users.coffee")
    UserList = require("../views/users/list.coffee")
    ChatLayout = require("../views/layouts/chat.coffee")
    MessageList = require("../views/messages/list.coffee")
    MessageForm = require("../views/messages/form.coffee")
    Messages = require("../collections/messages.coffee")
    Message = require("../models/message.coffee")
    MessageCenter = require("../views/messages/center.coffee")

    layout = new ChatLayout()
    messages = new Messages((new Message() for i in [0..10]))
    messages.at(5).set "from", App.user.toJSON()
    message = new Message()
    messageList = new MessageList(collection: messages)
    messageList.on "close", -> App.additional.close()

    App.content.show layout
    App.additional.show new UserList(collection: App.users)
    layout.list.show messageList
    layout.form.show new MessageForm(model: message)

    App.appRouter.navigate "messages/#{userId}"

module.exports = MessagesController
