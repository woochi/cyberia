Marionette = require("marionette")
HackingController = require("../controllers/hacking.coffee")

class HackingRouter extends Marionette.AppRouter
  controller: new HackingController()
  appRoutes:
    "hacking": "index"

module.exports = HackingRouter
