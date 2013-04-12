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
        @$el.html @template(@model.toJSON())
        @
      
      choose:()->
        #



