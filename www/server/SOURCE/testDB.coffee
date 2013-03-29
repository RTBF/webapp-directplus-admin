mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/Testingdeux');

db = mongoose.connection;

db.on 'error', console.error.bind( console , 'connection error:')

kittySchema = mongoose.Schema 
  name: String
  
Kitten = mongoose.model 'Kitten' , kittySchema 
  
db.once  'open', ()->
  #...
  

  silence = new Kitten
    name: 'Silence' 

  fluffy = new Kitten
    name: 'fluffy' 
 

  fluffy.save (err, fluffy)-> 
    if err
      console.log " save erreur man"
    

  silence.save (err, silence)-> 
    if err
      console.log "save erreur man"
  
  Kitten.find (err, kittens) ->
    if (err)
      console.log "find erreur man"
    console.log(kittens)


