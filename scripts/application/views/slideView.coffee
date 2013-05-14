define [
  'jquery'
  'backbone'
  ],($,Backbone)->

    class slideView extends Backbone.View

      events:
        'click #delete' : 'delete'
        'click #update' : 'update'
        'click #preview': 'preview'

      tagName : 'li'
      className : 'slide'

      template : _.template($('#slide-template').html())

      initialize : ()->
        @listenTo @model, 'change', @render
        @listenTo @model, 'change:sent', @sendrender
        @listenTo @model, 'remove', @remove
        console.log "Slide view initialization"

      render: ()-> 
        @$el.html @template(@model.toJSON())
        @

      sendrender: ()->
        console.log "je suis render de slide view et voila"
        modelId = '#'+@model.get('id')
        if @model.get('sent') is true
          console.log "it is true"
          $(modelId).parent().parent().parent().parent().slideUp ()=>
            $(modelId).parent().parent().parent().parent().appendTo('.Sent').slideDown()
        else
          console.log "it is false"
          $(modelId).parent().parent().parent().parent().slideUp ()=>
            $(modelId).parent().parent().parent().parent().appendTo('.toSend').slideDown()

      remove:()->
        modelId = '#'+@model.get('id')
        $(modelId).parent().parent().parent().parent().slideUp ()=>

      delete : ()->
        if (confirm("Are you sure?"))
          $('#delete').trigger 'deleteSlide' , @model.get('id')

      update : ()->
        console.log 'update test'
        #utiliser une modal
        cat = '#'+@model.get 'Type'
        console.log @model
        $(".modal-body").children().remove()
        $(".modal-body").attr 'id', @model.get('id')
        $(".modal-body").attr 'data', @model.get('Type')
        $("#{cat} form").clone().appendTo ".modal-body"
        $(".modal-save").attr("id", "modal-update")
        
        $(".modal-body input[name='title']").val @model.get('title')
        $(".modal-body textarea[name='description']").val @model.get('description')
        $(".modal-body input[name='thumb']").val @model.get('thumb')
        $(".modal-body textarea[name='content']").val @model.get('content')
        $(".modal-body legend").addClass("modal-legend")
        $(".modal-legend").attr("id", "slide")


        #
      preview: ()->
        #