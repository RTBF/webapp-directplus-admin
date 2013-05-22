define [
  'jquery'
  'application/routes/router'
  'application/views/appView'
  'application/models/slide'
  'application/collections/slides'
  'vendors/socketio/socketio'
  ],($,Router,AppView)->
    
  ###
    Gere les communication serveur
    ###

  class Application
  
    constructor:() ->  
      @socket = null
      
      console.log "application construction"
      #@appView = new AppView()

    init:() ->
      console.log "admin init"

      @socket = io.connect 'http://localhost:3000'
      @router= new Router(@socket)
      
      #@socket.emit 'slider' , '515c3c4383a8b7b67a000001'

      @socket.on 'organisations', (data)=>
        console.log "g reçu les organisations suivantes: ", data
        @router.app.trigger 'organisations', data

      @socket.on 'sslides', (data)=>
        console.log "received slides list"
        @router.app.trigger 'sslides', data

      @socket.on 'sent', (data)=>
        console.log 'jai reçu ça', data
        @router.app.trigger 'snext', data

      @socket.on 'slideCreated', (data)=>
        console.log 'slide created', data
        @router.app.trigger 'slideCreated', data

      @socket.on 'slideDeleted', (data)=>
        console.log 'slide deleted', data
        @router.app.trigger 'slideDeleted', data

       @socket.on 'slideUpdated', (data)=>
        console.log 'slideUpdated', data
        @router.app.trigger 'slideUpdated', data

      @socket.on 'sremove', (data)=>
        @router.app.trigger 'sremove', data

      @socket.on 'connect_failed', (reason) =>
        console.log('connection refusé', reason)

       @socket.on 'conferences', (data)=>
        console.log "app confList received", data
        @router.app.trigger 'conferences', data

      @socket.on 'confCreated', (data)=>
        console.log 'conf created: ', data
        @router.app.trigger 'confCreated', data

      @socket.on 'orgCreated', (data)=>
        @router.app.trigger 'orgCreated', data

      @socket.on 'confdeleted', (data)=>
        console.log "conf deleted"
        @router.app.trigger 'confdeleted', data

      @socket.on 'orgdeleted', (data)=>
        console.log "org deleted"
        @router.app.trigger 'orgdeleted', data

      @socket.on 'orgupdated', (data)=>
        console.log "org updated: ", data
        @router.app.trigger 'orgupdated', data

      @socket.on 'confupdated', (data)=>
        console.log "confupdated"
        @router.app.trigger 'confupdated', data

      @router.on 'newOrganisation', (data)=>
        @socket.emit 'newOrganisation', data
      
      @router.on 'newConference', (data)=>
        console.log "new conf ask created", data
        @socket.emit 'newConference', data

      @router.on 'send', (data)=>
        @socket.emit 'send', data

      @router.on 'remove', (data)=>
        @socket.emit 'remove', data

      @router.on 'saveslide', (data)=>
        @socket.emit 'createSlide', data
      
      @router.on 'deleteSlide', (data)=>
        @socket.emit 'deleteSlide', data
      
      @router.on 'updateSlide', (data)=>
        @socket.emit 'updateSlide', data

      @router.on 'organisationChoosed', (data)=>
        console.log 'ask confs'
        @socket.emit 'organisationChoosedForAdmin', data

      @router.on 'conferenceChoosed', (data)=>
        console.log 'ask confs'
        @socket.emit 'slider', data

      @router.on 'deleteconf', (data)=>
        @socket.emit 'deleteconf', data

      @router.on 'deleteorg', (data)=>
        console.log data
        @socket.emit 'deleteorg', data

      @router.on 'updateorg', (data)=>
        @socket.emit 'updateorg', data

      @router.on 'updateconf', (data)=>
        @socket.emit 'updateconf', data

      @socket.emit 'admin', 'seba@rtbf.be'





     
        

 