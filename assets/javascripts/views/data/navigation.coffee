Marionette = require("marionette")

class DataNavigation extends Marionette.ItemView
  template: require("../../templates/data/navigation.jade")
  tagName: "nav"
  id: "data-nav"
  events:
    "click .show-timeline": "showTimeline"
    "click .show-news": "showNews"

  onRender: ->
    @toggleCurrent Backbone.history.fragment.split("/")[1]

  toggleCurrent: (rel) ->
    @clearCurrent()
    @$("a[rel='#{rel}']").closest("li").addClass "current"

  clearCurrent: ->
    @$("li.current").removeClass "current"

  showTimeline: ->
    @toggleCurrent "timeline"
    App.dataRouter.controller.timeline()

  showNews: ->
    @toggleCurrent "news"
    App.dataRouter.controller.news()

module.exports = DataNavigation
