define [
  'jquery'
  'backbone'
  'application/views/organisationView'
  ],($,Backbone,OrganisationView)->

    class mainView extends Backbone.View
   

      el: '#header'

      #template : _.template($('#app-template').html())

      initialize : ()->
        #@listenTo @model, 'change', @render
        @listenTo @model, 'change:organisations', @render
        @listenTo @model, 'new', (data)=>
          @renderNew data
        conference = @model.get('conference')
        
        ###conferenceView = new ConferenceView
          model: conference###
        $('.emissions').delegate '.organisationsList', 'organisationChoosed', (e,data)=>
          @model.organisationChoosed data

        $('.conferencesblock').delegate '.confList', 'conferenceChoosed', (e,data)=>
          @model.get('organisation').conferenceChoosed data
        
        
        $('.confList').delegate '#newConf', 'click',(evt)=>
          @newConf()

        $('.organisationsList').delegate '#newOrg', 'click',(evt)=>
          @newOrg()

        $('.slider').delegate '#delete', 'deleteSlide', (e, data)=>
          @delete data, 'deleteSlide'
        $('.slider').delegate '#preview', 'click', (e)=>
          @itemAction e, 'previewSlide'
        
        $('#modal-update').click (e)=>
          form = $('.modal-body form').serializeArray()
          type = $('.modal-legend').attr('id')
          @new e, form, type


        $('#sendbt').click (e)=>
          e.preventDefault()
          @envoyer()
        $('#rembt').click (e)=>
          e.preventDefault()
          @recuperer()
        $('#savebt').click (e)=>
          @save()
          

      render: ()->
        $('.organisation').remove()
        console.log "main view is redenring"
        @model.get('organisations').each (organisation)->
          organisationView = new OrganisationView ({model:organisation})
          $('.organisationsList').prepend(organisationView.render().el)

      renderNew:(organisation)->
        organisationView = new OrganisationView ({model:organisation})
        $('.organisationsList').prepend(organisationView.render().el)

        

      envoyer:()->
        id = $('input:radio[name=slides]:checked').attr('id');
        console.log id
        @trigger 'sendslide' , id

      recuperer:()->
        id = $('input:radio[name=slides]:checked').attr('id');
        @trigger 'removeslide', id

      itemAction:(e, eventitem)->
        id = $(e.target).parent().prev().attr('id')
        console.log eventitem
        @trigger eventitem , id

      delete:(data)->
        console.log 'je dois detruire ce slide: ', data
        @trigger 'deleteSlide' , data

      preview:(e)->

      update:(e, form)->
        slide= @getContentForm(form,'slide')
        slide._id =  $('.modal-body').attr('id')
        slide.type = $('.modal-body').attr('data')
        slide._conf = @model.get('organisation').get('conference').get '_id'
        @trigger 'updateSlide', slide
        $('#myModal').modal('hide')


      save: ()->
        form = $('.tab-pane.active > form').serializeArray()
        if $('.tab-pane.active').attr('id') is 'settings'
          conference = @getContentForm(form,'settings')
          conference._id = @model.get('organisation').get('conference').get '_id'
          @trigger 'updateConference' , conference
        else
          slide = @getContentForm(form,'slide')
          slide.type = $('.tab-pane.active').attr('id')
          slide._conf = @model.get('organisation').get('conference').get '_id'
          console.log slide
          @trigger 'saveslide', slide

      getContentForm:(form,type)->
        obj= {}
        slide = {}
        for o of form
          nameg=form[o].name
          obj[nameg] = form[o].value
        if type is 'slide'
          slide.jsonData = JSON.stringify obj
        else
          slide = obj
        slide

      newConf:()->
        $(".modal-body").children().remove()
        console.log $("#settings form").html()
        $("#settings form").clone().appendTo ".modal-body"
        $(".modal-body legend").addClass("modal-legend")
        $(".modal-legend").attr("id", "conference")

      newOrg:()->
        $(".modal-body").children().remove()
        $(".orgsettings form").clone().appendTo ".modal-body"
        $(".modal-body legend").addClass("modal-legend")
        $(".modal-legend").attr("id", "organisation")

      saveConf:(e, form)->
        conference= @getContentForm form , 'conference' 
        conference._orga = @model.get('organisation').get '_id'
        console.log conference
        @trigger 'newConference', conference

      saveOrg:(e, form)->
        organisation = @getContentForm form , 'organisation' 
        organisation._admin= '515c1b1950e5c6a674000001'
        console.log organisation
        @trigger 'newOrganisation', organisation

      new:(e, form, type)->
        switch type
          when 'conference'
            @saveConf e, form
          when 'organisation'
            @saveOrg e, form
          when 'slide'
            @update e , form





          
          