mongoose = require  "mongoose"
Schema = mongoose.Schema


SlideSchema = Schema '_type'
    _conf:
      type: Schema.Types.ObjectId
      ref: 'Conference'
    Title: String
    Description: String
    Order: Number


SlideTextSchema =  Schema
  Content: String


SlideTwitterSchema =  Schema
  Embed: String


SlideVideoSchema = Schema
  Link: String


SlideQuizSchema = Schema
  BeginTime: Date
  EndTime: Date
  Question: String
  Propositions:
    PropA: String
    PropB: String
    PropC:  String
  Respone: String

SlideSchema.registerType 'slidetxt' , SlideTextSchema
SlideSchema.registerType 'slidetwt' , SlideTwitterSchema
SlideSchema.registerType 'slidevideo' , SlideVideoSchema
SlideSchema.registerType 'slidequiz' , SlideQuizSchema

module.exports= mongoose.model 'Slide', SlideSchema , 'slides'