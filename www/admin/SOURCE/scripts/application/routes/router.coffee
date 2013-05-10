define [
  'jquery'
  'backbone'
  'application/views/mainView'
  'application/models/app'
  ],($,Backbone,MainView,App)->

    class Router extends Backbone.Router
      routes:
        'connexion': 'connectScreen'
        'admin': "adminScreen"
        'conference/:ordId': 'conferenceScreen'
        'anime/:confId': 'animeScreen'
        # default
        
        '*actions': 'adminScreen'

      constructor:() ->
        super @routes
        
      initialize:()->
        console.log "router initialize"
        @trigger 'admiRoute'
        @app = new App()

        @mainView = new MainView
          model: @app

        @mainView.on 'sendslide', (data)=>
          @trigger 'send', data
        
        @mainView.on 'removeslide', (data)=>
          @trigger 'remove', data

        @mainView.on 'saveslide', (data)=>
          @trigger 'saveslide', data 
        
        @mainView.on 'deleteSlide', (data)=>
          @trigger 'deleteSlide', data 

        @mainView.on 'updateSlide', (data)=>
          @trigger 'updateSlide', data

        @mainView.on 'newConference', (data)=>
          console.log 'new conf'
          @trigger 'newConference', data

        @mainView.on 'newOrganisation', (data)=>
          console.log "new Orgaz"
          @trigger 'newOrganisation', data

        Backbone.history.start()
          

      connectScreen:()->
        console.log "nothing for now "

      adminScreen:()->
        $(".confplus").parent().hide()
        console.log "nothing for now"


      conferenceScreen:(orgId)->
        $('.adminScreen').fadeIn ()=>
          $('.animeScreen').fadeOut()
        console.log "allo"
        @trigger 'organisationChoosed', orgId

      animeScreen:(confId)->
        $('.animeScreen').fadeIn ()=>
          $('.adminScreen').fadeOut()
        @trigger 'conferenceChoosed', confId