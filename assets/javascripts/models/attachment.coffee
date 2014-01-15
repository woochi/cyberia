Backbone = require("backbone")

class Attachment extends Backbone.Model
  defaults:
    url: "/404.jpg"
    width: 200
    height: 200

module.exports = Attachment
