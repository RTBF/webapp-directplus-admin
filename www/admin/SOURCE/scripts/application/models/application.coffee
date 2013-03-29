define [
  'jquery'
  #'application/routes/router'
  #'application/models/slide'
  #'application/collections/slides'
  'application/views/appView'
  'vendors/socketio/socketio'
  ],($,AppView)->
    
  ###
    Gere les communication serveur
    ###

  class Application
  
    constructor:() ->  
      @socket = null

      @appView = new AppView()

    init:() ->
      console.log "admin init"
      @ind = 0
      
      ###@socket = io.connect 'http://localhost:3000'
      @socket.emit 'admin' , 'Hello serveur i am the admin how are you?'
      @socket.emit 'reset' , '' 
      $('radio').on 'envoyer', (data)=>
        console.log "envoyer"
        @socket.emit('next', data)
      $('.radio').on 'enlever', (data)=>
        @socket.emit('remove', data)

      if @ind < @SlideListe.length
          socket.emit('next', @SlideListe[@ind]);
          @ind = @ind + 1;
        else 
          socket.emit('next', 'FIN');
        

      @socket.on 'snext',(data)->
        console.log data ;
    
      @socket.on 'connect_failed', (reason) ->
        console.log('connection refusé')###
        

 