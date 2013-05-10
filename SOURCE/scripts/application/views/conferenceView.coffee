define [
  'jquery'
  'backbone'
  'application/views/slideView'
  ],($,Backbone,SlideView)->

    class ConferenceView extends Backbone.View

      #el: '#appcontainer'
      @counter: 0
      
      tagName : 'li'
      className : 'conf span4'

      template : _.template($('#conf-template').html())
      events:
        'click .conf-item' : 'choose'


      initialize : ()->
        console.log "Counter: #{ConferenceView.counter}"
        @id = ConferenceView.counter
        ConferenceView.counter++
        @listenTo @model, 'change', @render
        @listenTo @model, 'change:slidesC', @renderList
        @listenTo @model, 'new', (data)=>
          console.log "new new new #{@id}"
          @newSlide(data)
      

      render: ()-> 
        @$el.html @template(@model.toJSON())
        @

      renderList:()->
        $('.Sent').children().remove()
        $('.toSend').children().remove()
        @model.get('slidesC').each (slide)->
          slideView = new SlideView 
            model : slide
          console.log slideView
          if slide.get('sent')
            $('.Sent').append(slideView.render().el)
          else
            $('.toSend').append(slideView.render().el)
            # ...
       
      
      newSlide:(data)->
        console.log "render new"
        slide = data
        slideView = new SlideView 
          model : slide
        console.log slideView
        if slide.get('sent')
          $('.Sent').append(slideView.render().el)
        else
          $('.toSend').append(slideView.render().el)
          # ...

      choose:()->
        $('.confList').trigger 'conferenceChoosed',  @model.get('id') 
        id= @model.get('id')
        console.log id
        href= '/anime/'+ id
        Backbone.history.navigate(href, trigger:true)


