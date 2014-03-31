Marionette = require("marionette")

class Penalty extends Marionette.ItemView
  template: require("../../templates/hacking/penalty.jade")
  id: "penalty"

module.exports = Penalty
