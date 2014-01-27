Backbone = require("backbone")

class User extends Backbone.Model
  backend: "users"
  idAttribute: "_id"
  defaults:
    admin: false
    name: "Anonymous"
    status: ""
    group: "Archangels"
    class: "Decker"
    level: "A"

  isAdmin: ->
    @get("admin")

module.exports = User
