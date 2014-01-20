Marionette = require("marionette")
HackingController = require("../controllers/hacking.coffee")

class HackingRouter extends Marionette.AppRouter
  controller: new HackingController()
  appRoutes:
    "hacking": "index"
    "hacking/level": "level"
    "hacking/search": "search"
    "hacking/search/:query": "search"
    "hacking/block": "block"
    "hacking/code": "code"

module.exports = HackingRouter
