define [
  'jquery'
  'backbone'
  'application/collections/organisations'
  'application/models/organisation'
  ],($,Backbone,Organisations,Organisation)->

    class App extends Backbone.Model

      defaults:
        organisations : new Organisations()

      initialize : ()->

        @on 'organisations', (data)->
          @restore(data)
        @on 'conferences', (data)->
          @restoreConf data
        @on 'slides', (data)->
          @restoreSlides data
        @on 'newSlide', (data)->
          @conference.trigger 'newSlide', data
        @on 'next', ()->
          @conference.trigger 'next'
        @on 'previous', ()->
          @conference.trigger 'previous'
        @on 'sremove',(data)->
          @conference.trigger 'sremove', data


      restore:(data)->
        @get('organisations').reset()
        len = data.length - 1
        if len>=0
          for x in [0..len]
            organisation = new Organisation data[x]
            @get('organisations').add organisation
          @trigger 'change'
          console.log @get 'organisations'

      restoreConf : (data)->
        console.log data
        len = data.length - 1
        if len>=0
          orgId= data[0]._orga
          console.log orgId
          organisationsFound = @get('organisations').where _id:orgId
          console.log organisationsFound[0]
          @organisation = organisationsFound[0]
          @organisation.trigger 'conferences', data

      restoreSlides : (data)->
        console.log data
        len = data.length - 1
        if len>=0
          confId = data[0]._conf
          console.log confId
          confsFound = @organisation.get('conferencesC').where _id:confId
          console.log confsFound[0]
          @conference = confsFound[0]
          @conference.trigger 'slides', data



     






