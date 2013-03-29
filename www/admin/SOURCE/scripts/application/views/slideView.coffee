define [
  'jquery'
  'backbone'
  ],($,Backbone)->

    class slideView extends Backbone.View

      #el: '#appcontainer'

      tagName : 'li'
      className : 'slide'


      template : _.template($('#slide-template').html())

      initialize : ()->
        console.log "Admin initialization"
        @listenTo @model, 'change', @render()
        


      render: ()-> 
        console.log "rendering"
        @$el.html @template(@model.toJSON())
        @

      send: ()->
        #
        console.log "send"

      remove: ()->
        #
        console.log "remove"
