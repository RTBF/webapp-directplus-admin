define [
  'jquery'
  'backbone'
  ],($,Backbone)->

    class slideScreen extends Backbone.View

      #el: '#appcontainer'

      tagName : 'li'
      className : 'slide new'


      template : _.template($('#slide-template').html())

      initialize : ()->
        @listenTo @model, 'change', @render()

        console.log  "slideScreen initilized"

      initrender:()->
       
        $("#loading").fadeOut()
        $("#wrap").fadeIn()

      render: ()-> 
        @$el.html @template(@model.toJSON())
        @
        



