Backbone = require("backbone")

class User extends Backbone.Model
  idAttribute: "_id"
  backend: "users"
  defaults:
    admin: false
    name: "Anonymous"
    class: "Decker"
    level: "A"
    disabled: false

  isAdmin: ->
    @get("admin")

module.exports = User
