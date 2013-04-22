define [
  'jquery'
  'backbone'
  'application/views/mainView'
  'application/models/app'
  ],($,Backbone,MainView,App)->
    class Router extends Backbone.Router
      routes:
        organisation: 'organisationScreen'
        conference: 'conferenceScreen'
        slide: 'slideScreen'
        # default
        
        '*actions': 'organisationScreen'

      constructor:() ->
        super @routes
        
        

      initialize:()->
        @trigger 'orgRoute'
        @app = new App()

        @mainView = new MainView
          model:  @app
        
        @on 'route:organisationScreen',()->
          $('.slides').fadeOut() 
          $('.confBlock').removeClass('onshow')
          $('.organisationsBlock').addClass('onshow')
            

        @on 'route:conferenceScreen',()->
          $('.slides').fadeOut()
          $('.organisationsBlock').removeClass('onshow')
          $('.confBlock').show ()->
            $('.confBlock').addClass('onshow')
            

        @on 'route:slideScreen', ()->
          $('.organisationsBlock').removeClass('onshow')
          $('.confBlock').fadeOut ()->
            $('.slides').fadeIn()
          
        
        @mainView.on 'organisationChoosed', (data)=>
          console.log 'router organisation choosed: ', data
          @trigger 'confRoute', data

        @mainView.on 'conferenceChoosed', (data)=>
          console.log 'router conference choosed: ', data
          @trigger 'slideRoute', data
               
        # Tell backbone to take care of the url navigation and history
        Backbone.history.start()
        console.log " The Route Initialized"

      