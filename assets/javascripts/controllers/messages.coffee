class MessagesController

  index: ->
    conversation = if @currentConversation then @currentConversation else App.users.at(0).id
    @showConversation(conversation)

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
    to = App.users.get(userId)
    messages = new Messages([], from: App.user, to: to)
    message = new Message(from: App.user, to: to)
    messageList = new MessageList(model: to, collection: messages)

    App.content.show layout
    layout.list.show messageList
    layout.form.show new MessageForm(model: message, collection: messages)

    App.sidebar.currentView.clearCurrent()
    App.additional.currentView.toggleCurrent to

    layout.once "close", ->
      App.additional.currentView.clearCurrent()

    messages.fetch
      from: App.user.id
      to: to.id
      error: (collection, response) -> console.error response.error.message
    App.appRouter.navigate "messages/#{userId}"

module.exports = MessagesController
