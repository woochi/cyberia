Marionette = require("marionette")

class Reward extends Marionette.ItemView
  template: require("../../templates/hacking/reward.jade")
  id: "reward"

module.exports = Reward
