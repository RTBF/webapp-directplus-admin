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

      initialize : ()->
        @listenTo @model, 'change:conferencesC', @renderConfList
        @listenTo @model, 'new', (data)=>
          @renderNew data

      render: ()-> 
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
        Backbone.history.navigate(href, trigger:true)

      deleteorg:()->
        $('#deleteorg').trigger 'deleteorg' , @model.get('id')



