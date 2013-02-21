require.config
    baseUrl: 'js/'
    paths: 
      jquery: 'lib/jquery/jquery'
      spine: 'lib/spine/spine'
      handlebars: 'lib/handlebars/handlebars'
      JSON: 'lib/json2.js'

    
define 'app', ['jquery','spine','handlebars','JSON'] , ($)->
  class App extends Spine.Controller
    constructor: () ->
      console.log "bootstrap works"

  myApp = new App();



