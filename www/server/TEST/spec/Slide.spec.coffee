mongoose = require 'mongoose'
Slide = require '../../SOURCE/Models/Slide.js'

dsn = "mongodb://localhost/confTesting"
mongoose.connect dsn
confDB = mongoose.connection
confDB.on 'error', console.error.bind(console, 'connection error:')

describe 'when a slide is saved', ()->
  it 'should ', ()->
    
    slide = null
    noError = null
    found = null
    
    runs ()->
      noError = false
      found = false
      console.log 'starting save test'
      slide = new Slide 
        Type: 'text'
        Title: 'a tittle'
        Description: "a description"
        Order: 1
        JsonData: "{ text : 'my texte'}"      

      console.log "runs done"

    saveSlide = ()->
      console.log "Wait for Saving"
      slide.save (err, slide) ->
        console.log "into Saving"
        expect(err).toBeNull()
        if err
          console.log "pas bien"
        else
          console.log "bien"
          noError = true
          
      console.log 'pas derreur', noError
      return noError
     
    
    waitsFor saveSlide, "slide dreated", 1000

    runs ()->
      console.log "le type du slide est:" , slide.Type
      
      



    
  
