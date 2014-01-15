Backbone = require("backbone")

class User extends Backbone.Model
  defaults:
    name: "John Doe"
    status: "Lorem ipsum dolor sit amet."
    group: "Archangels"
    class: "Decker"

module.exports = User
