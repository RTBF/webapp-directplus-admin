define [
  'jquery'
  'backbone'
  'application/views/slideScreen'
  ],($,Backbone,slideScreen)->

    class Slide extends Backbone.Model

      defaults: 
        id: '???'
        title : 'empty Slide'
        description: 'no description'
     
      constructor: (aSlide)->
        super aSlide
         # ...

  

   
  
