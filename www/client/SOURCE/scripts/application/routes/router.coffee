define [
  'jquery'
  'backbone'
  'application/views/slideScreen'
  'text!application/templates/organisations.html'
  'text!application/templates/conferences.html'
  'text!application/templates/slides.html'
  ],($,Backbone,slideScreen,OrganisationTemplate,ConferenceTemplate,SlideTemplate)->
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
        @on 'route:organisationScreen',()->
          console.log "org screen show"
          $('#appcontainer').html(OrganisationTemplate)

          #$("#loading").fadeOut()
          #$("#wrap").fadeIn()
        @on 'route:conferenceScreen',()->
          console.log 'conf screen show'
          $('#appcontainer').append(ConferenceTemplate)
          @trigger 'confRoute', ''
        

        @on 'route:slideScreen', ()->
          $('#appcontainer').append(SlideTemplate)
          $('.slides').hide()
          @trigger 'slideRoute', ''
               
        # Tell backbone to take care of the url navigation and history
        Backbone.history.start()
        console.log " The Route Initialized"