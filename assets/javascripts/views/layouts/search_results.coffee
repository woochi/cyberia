Marionette = require("marionette")

class SearchResultsLayout extends Marionette.Layout
  template: require("../../templates/layouts/search_results.jade")
  id: "inner"
  regions:
    search: ".search-header"
    results: ".results-section"

module.exports = SearchResultsLayout
