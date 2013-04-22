define [
  'jquery'
  'backbone'
  'application/views/organisationView'
  ],($,Backbone,OrganisationView)->

    class mainView extends Backbone.View
   

      el: '#header'

      template : _.template($('#app-template').html())

      initialize : ()->
        @listenTo @model, 'change', @render

        $('#appcontainer').delegate '.org-item', 'click', (e)=>
          txt = $(e.target).attr('id')
          @trigger 'organisationChoosed', txt
          console.log "organisation choosed", txt


        $('#appcontainer').delegate '.conf-item' ,'click ', (e)=>
          txt = $(e.target).attr('id')
          @conference = $(e.target).attr('id')
          @trigger 'conferenceChoosed', txt

        ###$('#suivant').click (e)=>
          e.preventDefault()
          @suivant()
          console.log "pushed next bt"
        
        $('#precedent').click (e)=>
          e.preventDefault()
          @precedent()
          console.log "pushed previous bt"###


      connectNotif : (data)->
        $('.js-status').removeClass('disconnected').addClass('connected')

      render: ()-> 
        $('.organisationsList').children().remove()
        console.log "main view is redenring"
        if $('#header').is ':empty'
          @$el.html @template()

        @model.get('organisations').each (organisation)->
          organisationView = new OrganisationView ({model:organisation})
          $('.organisationsList').append(organisationView.render().el)

        $("#loading").fadeOut()
        $("#wrap").fadeIn()