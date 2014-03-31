Backbone = require("backbone")

class Code extends Backbone.Model
  backend: "codes"
  idAttribute: "key"

  timeLimit: ->
    limit = switch @model.get("difficulty")
      when 1 then 3
      when 2 then 5
      when 3 then 10
      when 4 then 0

    limit * 60 * 1000 # Minutes

module.exports = Code
