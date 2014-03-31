Backbone = require("backbone")

class Unread extends Backbone.Model
  idAttribute: "_id"
  defaults:
    value: 0

module.exports = Unread
