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


OrganisationSchema = new mongoose.Schema
  _admin: 
    type: Schema.Types.ObjectId 
    ref: 'Admin'
  name: String
  date: Date
  conferences: [
    type: Schema.Types.ObjectId
    ref: 'Conference'] 


AdminSchema = new Schema 
  firstname: String
  lastname: String
  email: 
    type: String
    required: true
    index:
      unique: true 
  organisations: [
    type: Schema.Types.ObjectId
    ref: 'Organisation' 
  ]

module.exports = mongoose.model 'Admin', AdminSchema , 'admins'
module.exports= mongoose.model 'Organisation', OrganisationSchema , 'organisations'
modules.exports= mongoose.model 'Conference', ConferenceSchema, 'conferences'
module.exports= mongoose.model 'Slide', SlideSchema , 'slides'
