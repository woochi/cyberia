Marionette = require("marionette")

class AdminIndex extends Marionette.ItemView
  template: require("../../templates/admin/index.jade")
  id: "admin"

module.exports = AdminIndex
