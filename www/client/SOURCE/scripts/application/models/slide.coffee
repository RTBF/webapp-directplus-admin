define [
  'jquery'
  'backbone'
  'application/views/slideScreen'
  ],($,Backbone,slideScreen)->

    class Slide extends Backbone.Model

      defaults: 
        id: '???'
        conf: 'none'
        title : 'empty Slide'
        description: 'no description'
     
      constructor: (aSlide)->
        super aSlide
         # ...

  

   
  
