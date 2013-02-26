define [
  'jquery'
  'backbone'
  'application/views/mainScreen'
  'application/views/aboutScreen'
  ],($,Backbone,MainScreen,AboutScreen)->
    class Router extends Backbone.Router
      routes:
        main:       'mainScreen'
        about:      'aboutScreen'
        # default
        '*actions': 'mainScreen'

      constructor:() ->
        super @routes

      initialize:()->
        @on 'route:mainScreen',()->
          mainScreen = new MainScreen
            el: $('#appcontainer')

          mainScreen.render()
          console.log "Route is mainScreen"
        @on 'route:aboutScreen',()->
          aboutScreen = new AboutScreen
            el: $('#appcontainer')

          aboutScreen.render()
          console.log "Route is aboutScreen"
        # Tell backbone to take care of the url navigation and history
        Backbone.history.start()
        console.log "Route Initialized"