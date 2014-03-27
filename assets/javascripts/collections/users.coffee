Backbone = require("backbone")

class Users extends Backbone.Collection
  model: require("../models/user.coffee")
  backend: "users"
  comparator: (a, b) ->
    ao = a.get("online")
    bo = b.get("online")
    if ao and bo
      order = if a.get("name") > b.get("name") then -1 else -1
    return -1 if ao and not bo
    return 1 if not ao and bo

  initialize: ->
    @bindBackend()

module.exports = Users
