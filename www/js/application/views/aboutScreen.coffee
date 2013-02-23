define [
  'jquery'
  'backbone'
  'text!application/templates/about/about.html'
  ],($,Backbone,AboutTemplate)->
    class aboutScreen extends Backbone.View
      constructor:(options)->
        super options

      render:()->
        $(@el).html(AboutTemplate)
        console.log "aboutScreen Render called"

