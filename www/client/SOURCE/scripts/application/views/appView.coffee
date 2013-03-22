define [
  'jquery'
  'backbone'
  'application/models/slide'
  'application/views/slideScreen'
  'application/collections/slides'
  ],($,Backbone,Slide,SlideView,Slides)->

   

    class appView extends Backbone.View
   

      el: '#header'

      template : _.template($('#app-template').html())

      events:
        'click #previous' : 'previous'
        'click #next' : 'next'


      initialize : ()->
        @slides = new Slides()
        @render()
        @on 'newSlide', (data) =>
          @newSlide data
        @on 'ServerConnection' , (data)=>
          @connectNotif data
        @slides.fetch()
        @restore()

      connectNotif : (data)->
        $('.js-status').removeClass('disconnected').addClass('connected')

      render: ()-> 
        @$el.html @template()
        @

      previous: ()->
        console.log @slides.position
        if @slides.position>0
          $('.far-future').remove()
          $('.future').removeClass('future').addClass('far-future')
          $('.current').removeClass('current').addClass('future')
          $('.past').removeClass('past').addClass('current')
          $('.far-past').removeClass('far-past').addClass('past')
          @slides.position = @slides.position-1
          previous = @slides.at(@slides.position)
          @navigationMode = true;
          
          if @slides.position > 1
            newPosSlide = @slides.position - 2 
            slide = @slides.at newPosSlide
            slideView = new SlideView 
              model : slide
            $('#SlideList').append(slideView.render().el)
            $('.new').removeClass('new').addClass('far-past')
        console.log @navigationMode 

         

      next: ()->
        if (@slides.position < (@slides.length-1))
          console.log "I am in"
          $('.far-past').remove()
          $('.past').removeClass('past').addClass('far-past')
          $('.current').removeClass('current').addClass('past')
          $('.future').removeClass('future').addClass('current')
          $('.far-future').removeClass('far-future').addClass('future')
          
          @slides.position = @slides.position+1
          previous = @slides.at(@slides.position)
          
          if @slides.position is (@slides.length-1)
            @navigationMode = false
            # ...

          if @slides.position < (@slides.length-2)
            newPosSlide = @slides.position + 2 
            slide = @slides.at newPosSlide
            slideView = new SlideView 
              model : slide
            $('#SlideList').append(slideView.render().el)
            $('.new').removeClass('new').addClass('far-future') 

        console.log @navigationMode
          

      newSlide: (data)->
        
        slide = new Slide data
        slideView = new SlideView ({model : slide })
        @slides.add slide
        slide.save()
        @slides.fetch()
        if @navigationMode
          console.log "Je Suis ICI? True?"
          if (@slides.position == @slides.length-3)
            $('#SlideList').append(slideView.render().el)
            $('.new').removeClass('new').addClass('far-future') 
          #
        else
          console.log "ou là?"
          @slides.position = @slides.length-1
          $('#SlideList').append(slideView.render().el)
          @last()


      showLast: ()->

        @slides.each (slide) ->
          id = '#'+slide.id
          $(id).hide()
        lastSlide = @slides.at(@slides.length - 1)
        if lastSlide
          $('#'+lastSlide.id).show()
        if @slides.length == 0
          @slides.position = 0
        else
          @slides.position = @slides.length-1


      restore: ()->
        @navigationMode = false;
        console.log @navigationMode

        taille = @slides.length
        max = 3
        num = 0

        while (max>0 && taille>0)
          taille--
          max--
          num++
          slide = @slides.at taille
          slideView = new SlideView 
            model : slide
          $('#SlideList').append(slideView.render().el)
          
          switch num
            when 1 then $('.new').removeClass('new').addClass('current') 
            when 2 then $('.new').removeClass('new').addClass('past') 
            when 3 then $('.new').removeClass('new').addClass('far-past') 
        @slides.position = @slides.length-1


      last: ()->
        $('.new').removeClass('new').addClass('future')
        $('.far-past').remove()
        $('.past').removeClass('past').addClass('far-past')
        $('.current').removeClass('current').addClass('past')
        $('.future').removeClass('future').addClass('current')
        $('.far-future').removeClass('far-future').addClass('future')
        console.log  "my position ", @slides.position
        @next()
        
        #$('.far-future').removeClass('far-future').addClass('current')

      addTemplate: ()->
        if navigationMode
          
        else
          $('#SlideList').append(slideView.render().el)



        
      



        




