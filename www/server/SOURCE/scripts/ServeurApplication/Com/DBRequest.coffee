class DBRequest

  constructor: () ->
    console.log "construction"
    @mongoose = require 'mongoose'
    @Admin = require '../Models/Admin.js'
    @Slide = require '../Models/Slide.js'
    @Organisation = require "../Models/Organisation.js"
    @Conference =  require "../Models/Conference.js"
    @async = require 'async'
    
    @dsn = "mongodb://localhost/WebConference"
    @mongoose.connect @dsn
    @confDB = @mongoose.connection
    @confDB.on 'error', console.error.bind(console, 'connection error:')
    @confDB.once 'open', ()=>
      @Admin
      .findOne 
        _id:'515c1b1950e5c6a674000001'
        (err, admin)=>
          console.log "please come here"
          if err
            callback(err)
            return
            #console.log "error while trying to find the organisations of this admin"
      .populate('organisations')
      .exec (err, admin)=>
        console.log  organisation = JSON.stringify admin.organisations
        console.log "premier log:" , organisation
    @init()
    # ...

  init: ()->
    
    #

  readOrganisations:(AdminId, callback)->
    organisation = null
    
    
    console.log AdminId
    console.log "your are in"
    console.log @Admin.findOne
    @Admin
    .findOne 
      _id:AdminId
      (err, admin)=>
        console.log "please come here"
        if err
          callback(err)
          return
          #console.log "error while trying to find the organisations of this admin"
    .populate('organisations')
    .exec (err, admin)=>
      console.log  organisation = JSON.stringify admin.organisations
      console.log "premier log:" , organisation
    console.log "end of fonction"
    console.log "fuck"
    

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

db = new DBRequest


  
