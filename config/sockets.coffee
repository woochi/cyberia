backboneio = require("backbone.io")
users = require("../controllers/users")
posts = require("../controllers/posts")
messages = require("../controllers/messages")

module.exports = (server, passport) ->

  usersBackend = backboneio.createBackend()
  postsBackend = backboneio.createBackend()
  messagesBackend = backboneio.createBackend()

  # TODO: Access control

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

  backboneio.listen server,
    users: usersBackend
    posts: postsBackend
    messages: messagesBackend
