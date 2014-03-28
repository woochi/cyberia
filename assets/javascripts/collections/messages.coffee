Backbone = require("backbone")

class Messages extends Backbone.Collection
  model: require("../models/message.coffee")
  backend: "messages"

  initialize: (models, opts) ->
    @from = opts.from
    @to = opts.to
    names = [@from.get("username"), @to.get("username")]
    @backend.channel = names.sort().join "/"

module.exports = Messages
