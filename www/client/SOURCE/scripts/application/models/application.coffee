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


    init:() ->
      @socket = io.connect 'http://localhost:3000'

      @router.on 'orgRoute', ()=>
        @connect()

      @router.on 'confRoute', (data)=>
        console.log 'app confRoute id org choosed: ', data
        @socket.emit 'organisationChoosed', data
      
      @router.on 'slideRoute', (data)=>
        console.log 'app slideRoute id conf choosed: ', data
        @socket.emit 'conferenceChoosed', data

      @socket.on 'organisations', (data)=>
        console.log 'app organisations recieved: ', data
        @router.appView.trigger "organisations", data

      @socket.on 'conferences', (data)=>
        console.log "app confList received", data
        @router.appView.trigger 'conferences', data
    

      @socket.on 'slides', (data)=>
        console.log 'app slides received', data
        @router.appView.trigger 'slides', data


      @socket.on 'snext', (data) =>
        console.log "snext received"
        @router.appView.trigger 'newSlide', data

      @socket.on 'sremove', (data)=>
        console.log "remove ask received"
        @router.appView.trigger 'sremove', data

    
      @socket.on 'sreset', (data) =>
        console.log "reseting"
        localStorage.clear()
        $('#SlideList').empty()
        @router.appView.trigger 'reseting', data

      @socket.on 'connect' , (data)=>
        @router.appView.trigger 'ServerConnection', data

      @connect()


    connect: () -> 
      @socket.emit 'user', ''
 