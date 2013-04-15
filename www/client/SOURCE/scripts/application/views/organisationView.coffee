define [
  'jquery'
  'backbone'
  ],($,Backbone)->

    class OrganisationView extends Backbone.View

      #el: '#appcontainer'

      tagName : 'li'
      className : 'organisation'
      
      events:
        'click .org-item' : 'choose'


      template : _.template($('#Organisation-template').html())

      initialize : ()->
       #

      render: ()-> 
        console.log "fuck?"
        @$el.html @template(@model.toJSON())
        @
      
      choose:(ev)->
        #
        console.log ev.target
        txt = $(ev.target).attr('id')



