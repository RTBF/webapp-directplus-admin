require.config
    baseUrl: 'js/'
    paths: 
      jquery: 'lib/jquery/jquery'
      spine: 'lib/spine/spine'
      handlebars: 'lib/handlebars/handlebars'

    
define 'app', ['jquery','spine','handlebars'] , ($)->
  class App extends Spine.controller
    constructor: () ->
      super




