define [
  'jquery'
  'backbone'
  'backbonels'
  'application/views/slideView'
  'application/models/slide'
  ],($,Backbone,Backbonels,slideView,Slide)->


  class slides extends Backbone.Collection
    
    model : Slide

    localStorage: new Backbonels "slidesStore"

    position: 0

  

     
      





  