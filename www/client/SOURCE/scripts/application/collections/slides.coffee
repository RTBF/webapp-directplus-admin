define [
  'jquery'
  'backbone'
  'backbonels'
  'application/views/slideScreen'
  'application/models/slide'
  ],($,Backbone,Backbonels,slideScreen,Slide)->


  class slides extends Backbone.Collection
    
    model : Slide

    localStorage: new Backbonels "slidesStore"

    restore: ()->
      @each (slide)->
        slideView = new slideScreen 
          model : slide
        $('#SlideList').append(slideView.render().el)

    showLast: ()->
      @each (slide) ->
        console.log slide.id
        $('#'+slide.id).hide()
      lastSlide = @at(@length - 1)
      $('#'+lastSlide.id).show()
     
      





  
