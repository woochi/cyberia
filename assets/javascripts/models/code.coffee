Backbone = require("backbone")

class Code extends Backbone.Model
  backend: "codes"
  idAttribute: "key"

module.exports = Code
