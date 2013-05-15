define [
  'jquery'
  'backbone'
  'application/collections/slides'
  'application/models/slide'
  ],($,Backbone,Slides,Slide)->

    class Conference extends Backbone.Model

      defaults:
        slidesC: new Slides()
        count: 0
        date: new Date()
        descrition: ""
        name:""

      constructor: (aConf)->
        super aConf
         # ...

      initialize:()->
        #

      restore: (data)->
        console.log "restore"
        console.log data
        @get('slidesC').reset()
        len = data.length - 1
        if len>=0
          localStorage.clear()
          @get('slidesC').fetch();
          len = data.length - 1
          for x in [0..len]
            @addSlide(data[x])
            @get('slidesC').fetch()
          @get('slidesC').sort()
          newCount=  @get('slidesC').at(@get('slidesC').length-1).get 'Order' 
        @trigger 'change:slidesC'

      sent:(data)->
        console.log 'je suis la Conference et j envoi ça:' , data
        slides= @get('slidesC').where _id:data
        console.log 'je suis la conference et voici ce que jai trouvé dans mes modele: ', slides[0]
        slides[0].set 'sent', true


      back:(data)->
        slides= @get('slidesC').where _id:data
        console.log slides[0]
        slides[0].set 'sent', false

      new: (data)->
        @addSlide(data)
        console.log "new triggered"
        @trigger 'new' , @get('slidesC').get(data._id)

      delete: (data)->
        console.log 'sur le point de supprimer le slide d id:', data
        @get('slidesC').remove @get('slidesC').get(data)

      update: (data)->
        console.log "sur le point de mettre à jour le slide"
        obj = $.parseJSON data.JsonData
        $.each obj , (key, val)=>
          @get('slidesC').get(data._id).set key , val
      
      addSlide:(dataSlide)->
        obj= $.parseJSON dataSlide.JsonData
        obj.id = dataSlide._id
        slide = new Slide obj
        slide.set("conf", dataSlide._conf )
        slide.set("sent", dataSlide.Sent)
        slide.set("_id", dataSlide._id)
        slide.set("Order", dataSlide.Order)
        slide.set("Type", dataSlide.Type)
        @get('slidesC').add slide
        slide.save()

