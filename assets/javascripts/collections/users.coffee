Backbone = require("backbone")

class Users extends Backbone.Collection
  model: require("../models/user.coffee")
  backend: "users"

  initialize: ->
    @bindBackend()

module.exports = Users
