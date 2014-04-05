Backbone = require("backbone")
User = require("./user.coffee")

class Message extends Backbone.Model
  idAttribute: "_id"
  defaults:
    from: new User().toJSON()
    to: new User().toJSON()
    sent: new Date().toUTCString()
    text: "No content available"

module.exports = Message
