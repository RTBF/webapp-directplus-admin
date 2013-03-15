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

    position: 0

    restore: ()->
      $('#previous').on 'click', (e)=>
        @previous()
      $('#next').on 'click', (e)=>
        @next()
      @each (slide)->
        slideView = new slideScreen 
          model : slide
        $('#SlideList').append(slideView.render().el)

    showLast: ()->
      @each (slide) ->
        console.log slide.id
        $('#'+slide.id).hide()
      lastSlide = @at(@length - 1)
      @position = @length - 1
      $('#'+lastSlide.id).show()


    previous:()->
      console.log @position
      if @position>0
        current=@at(@position)
        $('#'+current.id).hide()

        @position = @position-1

        previous = @at(@position)
        $('#'+previous.id).show()

        # ...
      

    next:()->
      if @position<@length-1 
        current=@at(@position)
        $('#'+current.id).hide()

        @position =  @position+1

        next = @at(@position)
        $('#'+next.id).show()

     
      





  
