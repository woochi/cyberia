Backbone = require("backbone")

class User extends Backbone.Model
  urlRoot: "/users"
  defaults:
    name: "John doe"
    groups: ["Unknown"]

module.exports = User
