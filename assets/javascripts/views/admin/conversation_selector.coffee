Marionette = require("marionette")

class ConversationSelector extends Marionette.ItemView
  template: require("../../templates/admin/conversation_selector.jade")
  tagName: "form"
  id: "conversation-selector"
  ui:
    from: "select.from"
    to: "select.to"
  events:
    "change select.from, select.to": "changeConversation"

  serializeData: ->
    users: @collection.toJSON()

  onRender: ->
    @ui.from.find("option[value='#{@model.get("from").id}']")
      .prop "selected", true
    @ui.to.find("option[value='#{@model.get("to").id}']")
      .prop "selected", true

  changeConversation: ->
    from = @ui.from.find("option:selected").val()
    to = @ui.to.find("option:selected").val()
    App.adminRouter.controller.messages from, to

module.exports = ConversationSelector
