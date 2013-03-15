define [
  'jquery'
  'backbone'
  'application/models/slide'
  'application/views/slideScreen'
  'application/collections/slides'
  ],($,Backbone,Slide,SlideView,Slides)->

   

    class appView extends Backbone.View
      @slides : new Slides()

      el: '#header'

      template : _.template($('#app-template').html())

      events:
        'click #previous' : 'previous'
        'click #next' : 'next'


      initialize : ()->
        @render()
        @on 'newSlide', (data) =>
          @newSlide data
        @on 'ServerConnection' , (data)=>
          @connectNotif data
        appView.slides.fetch()
        @restore()

      connectNotif : (data)->
        $('.js-status').removeClass('disconnected').addClass('connected')

      render: ()-> 
        @$el.html @template()
        @

      previous: ()->
        if appView.slides.position>0
          current=appView.slides.at(appView.slides.position)
          $('#'+current.id).hide()

          appView.slides.position = appView.slides.position-1

          previous = appView.slides.at(appView.slides.position)
          $('#'+previous.id).show()
          console.log 'previous man'

      next: ()->
        if appView.slides.position<(appView.slides.length-1)
          current=appView.slides.at(appView.slides.position)
          $('#'+current.id).hide()

          appView.slides.position = appView.slides.position+1

          previous = appView.slides.at(appView.slides.position)
          $('#'+previous.id).show()
          console.log 'next man' 

      newSlide: (data)->
        slide = new Slide data
        slideView = new SlideView ({model : slide })
        appView.slides.add slide
        slide.save()
        appView.slides.fetch()
        $('#SlideList').append(slideView.render().el)
        @showLast()

      showLast: ()->
        appView.slides.each (slide) ->
          $('#'+slide.id).hide()
        lastSlide = appView.slides.at(appView.slides.length - 1)
        if lastSlide       
          $('#'+lastSlide.id).show()
        appView.slides.position = appView.slides.length-1


      restore: ()->
        console.log "SO WHAT"
        appView.slides.each (slide)=>
          slideView = new SlideView 
            model : slide
          $('#SlideList').append(slideView.render().el)
          
        @showLast()


        




