mongoose = require  "mongoose"
Schema = mongoose.Schema


SlideSchema = Schema '_type'
    _conf:
      type: Schema.Types.ObjectId
      ref: 'Conference'
    type: String
    Title: String
    Description: String
    Order: Number
    JsonData:String

module.exports= mongoose.model 'Slide', SlideSchema , 'slides'