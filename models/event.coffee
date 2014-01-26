mongoose = require("mongoose")
validator = require('validator')
Schema = mongoose.Schema

EVENT_TYPES = []

EventSchema = new Schema
  type: {type: String, enum: EVENT_TYPES}
  sent: {type: Date, required: true, default: Date.now}

mongoose.model "Event", EventSchema
