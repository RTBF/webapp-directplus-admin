define [
  'jquery'
  'backbone'
  'text!application/templates/main/main.html'
  ],($,Backbone,MainTemplate)->
    class mainScreen extends Backbone.View
      constructor:(options)->
        super options

      render:()->
        $(@el).html(MainTemplate)
        console.log "mainScreen Render called"
        $("#loading").fadeOut()
        $("#wrap").fadeIn()
