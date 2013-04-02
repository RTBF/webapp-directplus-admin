mongoose = require  "mongoose"
Schema = mongoose.Schema


SlideSchema = Schema 
    Type: 
      type: String
      required : true
    Title: 
      type: String
      required: true
    Description: String
    Order: 
      type: Number
      required: true
    JsonData: 
      type: String
      required: true

SlideSchema.methods.toJSON = ()->




module.exports= mongoose.model 'Slide', SlideSchema , 'slides'