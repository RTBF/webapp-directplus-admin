
test = "i am exported too"

class DBRequest

  constructor: () ->
    @mongoose = require 'mongoose'
    @Schema = @mongoose.Schema
    @Admin = require '../Models/Admin.js'
    @Slide = require '../Models/Slide.js'
    @Organisation = require "../Models/Organisation.js"
    @Conference =  require "../Models/Conference.js"
    
    @dsn = "mongodb://localhost/WebConference"
    @mongoose.connect @dsn
    @init()
    # ...

  init: ()->
    #
    


  readOrganisations:(AdminId)->
    organisation = null
    confDB = @mongoose.connection
    confDB.on 'error', console.error.bind(console, 'connection error:')
    confDB.once 'open', ()=>
      console.log AdminId
      @Admin
      .findOne 
        _id:AdminId
        (err, admin)=>
          console.log "callback launched"
          if err
            console.log "error while trying to find the organisations of this admin"
      .populate('organisations')
      .exec (err, admin)=>
        organisation = JSON.stringify admin.organisations
        console.log "premier log:" , organisation
      console.log "deuxieme log:" , organisation
    organisation

  readConference:(OrgId)->
    Confs = null
    Organisation
    .findOne 
      _id:OrgId
      (err, organisation)=>
        if err
          console.log "error while trying to find the organisations of this admin"
    .populate('conferences')
    .exec (err, organisation)=>
      Confs = JSON.stringify organisation.conferences
    Confs

  readSlideList:(ConfId)->
    slides = null
    Conference
    .findOne 
      _id:ConfId
      (err, conference)=>
        if err
          console.log "error while trying to find the organisations of this admin"
    .populate('slides')
    .exec (err, conference)=>
      slides = JSON.stringify conference.slides
    slides

module.exports = new DBRequest


  
