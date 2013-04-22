define [
  'jquery'
  'backbone'
  'application/views/slideScreen'
  ],($,Backbone,SlideView)->

    class ConferenceView extends Backbone.View

      #el: '#appcontainer'

      tagName : 'li'
      className : 'conf'

      template : _.template($('#conf-template').html())

      initialize : ()->
       @listenTo @model, 'change', @render
       @listenTo @model, 'new', @new

      render: ()-> 
        @$el.html @template(@model.toJSON())
        if $('#SlideList').is ':empty'
          @model.get('slidesC').each (slide)->
            console.log slide
            console.log slide.get('state')
            slideView = new SlideView 
              model : slide
            slideView.render()
        @
      
      new:()->
        slide = @model.get('slidesC').at @model.get('slidesC').length - 1
        slideView = new SlideView 
          model : slide
        slideView.new()

 



