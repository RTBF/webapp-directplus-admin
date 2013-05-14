define [
  'jquery'
  'backbone'
  'application/views/conferenceView'
  ],($,Backbone,ConferenceView)->

    class OrganisationView extends Backbone.View

      tagName : 'li'
      className : 'organisation'
      
      events:
        'click .org-item' : 'choose'
        'click #deleteorg' : 'deleteorg'


      template : _.template($('#Organisation-template').html())
      templateset: _.template ($('#orgsettings-template').html())

      initialize : ()->
        @listenTo @model,'change', @render
        @listenTo @model, 'change:conferencesC', @renderConfList
        @listenTo @model, 'new', (data)=>
          @renderNew data
        @listenTo @model, 'remove', @remove

      render: ()-> 
        console.log 'render'
        @$el.html @template(@model.toJSON())
        @

      renderConfList:()->
        $('.conf').remove()
        console.log @model.get('conferencesC')
        @model.get('conferencesC').each (conference)->
          conferenceView = new ConferenceView ({model:conference})
          $('.confList').prepend(conferenceView.render().el)
      
      renderNew:(conference)->
        conferenceView = new ConferenceView ({model:conference})
        $('.confList').prepend(conferenceView.render().el)

      choose:(ev)->
        $(".organisationsList li").each (i,elt)->
          $(elt).removeClass('active')

        @$el.addClass('active')
        $('.organisationsList').trigger 'organisationChoosed',  @model.get('id') 
        $(".confplus").parent().show()
        id= @model.get('id')
        href =  '/conference/' + id
        $(".orgsettings").remove()
        $('.confsblock').prepend(@templateset(@model.toJSON()))
        Backbone.history.navigate(href, trigger:true)


      deleteorg:()->
        console.log "clicked on trash icon"
        if (confirm("Are you sure?"))
          $('#deleteorg').trigger 'deleteorg' , @model.get('id')

      remove:()->
        id = '#'+@model.get 'id'
        $(id).parent().slideUp()

    




