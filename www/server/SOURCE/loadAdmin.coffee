mongoose = require 'mongoose'
Admin = require './Models/adminModel.js'
Organisations = require "./Models/organisationModel.js"

dsn = "mongodb://localhost/test"

mongoose.connect dsn, (err)->
  console.log err

populate = ->
  fabriceData = new Admin
    firstname: 'Fabrice' 
    lastname: 'Kyams'
    email: 'fabrice.kyams@gmail.com'

  fabriceData.save (err)->
    if err
      console.log err
    else
      console.log 'Fabrice as admin added'
  
  console.log 'Admin population'

showAdmins = ->
  

populate()
  