require.config
    baseUrl: 'js/'

Spine = require('lib/spine/spine') unless Spine?
  
Spine.Model.Store =  #Classe? Module
  extended: () ->
    @change(@saveLocal)
    @fetch(@loadLocal)
    # ...

  saveLocal: ->
    result = JSON.stringify(this)
    localStorage[@className] = result

  loadLocal: ->
    result = localStorage[@className]
    @refresh(result or [], clear: true)
    
  @find: (id) ->
    (@records or= {})[id]

module?.exports = Spine.Model.Store # à quoi ça sert?
