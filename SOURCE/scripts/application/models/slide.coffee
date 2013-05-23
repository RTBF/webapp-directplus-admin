define [
  'jquery'
  'backbone'
  'application/views/slideView'
  ],($,Backbone,slideView)->

    class Slide extends Backbone.Model
      defaults:
        title:' '
      constructor: (aSlide)->
        super aSlide
         # ...

  

   
  
