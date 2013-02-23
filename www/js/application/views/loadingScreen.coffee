define [
  'jquery'
  'backbone'
  'text!application/templates/loading/loading.html'
  ],($,Backbone,LoadingTemplate)->
    class loadingScreen extends Backbone.View
      constructor:(options)->
        super options

      render:()->
        $(@el).html(LoadingTemplate)
        console.log "loadingScreen Render called"

