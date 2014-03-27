mongoose = require("mongoose")
User = mongoose.model("User")

users = require("../fixtures/users")

exports.up = (next) ->
  users = users.map (user) ->
    user.username = user.name.replace(/\s/g, "").toLowerCase()
    user.password = Math.random().toString(36).slice(2).substr(0, 6)
    user
  console.log "Creating the following users:"
  console.log users.map (user) -> "#{user.name}: #{user.username} - #{user.password}"
  User.create users, next

exports.down = (next) ->
  User.remove {}, next
