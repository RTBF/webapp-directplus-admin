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
        'click #deleteconf' : 'deleteconf'


      initialize : ()->
        console.log "Counter: #{ConferenceView.counter}"
        @id = ConferenceView.counter
        ConferenceView.counter++
        @listenTo @model, 'change', @render
        @listenTo @model, 'change:slidesC', @renderList
        @listenTo @model, 'new', (data)=>
          @newSlide(data)
        @listenTo @model, 'remove', @remove
      

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

      deleteconf:()->
        if (confirm("Are you sure?"))
          $('#deleteconf').trigger 'deleteconf', @model.get 'id'

      remove:()->
        id = '#'+@model.get 'id'
        $(id).parent().slideUp()