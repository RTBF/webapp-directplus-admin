mongoose = require 'mongoose'

Admin = require './Models/Admin.js'
Organisation = require "./Models/Organisation.js"
Conference = require "./Models/Conference.js"
Slide = require "./Models/Slide.js"

class DBCom
  
  constructor: () ->
    # ...

  init:()->
    dsn = "mongodb://localhost/WebConference"
    mongoose.connect dsn
    confDB = mongoose.connection
    confDB.on 'error', console.error.bind(console, 'connection error:')

  addAdmin:()->
    #...
  addOrganisation:(adminId)->
    #...  
  addConference:(OrgaId)->
    #...
  addSlide:(ConfId)->
    #...
  ResetDB:()->

