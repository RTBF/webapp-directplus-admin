mongoose = require 'mongoose'
Schema = mongoose.Schema
Admin = require './Models/Admin.js'
Slide = require './Models/Slide.js'
Organisation = require "./Models/Organisation.js"
Conference =  require "./Models/Conference.js"

dsn = "mongodb://localhost/WebConference"

mongoose.connect dsn

confDB = mongoose.connection

confDB.on 'error', console.error.bind(console, 'connection error:')

confDB.once 'open', ()->
  console.log "I AM CONNECTED"

  ### AdminSchema = Schema 
    firstname: String
    lastname: String
    email: 
      type: String
      required: true
      index:
        unique: true  
  
  Admin = mongoose.model 'Admin', AdminSchema , 'admins'###


  ###Seba = new Admin
    firstname: 'Sebastien' 
    lastname: 'Barbeiri'
    email: 'seba@rtbf.com'

  Seba.save (err, fabriceData)->
    if err
      console.log "saving error man"
      console.log err
    else
      console.log 'Seba as admin added'
  ###

  ###
  RTBF = new Organisation
    name: 'RTBF'

  RTBF.save (err, RTBF)->
    if err
      console.log "saving error man"
      console.log err
    else
      console.log 'RTBF as Organisation added'
  ###
  ###Organisation.findOne name: 'RTBF' , (err, organisation)=>
    
    SansChichiConf = new Conference
      _orga: organisation._id
      name: "Conférence Sans ChiChi"

    SansChichiConf.save (err, SansChichiConf)->
      if err
        console.log "saving error man"
        console.log err
      else
        console.log 'Sans Chichi as Conférence added'

  Organisation.findOne name: 'RTBF' , (err, organisation)=>
    Conference.findOne name: "Conférence Sans ChiChi" , (err, conference)=>
      console.log "oraganisation found" , organisation
      console.log "conference found" , conference
      organisation.conferences.push conference
      organisation.save (err, organisation)->
        if err
          console.log "saving error man"

  Organisation
  .findOne 
    name: 'RTBF'
  .populate('conferences')
  .exec (err, organisation)->
    console.log 'the Organisation', organisation
  
  slide = new Slide 
    Type: 'text'
    Title: 'a tittle'
    Description: "a description"
    Order: 1
    JsonData: "{ text : 'my texte'}"

  slide.save (err, slide) ->
    console.log "into Saving"
  Slide.findOne Order:1 , (err, result)->
    console.log "into Find One"
    console.log result
  ###

  ###Organisation
  .findOne 
    name: 'RTBF'
  .populate('conferences')
  .exec (err, organisation)->
    console.log organisation###

  Slide.find (err, slides) ->
    if (err)
      console.log "find erreur man"
    #console.log slides
    if slides.length > 0 
      len = slides.length - 1
      for x in [0..len]
        console.log " "
        console.log "Slides: ", slides[x]
        #js =  JSON.stringify slides[x]
        #console.log js
        #slides[x].remove (err)->
          #console.log "can't remove"

  Admin.find (err, admins) ->
    if (err)
      console.log "find erreur man"
    if admins.length > 0 
      len = admins.length - 1
      for x in [0..len]
        console.log " "
        console.log "admins:", admins[x]
        #admins[x].remove (err)->
          #console.log "can't remove"

  Organisation.find (err, organisations) ->
    if (err)
      console.log "find erreur man"
    if organisations.length > 0 
      len = organisations.length - 1
      for x in [0..len]
        console.log " "
        console.log "Organisation: " , organisations[x]
        #organisations[x].remove (err)->
          #console.log "can't remove"



  Conference.find (err, conferences) ->
    if (err)
      console.log "find erreur man"
    if conferences.length > 0 
      len = conferences.length - 1
      for x in [0..len]
        console.log " "
        console.log "conferences: ", conferences[x]
        #conferences[x].remove (err)->
          #console.log "can't remove"






  ###SansChichiConf = new Conference
    _orga: ''
    name: String

  SansChichiConf.save (err, SansChichiConf)->
    if err
      console.log "saving error man"
      console.log err
    else
      console.log 'Sans Chichi as Conférence added'###


  ###Conference
  .findOne 
    name: "Conférence Sans ChiChi"
  .populate('_orga')
  .exec (err, conference)->
    console.log 'the Organisation of this conf is', conference._orga.name




 
  Admin.find (err, admins) ->
    if (err)
      console.log "find erreur man"
    console.log admins

  Organisation.find (err, organisations) ->
    if (err)
      console.log "find erreur man"
    console.log organisations

  Conference.find (err, conferences) ->
    if (err)
      console.log "find erreur man"
    console.log "Les nouvelles conférences: " , conferences###


  