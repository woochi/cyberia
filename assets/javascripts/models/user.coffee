Backbone = require("backbone")

class User extends Backbone.Model
  idAttribute: "_id"
  defaults:
    admin: false
    name: "Anonymous"
    status: "Cyberspace. A consensual hallucination experienced daily by billions of legitimate operators, in every nation, by children being taught mathematical concepts... A graphic representation of data abstracted from banks of every computer in the human system. Unthinkable complexity. Lines of light ranged in the nonspace of the mind, clusters and constellations of data. Like city lights, receding...\n\nIf you want fun call +358400591230..."
    group: "Archangels"
    class: "Decker"
    level: "A"

  isAdmin: ->
    @get("admin")

module.exports = User
