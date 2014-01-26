mongoose = require("mongoose")
validator = require('validator')
Schema = mongoose.Schema

EVENT_TYPES = []

EventSchema = new Schema
  type: {type: String, enum: EVENT_TYPES, required: true}
  sent: {type: Date, default: Date.now, required: true}

mongoose.model "Event", EventSchema
