define [
  'jquery'
  'backbone'
  ],($,Backbone)->

    class slideScreen extends Backbone.View

      #el: '#appcontainer'

      tagname : 'div'

      template : _.template($('#slide-template').html())

      initialize : ()->
        @listenTo @model, 'change', @render()

        console.log  "slideScreen initilized"

      initrender:()->
       
        $("#loading").fadeOut()
        $("#wrap").fadeIn()

      render: ()-> 
        console.log @model.toJSON()
        @$el.html @template(@model.toJSON())
        @
        



