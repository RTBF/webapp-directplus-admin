define [
  'jquery'
  #'application/routes/router'
  'application/views/appView'
  'application/models/slide'
  'application/collections/slides'
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
      
      @socket = io.connect 'http://localhost:3000'
      @socket.emit 'slider' , '515c3c4383a8b7b67a000001'
      
      @socket.on 'sslides', (data)=>
        @appView.trigger 'sslides', data

      @socket.on 'snext', (data)=>
        @appView.trigger 'snext', data

      @appView.on 'send', (data)=>
        @socket.emit 'send', data

      @appView.on 'remove', (data)=>
        @socket.emit 'remove', data

      @socket.on 'sremove', (data)=>
        @appView.trigger 'sremove', data

    
      @socket.on 'connect_failed', (reason) ->
        console.log('connection refusé', reason)
        

 