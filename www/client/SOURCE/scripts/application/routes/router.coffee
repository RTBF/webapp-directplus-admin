define [
  'jquery'
  'backbone'
  'application/views/appView'
  ],($,Backbone,AppView)->
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
        @appView = new AppView()
        @on 'route:organisationScreen',()->
          $('.slides').fadeOut()
          
          $('.confBlock').addClass('onhideright').removeClass('onshow')
          $('.organisationsBlock').addClass('onshow').removeClass('onhideleft')
            

        @on 'route:conferenceScreen',()->
          $('.slides').fadeOut()
          $('.organisationsBlock').addClass('onhideleft').removeClass('onshow')
          $('.confBlock').fadeIn ()->
            $('.confBlock').addClass('onshow').removeClass('onhideright')
            

        @on 'route:slideScreen', ()->
          $('.organisationsBlock').removeClass('onshow').addClass('onhideleft')
          $('.confBlock').fadeOut ()->
            $('.slides').fadeIn()
          
        
        @appView.on 'organisationChoosed', (data)=>
          console.log 'router organisation choosed: ', data
          @trigger 'confRoute', data

        @appView.on 'conferenceChoosed', (data)=>
          console.log 'router conference choosed: ', data
          @trigger 'slideRoute', data
               
        # Tell backbone to take care of the url navigation and history
        Backbone.history.start()
        console.log " The Route Initialized"

      