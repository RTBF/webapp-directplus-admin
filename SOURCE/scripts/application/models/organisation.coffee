define [
  'jquery'
  'backbone'
  'application/models/conference'
  'application/collections/conferences'
  ],($,Backbone,Conference,Conferences)->

    class Organisation extends Backbone.Model

      defaults:
        tumb: " "
        description: " "
        name: " "
        conferencesC: new Conferences()

     
      constructor: (aOrg)->
        super aOrg
         # ...

      restore:(data)->
        @get('conferencesC').reset()
        len = data.length - 1
        if len>=0
          for x in [0..len]
            console.log "le x vaut #{x}"
            conference = new Conference data[x]
            conference.set 'id', data[x]._id
            @get('conferencesC').add conference
        @trigger 'change:conferencesC'

      conferenceChoosed:(id)->
        confsFound = @get('conferencesC').where _id:id
        @set 'conference', confsFound[0]
        console.log 'mon choix de conf: ', @get('conference')

      createConf:(data)->

        conference = new Conference data
        conference.set 'id', data._id
        @get('conferencesC').add conference
        @trigger 'new', @get('conferencesC').get(data._id)

      deleteConf:(data)->
        @get('conferencesC').remove @get('conferencesC').get(data)
        
     

