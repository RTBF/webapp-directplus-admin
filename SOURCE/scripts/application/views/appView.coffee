define [
  'jquery'
  'backbone'
  'application/models/slide'
  'application/views/slideView'
  'application/collections/slides'
  'vendors/socketio/socketio'
  ],($,Backbone,Slide,SlideView,Slides)->

   

    class appView extends Backbone.View

      #template : _.template($('#app-template').html())

      #events:
      

      initialize : ()->
        @slides = new Slides()
        @slides.fetch()

        @on 'sslides', (data)=>
          @render data

        @on 'snext', (data)=>
          @toSentList(data)

        @on 'sremove', (data)=>
          @toToSentList(data)

        @SlideListe = []

        $('#sendbt').bind 'click', ()=>
          @envoyer()
        $('#rembt').bind 'click', ()=>
          @recuperer()


      render: (data)-> 
        len = data.length - 1
        for x in [0..len]
          obj= $.parseJSON data[x].JsonData
          slide = new Slide obj
          slide.set("conf", data[x]._conf )
          slide.set("sent", data[x].Sent)
          slide.set("_id", data[x]._id)
          slide.set("Order", data[x].Order)
          slide.set("Type", data[x].Type)
          @slides.add slide
          slide.save()
          @slides.fetch()
          console.log slide
          slideView = new SlideView 
            model : slide
          if slide.get('sent')
            $('.Sent').append(slideView.render().el)
          else
            $('.toSend').append(slideView.render().el)
            # ...

      envoyer:()->
        id = $('input:radio[name=slides]:checked').parent().parent().attr('id');
        slide = @slides.get id
        @trigger 'send', slide.toJSON()
      
      toSentList:(data)->
        console.log data
        lid= '#'+data.id
        slideView = new SlideView 
          model : @slides.get(data.id)
        console.log slideView
        console.log slideView.render().el
        $('.Sent').append(slideView.render().el)
        $(lid).parent().parent().remove()


      recuperer:()->
        id = $('input:radio[name=slides]:checked').parent().parent().attr('id');
        slide = @slides.get id
        @trigger 'remove', slide.toJSON()

      toToSentList:(data)->
        console.log "je suis ic", data
        lid= '#'+data.id
        $(lid).parent().parent().remove()
        slideView = new SlideView 
          model : @slides.get(data.id)
        $('.toSend').append(slideView.render().el)

        




