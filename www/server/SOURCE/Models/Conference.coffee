mongoose = require  "mongoose"
Schema = mongoose.Schema

ConferenceSchema = Schema
  _orga:
    type: Schema.Types.ObjectId
    ref: 'Organisation'
  name: String
  date: Date

module.exports= mongoose.model 'Conference', ConferenceSchema, 'conferences'