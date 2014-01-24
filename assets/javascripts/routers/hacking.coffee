Marionette = require("marionette")
HackingController = require("../controllers/hacking.coffee")

class HackingRouter extends Marionette.AppRouter
  controller: new HackingController()
  appRoutes:
    "hacking/search/:query": "search"
    "hacking/level": "level"
    "hacking/search": "search"
    "hacking/block": "block"
    "hacking/code": "code"
    "hacking": "index"

module.exports = HackingRouter
