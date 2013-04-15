define [
  'jquery'
  'backbone'
  ],($,Backbone)->

    class ConferenceView extends Backbone.View

      #el: '#appcontainer'

      tagName : 'li'
      className : 'conf'
   
      events:
        'click .org-item' : 'choose'

      template : _.template($('#conf-template').html())

      initialize : ()->
       #

      render: ()-> 
        @$el.html @template(@model.toJSON())
        @

      choose:(evt)->
        txt = $(evt.target).attr('id')
        @conference = $(evt.target).attr('id')


 



