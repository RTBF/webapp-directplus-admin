mongoose = require  "mongoose"
Schema = mongoose.Schema

dsn = "mongodb://localhost/confTesting"

mongoose.connect dsn

confDB = mongoose.connection

confDB.on 'error', console.error.bind(console, 'connection error:')

confDB.once 'open', ()->
  ###
        SLIDE
  ###
  ###
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
  ###
 
  ConferenceSchema = Schema
    _orga:
      type: Schema.Types.ObjectId
      ref: 'Organisation'
    name: String
    date: Date
   ### slides: [
      type: Schema.Types.ObjectId
      ref: 'Slide'
      ]
    ###

  OrganisationSchema = Schema
    _admin: 
      type: Schema.Types.ObjectId 
      ref: 'Admin'
    name: String
    date: Date
    conferences: [
      type: Schema.Types.ObjectId
      ref: 'Conference'] 

  AdminSchema = Schema 
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

  module.exports= mongoose.model 'Admin', AdminSchema , 'admins'
  module.exports= mongoose.model 'Organisation', OrganisationSchema , 'organisations'
  module.exports= mongoose.model 'Conference', ConferenceSchema, 'conferences'
  #module.exports= mongoose.model 'Slide', SlideSchema , 'slides'
