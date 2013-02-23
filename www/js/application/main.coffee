# require configuration
# baseUrl: is the baseUrl of all the following path, relative to the index.html
# path: key value represent path shortcut to easierly depends from a library
# shim: allows non AMD libraries to be required and exports them
requirejs.config
  baseUrl: 'js/'
  paths:
    jquery: 'vendors/jquery/jquery'
    underscore: 'vendors/underscore/underscore'
    backbone: 'vendors/backbone/backbone'
    bootstrap: 'vendors/bootstrap/bootstrap'
    text: 'vendors/require/text'
  shim:
    backbone:
      deps: ['jquery','underscore']
      exports: 'Backbone'
    underscore:
      exports: '_'
    bootstrap : ['jquery']
  wait: '5s'

# require 
require ['backbone','jquery','application/application', 'bootstrap'],(Backbone,$,Application) ->
  $ ()->
    App = new Application()
    App.init()



