class Code extends Backbone.Model
  backend: "codes"
  idAttribute: "_id"
  defaults:
    key: "x"
    difficulty: "easy"
    value: "x"

module.exports = Code
