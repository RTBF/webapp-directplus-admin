define [
  'application/routes/router'
  'application/models/slide'
  'application/collections/slides'
  'application/views/slideScreen'
  'vendors/socketio/socketio'
  ],(Router, Slide, SlidesList, SlideView)->

  

  class Application

    constructor:() ->
      @router = new Router()
      @socket = null
      @slidesList = new SlidesList()
      @slidesList.fetch()
      console.log "Application created"


    init:() ->
      @socket = io.connect 'http://localhost:3000'

      @socket.on 'snext', (data) =>
        @newSlide(data)

      @socket.on 'sreset', (data) =>
        localStorage.clear()
        $('#SlideList').empty()
        @slidesList.reset()

      @socket.on 'connect' , ()->
        $('.js-status').removeClass('disconnected').addClass('connected')
        console.log "connected"

      @connect()

      @slidesList.restore()

      @slidesList.showLast()

      

    connect: () -> 
      @socket.emit 'user', ''
      

    newSlide: (data) ->
      slide = new Slide data
      slideView = new SlideView ({model : slide })
      @slidesList.add slide
      slide.save()
      @slidesList.fetch()
      $('#SlideList').append(slideView.render().el)
      @slidesList.showLast()
      console.log "what?"

