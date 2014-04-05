Marionette = require("marionette")

class AdminUserTable extends Marionette.CompositeView
  template: require("../../../templates/admin/users/table.jade")
  tagName: "table"
  itemViewContainer: "tbody"
  itemView: require("./row.coffee")

module.exports = AdminUserTable
