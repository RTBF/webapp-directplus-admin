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

module.exports.CreateSlide = CreateSlide = (newslide , callback)=>
  conf=newslide._conf
  type=newslide.type
  jsonData= newslide.jsonData

  Conference
  .findOne
    _id : conf
    (err, conference)=>
      slide1 = new Slide
        _conf: conference._id
        Type: type
        Sent: false
        JsonData: jsonData

      slide1.save (err, slide1)->
        if err
          console.log "erreur", err
      callback(slide1)
      conference.slides.push slide1
      conference.save (err, conference)->
        #
  .populate('slides')
  .exec (err, conferences)=>
    #

  
module.exports.UpdateSlide = UpdateSlide = (newslide , callback)=>
  id=newslide._id
  jsonData= newslide.jsonData

  Slide.findByIdAndUpdate id , JsonData: jsonData , new: true , (err, slide)=>
    callback(slide)
      
module.exports.DeleteSlide = DeleteSlide = (slideId , callback)=>
  Slide.findByIdAndRemove slideId, (err, slide)=>
    if err
      console.log err
    console.log 'voici le slide', slide
    callback slide._id

module.exports.CreateConference = CreateConference = (newconf, callback)=>
  try
    # ...

    
    Organisation
    .findOne
      _id : newconf._orga
      (err, organisation)=>
        try
          conference= new Conference
            _orga: newconf._orga
            name : newconf.name
            date : newconf.date
            tumb : newconf.tumb
            description : newconf.description
        
          conference.save (err, conference) ->
            if err
              console.log "save erreur", err
            callback conference
            organisation.conferences.push conference
            organisation.save (err, organisation)->
              #
          # ...
        catch e
          console.log err
          # ...
        
        
    .populate('conferences')
    .exec (err, organisations)=>
      #
  catch e
    # ...


module.exports.CreateOrganisation = CreateOrganisation = (newOrg, callback)=>
  console.log "newOrg: ", newOrg
  Admin
  .findOne
    _id : newOrg._admin
    (err, admin)=>
      organisation= new Organisation
        _admin: newOrg._admin
        name : newOrg.title
        tumb : newOrg.tumb
        description : newOrg.description

      organisation.save (err, organisation) ->
        if err
          console.log "erreur", err
        callback organisation
        console.log admin
        admin.organisations.push organisation
        admin.save (err, admin)->
          #
  .populate('organisations')
  .exec (err, admins)=>
    #

module.exports.DeleteConference = DeleteConference= (confId, callback)=>
  Slide.find
    _conf:confId
    (err, slides)=>
      for x in slides
        slides[x].remove (err)->
          #...

  Conference.findByIdAndRemove confId, (err, conference)=>
    if err
      console.log err
    callback conference._id

module.exports.DeleteOrganisation = DeleteOrganisation= (orgId, callback)=>
  Conference.find
    _orga:orgId
    (err, conferences)=>
      for x in conferences
        conferences[x].remove (err)->
          # ...

  Organisation.findByIdAndRemove orgId, (err, organisation)=>
    if err
      console.log err
    console.log 'voici le slide', slide
    callback organisation._id

module.exports.UpdateConference = UpdateConference= (conference, callback)=>
  Slide.findByIdAndUpdate conference._id  , new: true , (err, slide)=>
    callback(slide)

module.exports.UpdateOrganisation = UpdateOrganisation= (organisation, callback)=>
  Slide.findByIdAndUpdate organisation._id , new: true , (err, slide)=>
    callback(slide)

