define [
  'jquery'
  'backbone'
  'application/models/slide'
  'application/views/slideScreen'
  'application/collections/slides'
  'application/models/organisation'
  'application/views/organisationView'
  'application/models/conference'
  'application/views/conferenceView'
  ],($,Backbone,Slide,SlideView,Slides,Organisation,OrganisationView,Conference, ConferenceView)->

   

    class appView extends Backbone.View
   

      el: '#header'

      template : _.template($('#app-template').html())

      events:
        'click #previous' : 'previous'
        'click #next' : 'next'


      initialize : ()->
        @slides = new Slides()
        console.log @slides
        @render()
        @on 'newSlide', (data) =>
          @newSlide data
        @on 'ServerConnection' , (data)=>
          @connectNotif data
        @on 'reseting' , (data)=>
          @slides.reset()
          @slides.position= 0
          @navigationMode = false
        @on 'organisations', (data)=>
          console.log data
          @fullFillOrgList data
        @on 'conferences', (data)=>
          @fullFillConfList data
        @on 'slides', (data)=>
          @restore data
        @on 'sremove', (data)=>
          @removeSlide data
        @slides.fetch()
        console.log @slides

       

        
        #@restore()

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
        obj = $.parseJSON data.JsonData
        slide = new Slide obj
        slide.set("conf", data._conf)
        slideView = new SlideView ({model : slide })
        @slides.add slide
        slide.save()
        @slides.fetch()

        ###slide = new Slide data
        slideView = new SlideView ({model : slide })
        @slides.add slide
        slide.save()
        @slides.fetch()###
        if @navigationMode
          if (@slides.position == @slides.length-3)
            $('#SlideList').append(slideView.render().el)
            $('.new').removeClass('new').addClass('far-future') 
          #
        else
          @slides.position = @slides.length-1
          $('#SlideList').append(slideView.render().el)
          @last()

      removeSlide: (data)->
        console.log data
        obj = $.parseJSON data.JsonData
        obj = $.parseJSON data.JsonData
        @slides.each (model)=>
          if obj.id is model.get 'id'
            model.destroy()
        

      fullFillOrgList: (data)->
        len = data.length - 1
        console.log len
        for x in [0..len]
          organisation = new Organisation data[x]
          console.log organisation
          organisationView = new OrganisationView ({model:organisation})
          $('.organisationsList').append(organisationView.render().el)
        
        $("#loading").fadeOut()
        $("#wrap").fadeIn()

        $('.org-item').click (e)=>
          console.log e.target
          txt = $(e.target).attr('id')
          console.log txt
          @trigger 'organisationChoosed', txt

  
      fullFillConfList: (data)->
        len = data.length - 1

        for x in [0..len]
          console.log data[x]
          confs = new Conference data[x]
          confView = new ConferenceView ({model:confs}) 
          console.log confView.render().el
          $('.confList').append(confView.render().el)

        $('.organisationsBlock').removeClass('onshow').addClass('onhideleft')
        $('.confBlock').fadeOut()
        $('.confBlock').fadeIn()
        $('.confBlock').removeClass('onhideright').addClass('onshow')
        $('.organisationsBlock').fadeOut()
        $('.organisationsBlock').remove()

        $('.conf-item').click (e)=>
          txt = $(e.target).attr('id')
          @conference = $(e.target).attr('id')
          console.log txt
          @trigger 'conferenceChoosed', txt
 
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


      restore: (data)->

        console.log @conference
        @navigationMode = false;
        console.log @navigationMode
        console.log "number of slide received: ", data.length-1
        console.log "the data I received: ", data
        len = data.length-1
        if len >= 0
          sv = data[0]._conf
          for x in [0..len]
            console.log "here"
            obj = $.parseJSON data[x].JsonData
            slide = new Slide obj
            slide.set("conf", sv)
            slideView = new SlideView ({model : slide })
            @slides.add slide
            slide.save()
            @slides.fetch()             
        console.log @slides
        taille = @slides.length
        
        max = 3
        num = 0
        console.log 'taille', taille
        while (max>0 && taille>0)
          taille--
          
          
          slide = @slides.at taille
          console.log  slide.get 'conf'
          if slide.get('conf') is @conference
            slideView = new SlideView 
              model : slide
            $('#SlideList').append(slideView.render().el)
            max--
            num++
          
          switch num
            when 1 then $('.new').removeClass('new').addClass('current') 
            when 2 then $('.new').removeClass('new').addClass('past') 
            when 3 then $('.new').removeClass('new').addClass('far-past') 
        @slides.position = @slides.length-1
        $('.confBlock').fadeOut()
        $('.slides').fadeIn()

      last: ()->
        $('.new').removeClass('new').addClass('future')
        $('.future').hide()
        $('.future').fadeIn()
        $('.far-past').remove()
        $('.past').removeClass('past').addClass('far-past')
        $('.current').removeClass('current').addClass('past')
        $('.future').removeClass('future').addClass('current')

        $('.far-future').removeClass('far-future').addClass('future')
        console.log  "my position ", @slides.position
        @next()

      addTemplate: ()->
        if navigationMode
          
        else
          $('#SlideList').append(slideView.render().el)



        
      



        




