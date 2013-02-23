define ['application/router'],(Router)->
  class Application

    constructor:() ->
      @router = new Router()
      console.log "Application created"


    init:() ->
      console.log "Application initialized"
