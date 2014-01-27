class AdminController

  index: ->
    AdminIndex = require("../views/admin/index.coffee")
    App.content.show new AdminIndex()
    App.appRouter.navigate "admin"

  users: ->
    SearchResultsLayout = require("../views/layouts/search_results.coffee")
    DetailedUserList = require("../views/users/detailed_list.coffee")
    layout = new SearchResultsLayout()

    App.content.show layout
    layout.results.show new DetailedUserList(collection: App.users)
    App.appRouter.navigate "admin/users"

  messages: (a, b) ->
    Messages = require("../collections/messages.coffee")
    Message = require("../models/message.coffee")
    ChatLayout = require("../views/layouts/chat.coffee")
    ConversationSelector = require("../views/admin/conversation_selector.coffee")
    MessageList = require("../views/messages/list.coffee")

    if not (a and b)
      a = App.users.at(0)
      b = App.users.at(1)
    else
      a = App.users.get(a)
      b = App.users.get(b)
    console.log "selected", a, b
    messages = new Messages()
    message = new Message(from: a, to: b)
    layout = new ChatLayout()
  
    App.content.show layout
    layout.header.show new ConversationSelector(model: message, collection: App.users)
    layout.list.show new MessageList(collection: messages)
    messages.fetch
      from: a.id
      to: b.id
      error: (collection, response) -> console.error response.error.message
    App.appRouter.navigate "admin/messages/#{a.id}/#{b.id}"

module.exports = AdminController
