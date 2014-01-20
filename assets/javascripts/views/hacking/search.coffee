Marionette = require("marionette")

class Search extends Marionette.ItemView
  template: require("../../templates/hacking/search.jade")
  tagName: "form"
  className: "search-form"

module.exports = Search
