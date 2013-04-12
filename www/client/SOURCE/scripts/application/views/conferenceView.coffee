define [
  'jquery'
  'backbone'
  ],($,Backbone)->

    class ConferenceView extends Backbone.View

      #el: '#appcontainer'

      tagName : 'li'
      className : 'conf'
   


      template : _.template($('#conf-template').html())

      initialize : ()->
       #

      render: ()-> 
        @$el.html @template(@model.toJSON())
        @
 



