mongoose = require("mongoose")
User = mongoose.model("User")

users = require("../fixtures/users")

exports.up = (next) ->
  User.create users, next

exports.down = (next) ->
  User.remove users, next
