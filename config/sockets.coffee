express = require("express")
backboneio = require("backbone.io")
passportSocketIo = require("passport.socketio")
users = require("../controllers/users")
posts = require("../controllers/posts")
messages = require("../controllers/messages")
articles = require("../controllers/articles")
events = require("../controllers/events")

module.exports = (server, passport, sessionStore, config) ->

  usersBackend = backboneio.createBackend()
  postsBackend = backboneio.createBackend()
  messagesBackend = backboneio.createBackend()
  articlesBackend = backboneio.createBackend()
  eventsBackend = backboneio.createBackend()

  # Users
  usersBackend.use "read", users.read
  usersBackend.use "update", users.update

  # Posts
  postsBackend.use "read", posts.read
  postsBackend.use "create", posts.create
  postsBackend.use "delete", posts.delete

  # Messages
  messagesBackend.use "read", messages.read
  messagesBackend.use "create", messages.create

  # Articles
  articlesBackend.use "read", articles.read

  # Events
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
