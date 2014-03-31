Backbone = require("backbone")
Unread = require("../models/unread.coffee")

class Unreads extends Backbone.Collection
  model: Unread

  initialize: (unreads, opts) ->
    @listenTo opts.messages, "backend:create", (message) ->
      if message.to._id is App.user.id
        model = @get message.from._id
        if not model
          model = new Unread()
          @add model
        model.set "value", model.get("value") + 1

    @listenTo opts.messages, "backend:update", (message) ->
      console.log "UPDATE", message
      if message.to._id is App.user.id
        model = @get message.from._id
        if not model
          model = new Unread()
          @add model
        model.set "value", model.get("value") - 1

module.exports = Unreads
