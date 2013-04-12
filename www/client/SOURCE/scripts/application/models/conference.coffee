define [
  'jquery'
  'backbone'
  ],($,Backbone)->

    class Conference extends Backbone.Model

      defaults: 
        name : 'noname'

     
      constructor: (aConf)->
        super aConf
         # ...

  

   
  
