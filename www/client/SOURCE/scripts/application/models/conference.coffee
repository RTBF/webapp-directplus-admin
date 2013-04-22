define [
  'jquery'
  'backbone'
  'application/collections/slides'
  'application/models/slide'
  ],($,Backbone,Slides,Slide)->

    class Conference extends Backbone.Model

      defaults:
        slidesC: new Slides()

      constructor: (aConf)->
        super aConf
         # ...

      initialize:()->
        @navMode = false
        @on 'slides', (data)->
          @restore data
        @on 'newSlide', (data)->
          @newSlide data

      restore: (data)->
        console.log "j'ai été restaurement"
        console.log @get('slidesC')
        @get('slidesC').fetch()
        len = data.length - 1
        slideLen = @get('slidesC').length - 1

        if slideLen != len || data[0]._conf != @get '_id'
          console.log "jjj"
          @get('slidesC').reset()
          localStorage.clear()
          @get('slidesC').fetch()
          for x in [0..len]
            obj = $.parseJSON data[x].JsonData
            slide = new Slide obj
            @get('slidesC').add slide
            slide.save()
            @get('slidesC').fetch()
        @get('slidesC').each (slide)->
          slide.set 'state', 'out'
        taille = @get('slidesC').length
        max = 3
        while (max>0 && taille>0)
          taille--
          slide = @get('slidesC').at taille
          switch max
            when 3
              slide.set 'state', 'current'
            when 2
              slide.set 'state', 'past'
            when 1
              slide.set 'state', 'far-past'
          max--
        console.log @get('slidesC')
        console.log @get('slidesC')
        @trigger 'change'

      newSlide: (data)->
        obj = $.parseJSON data.JsonData
        slide = new Slide obj
        if @navMode
          slideff = @get('slidesC').where state:'far-future'
          if slideff[0]
            slide.set 'state', 'out'
          else
            slide.set 'state', 'far-future'
        else
          slide.set 'state', 'far-future'
          taille = @get('slidesC').length
          max = 3
          while (max>0 && taille>0)
            taille--
            slidet = @get('slidesC').at taille
            switch max
              when 3
                slidet.set 'state', 'past'
              when 2
                slidet.set 'state', 'far-past'
              when 1
                slidet.set 'state', 'out'
            max--
            
        @get('slidesC').add slide
        slide.save()
        @get('slidesC').fetch
        console.log @get('slidesC')

        @trigger 'new'

  

   
  
