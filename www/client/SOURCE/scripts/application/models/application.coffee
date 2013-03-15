define [
  'application/routes/router'
  'application/models/slide'
  'application/collections/slides'
   'application/views/appView'
  'vendors/socketio/socketio'
  ],(Router, Slide, SlidesList,AppView)->
    
  ###
    Gere les communication serveur
    ###

  class Application
  
    constructor:() ->
      @router = new Router()
      @socket = null
      @appView = new AppView();


    init:() ->
      @socket = io.connect 'http://localhost:3000'

      @socket.on 'snext', (data) =>
        console.log "snext received"
        @appView.trigger 'newSlide', data

      @socket.on 'sreset', (data) =>
        localStorage.clear()
        $('#SlideList').empty()
        Application.slidesList.reset()

      @socket.on 'connect' , (data)=>
        @appView.trigger 'ServerConnection', data

      @connect()


    connect: () -> 
      @socket.emit 'user', ''
 