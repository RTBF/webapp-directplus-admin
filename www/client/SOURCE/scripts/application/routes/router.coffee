define [
  'jquery'
  'backbone'
  'application/views/slideScreen'
  ],($,Backbone,slideScreen)->
    class Router extends Backbone.Router
      routes:
        slide: 'slideScreen'
        # default
        
        '*actions': 'slideScreen'

      constructor:() ->
        super @routes

      initialize:()->
        @on 'route:slideScreen',()->
          $("#loading").fadeOut()
          $("#wrap").fadeIn()
               
        # Tell backbone to take care of the url navigation and history
        Backbone.history.start()
        console.log "Route Initialized"