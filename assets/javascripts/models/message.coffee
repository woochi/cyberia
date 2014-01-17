Backbone = require("backbone")
User = require("./user.coffee")

class Message extends Backbone.Model
  idAttribute: "_id"
  defaults:
    from: new User()
    to: new User()
    sent: new Date()

module.exports = Message
