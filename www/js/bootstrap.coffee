require.config
    baseUrl: 'js/'
    paths: 
      jquery: 'lib/jquery/jquery'
      spine: 'lib/spine/spine'
      handlebars: 'lib/handlebars/handlebars'

    
define 'app', ['jquery','spine','handlebars'] , ($)->
  class App extends Spine.Controller
    constructor: () ->
      console.log "bootstrap works"

  myApp = new App();



