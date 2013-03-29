mongoose = require 'mongoose'
Schema = mongoose.Schema
Admin = require './Models/Admin.js'
Organisation = require "./Models/Organisation.js"
Conference =  require "./Models/Conference.js"

dsn = "mongodb://localhost/confTesting"

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
          console.log "saving error man"###

  Organisation
  .findOne 
    name: 'RTBF'
  .populate('conferences')
  .exec (err, organisation)->
    console.log 'the Organisation', organisation
    




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


  