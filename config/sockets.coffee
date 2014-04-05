express = require("express")
backboneio = require("backbone.io")
passportSocketIo = require("passport.socketio")
messages = require("../controllers/messages")
users = require("../controllers/users")
posts = require("../controllers/posts")
articles = require("../controllers/articles")
events = require("../controllers/events")
codes = require("../controllers/codes")
auth = require("../middleware/authorization")

mongoose = require("mongoose")
User = mongoose.model("User")

module.exports = (server, passport, sessionStore, redisClient, config) ->

  usersBackend = backboneio.createBackend()
  postsBackend = backboneio.createBackend()
  messagesBackend = backboneio.createBackend()
  articlesBackend = backboneio.createBackend()
  eventsBackend = backboneio.createBackend()
  codesBackend = backboneio.createBackend()

  io = backboneio.listen server,
    users: usersBackend
    posts: postsBackend
    messages: messagesBackend
    articles: articlesBackend
    events: eventsBackend
    codes: codesBackend

  UserMap = require("../middleware/user_map")(server, io, redisClient)

  # Users
  usersBackend.use UserMap.populate
  usersBackend.use "read", auth.user.canRead
  usersBackend.use "read", users.read
  usersBackend.use "update", auth.user.canUpdate
  usersBackend.use "update", users.update

  # Posts
  postsBackend.use UserMap.populate
  postsBackend.use "read", auth.post.canRead
  postsBackend.use "read", posts.read
  postsBackend.use "create", auth.post.canCreate
  postsBackend.use "create", posts.create
  postsBackend.use "delete", auth.post.canDelete
  postsBackend.use "delete", posts.delete

  # Messages
  messagesBackend.use UserMap.populate
  messagesBackend.use "read", auth.message.canRead
  messagesBackend.use "read", messages.read
  messagesBackend.use "create", auth.message.canCreate
  #messagesBackend.use "create", UserMap.mapReceiver
  messagesBackend.use "create", messages.create
  messagesBackend.use "update", messages.update

  # Articles
  articlesBackend.use UserMap.populate
  #articlesBackend.use "read", auth.article.canRead
  articlesBackend.use "read", articles.read

  # Events
  eventsBackend.use UserMap.populate
  eventsBackend.use "read", auth.event.canRead
  eventsBackend.use "read", events.read
  eventsBackend.use "create", auth.event.canCreate
  eventsBackend.use "create", events.create

  # Events
  codesBackend.use UserMap.populate
  codesBackend.use "read", codes.read

  io.set "authorization", passportSocketIo.authorize(
    cookieParser: express.cookieParser
    secret: config.sessionSecret
    store: sessionStore
  )

  io.on "connection", (socket) ->
    if socket.handshake.user.logged_in
      userId = socket.handshake.user._id
      redisClient.set socket.id, userId
      redisClient.set userId, socket.id
      User.findByIdAndUpdate userId,
        online: true
      , (err, user) ->
        usersBackend.emit "updated", {_id: user._id, online: true}

      socket.on "disconnect", ->
        redisClient.del socket.id
        redisClient.del userId
        User.findByIdAndUpdate userId,
          online: false
        , (err, user) ->
          usersBackend.emit "updated", {_id: user._id, online: false}
