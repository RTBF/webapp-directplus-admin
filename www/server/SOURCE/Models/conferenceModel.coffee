mongoose = require  "mongoose"
Schema = mongoose.Schema


ConferenceSchema = new mongoose.Schema
  _orga:
    type: Schema.Types.ObjectId
    ref: 'Organisation'
  name: String
  date: Date
  slides: [
    type: Schema.Types.ObjectId
    ref: 'Slide'
    ]

modules.exports= mongoose.model 'Conference', ConferenceSchema, 'conferences'
