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
      @appView = new AppView()


    init:() ->
      @socket = io.connect 'http://localhost:3000'

      @socket.on 'snext', (data) =>
        console.log "snext received"
        @appView.trigger 'newSlide', data

      @socket.on 'sremove', (data)=>
        console.log "remove ask received"
        @appView.trigger 'sremove', data

      @socket.on 'organisations', (data)=>
        console.log data
        @appView.trigger "organisations", data
        @appView.on 'organisationChoosed', (data)=>
          @socket.emit 'organisationChoosed', data
      

      @socket.on 'conferences', (data)=>
        @router.on "confRoute", (datas)=>
          console.log "confList received", data
          @appView.trigger 'conferences', data
          @appView.on 'conferenceChoosed', (data)=>
            @socket.emit 'conferenceChoosed', data
      
      @socket.on 'slides', (data)=>
        @router.on 'slideRoute', (datas)=>      
          @appView.trigger 'slides', data

      @router.on "slideRoute", (data)=>
        

      @socket.on 'sreset', (data) =>
        console.log "reseting"
        localStorage.clear()
        $('#SlideList').empty()
        @appView.trigger 'reseting', data

      @socket.on 'connect' , (data)=>
        @appView.trigger 'ServerConnection', data

      @connect()


    connect: () -> 
      @socket.emit 'user', ''
 