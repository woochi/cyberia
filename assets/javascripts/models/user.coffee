Backbone = require("backbone")

class User extends Backbone.Model
  idAttribute: "_id"
  defaults:
    admin: false
    name: "Anonymous"
    status: ""
    group: "Archangels"
    class: "Decker"
    level: "A"
    disabled: false

  isAdmin: ->
    @get("admin")

module.exports = User
