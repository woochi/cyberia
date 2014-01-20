Marionette = require("marionette")

class Results extends Marionette.CollectionView
  tagName: "ul"
  className: "search-results"

module.exports = Results
