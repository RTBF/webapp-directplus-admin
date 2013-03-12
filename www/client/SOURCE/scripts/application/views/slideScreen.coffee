define [
  'jquery'
  'backbone'
  ],($,Backbone)->
    class slideScreen extends Backbone.View

      #el: '#appcontainer'

      tagname : 'div'

      template : _.template($('#slide-template').html())

      initialize : ()->
        console.log  "slideScreen initilized"

      initrender:()->
       
        $("#loading").fadeOut()
        $("#wrap").fadeIn()

      render: ()-> 
        @$el.html @template(@model.toJSON())
        @
        



