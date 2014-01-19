Backbone = require("backbone")

class Messages extends Backbone.Collection
  model: require("../models/message.coffee")
  backbone: "messages"

  initialize: ->
    @bindBackend()
