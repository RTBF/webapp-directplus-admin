define [
  'jquery'
  'backbone'
  'application/views/slideView'
  ],($,Backbone,slideView)->

    class Slide extends Backbone.Model

      defaults: 
        id: '???'
        _id: ' '
        sent: ' '
        title : 'empty Slide'
        description: 'no description'
     
      constructor: (aSlide)->
        super aSlide
         # ...

  

   
  
