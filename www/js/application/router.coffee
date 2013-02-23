define [
  'jquery'
  'backbone'
  'application/views/loadingScreen'
  ],($,Backbone,LoadingScreen)->
    class Router extends Backbone.Router
      routes:
        loading:    'loadingScreen'
        main:       'mainScreen'
        about:      'aboutScreen'
        # default
        '*actions': 'loadingScreen'

      constructor:() ->
        super @routes

      initialize:()->
        @on 'route:loadingScreen',()->
          loadingScreen = new LoadingScreen
            el: $('#appcontainer')

          loadingScreen.render()
          console.log "Route is loadingScreen"
        @on 'route:mainScreen',()->
          mainScreen = new MainScreen()
          mainScreen.render()
          console.log "Route is mainScreen"
        @on 'route:aboutScreen',()->
          aboutScreen = new AboutScreen()
          aboutScreen.render()
          console.log "Route is aboutScreen"
        # Tell backbone to take care of the url navigation and history
        Backbone.history.start()
        console.log "Route Initialized"