mongoose = require  "mongoose"
Schema = mongoose.Schema

SlideSchema = new Schema '_type'
  _conf:
    type: Schema.Types.ObjectId
    ref: 'Conference'
  Title: String
  Description: String
  Order: Number


SlideTextSchema = new Schema
  Content: String


SlideTwitterSchema = new Schema
  Embed: String


SlideVideoSchema = new Schema
  Link: String


SlideQuizSchema = new Schema
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

###
For polymorphism, use Slide.registerType ('typename', typename)
###


module.exports= mongoose.model 'Slide', SlideSchema , 'slides'
