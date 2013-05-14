define [
  'jquery'
  'backbone'
  'application/collections/organisations'
  'application/models/organisation'
  ],($,Backbone,Organisations,Organisation)->

    class App extends Backbone.Model
      defaults:
        organisations: new Organisations()
        #conference : new Conference()
      initialize : ()->
        @on 'organisations', (data)=>
          @restore data
        @on 'conferences', (data)=>
          @restoreConf data
        @on 'sslides', (data)=>
          console.log 'call restore'
          @restoreSlides data
        
        @on 'snext', (data)=>
          console.log 'app j ai recu le snext trigger', data
          @get('organisation').get('conference').sent data

        @on 'sremove', (data)=>
          @get('organisation').get('conference').back data

        @on 'slideCreated', (data)=>
          @get('organisation').get('conference').new data

         @on 'slideDeleted', (data)=>
          @get('organisation').get('conference').delete data

        @on 'slideUpdated', (data)=>
          @get('organisation').get('conference').update data

        @on 'confCreated', (data)=>
          @get('organisation').createConf data

        @on 'orgCreated', (data)=>
          @createOrg data

        @on 'confdeleted',(data)=>
          @get('organisation').deleteConf data
        
        @on 'orgdeleted', (data)=>
          @deleteOrg data

        @on 'orgupdated', (data)=>
          @updateOrg data



      restore:(data)->
        @get('organisations').reset()
        len = data.length - 1
        if len>=0
          for x in [0..len]
            organisation = new Organisation data[x]
            organisation.set("id", data[x]._id )
            @get('organisations').add organisation
        @trigger 'change:organisations'
        console.log @get 'organisations'

      restoreConf : (data)->
        @get('organisation').restore data

      restoreSlides : (data)->
        @get('organisation').get('conference').restore data

      organisationChoosed : (id)->
        organisationsFound = @get('organisations').where _id:id
        console.log organisationsFound[0]
        @set 'organisation', organisationsFound[0]

      createOrg:(data)->
        organisation = new Organisation data
        organisation.set("id", data._id )
        @get('organisations').add organisation
        @trigger 'new', @get('organisations').get(data._id)

      deleteOrg:(data)->
        @get('organisations').remove @get('organisations').get(data)

      updateOrg:(data)->
        console.log "app :", data
        org = @get('organisations').get(data._id)
        @get('organisations').get(data._id).name = data.name if data.name
        @get('organisations').get(data._id).tumb = data.tumb if data.tumb
        @get('organisations').get(data._id).descrition = data.descrition if data.descrition












      
        
