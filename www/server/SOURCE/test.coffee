mongoose = require 'mongoose'


dsn = "mongodb://localhost/test"

mongoose.connect dsn, (err)->
  if err
    console.log 'Houston we have a probleme', err
  else
    console.log 'it seems to be cool'