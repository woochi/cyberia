express = require("express")
backboneio = require("backbone.io")
passportSocketIo = require("passport.socketio")
messages = require("../controllers/messages")
users = require("../controllers/users")
posts = require("../controllers/posts")
articles = require("../controllers/articles")
events = require("../controllers/events")

module.exports = (server, passport, sessionStore, config) ->
  UserMap = require("../middleware/user_map")(sessionStore.client)

  usersBackend = backboneio.createBackend()
  postsBackend = backboneio.createBackend()
  messagesBackend = backboneio.createBackend()
  articlesBackend = backboneio.createBackend()
  eventsBackend = backboneio.createBackend()

  # Users
  usersBackend.use UserMap.populate
  usersBackend.use "read", users.read
  usersBackend.use "update", users.update

  # Posts
  postsBackend.use UserMap.populate
  postsBackend.use "read", posts.read
  postsBackend.use "create", posts.create
  postsBackend.use "delete", posts.delete

  # Messages
  messagesBackend.use UserMap.populate
  messagesBackend.use "read", messages.read
  messagesBackend.use "create", messages.create

  # Articles
  articlesBackend.use UserMap.populate
  articlesBackend.use "read", articles.read

  # Events
  eventsBackend.use UserMap.populate
  eventsBackend.use "read", events.read
  eventsBackend.use "create", events.create

  io = backboneio.listen server,
    users: usersBackend
    posts: postsBackend
    messages: messagesBackend
    articles: articlesBackend
    events: eventsBackend

  io.set "authorization", passportSocketIo.authorize(
    cookieParser: express.cookieParser
    key: config.sessionKey
    secret: config.sessionSecret
    store: sessionStore
  )

  io.on "connection", (socket) ->
    if socket.handshake.user.logged_in
      sessionStore.client.set socket.id, socket.handshake.user._id

      socket.on "disconnect", ->
        sessionStore.client.del socket.id
