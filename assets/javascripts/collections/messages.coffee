Backbone = require("backbone")

class Messages extends Backbone.Collection
  model: require("../models/message.coffee")
  backend: "messages"

module.exports = Messages
