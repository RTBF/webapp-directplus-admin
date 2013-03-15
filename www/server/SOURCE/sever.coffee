###class Serveur
  constructor: () ->

  init: ->###
express = require 'express'
Admin = require './Models/adminModel.js'
app = express()
server = require('http').createServer app
io = require('socket.io').listen server
indice = 0
server.listen 3000
io.set 'log level' , 1
io.set 'transports', ['websocket', 'flashsocket', 'htmlfile', 'xhr-polling', 'jsonp-polling']

io.sockets.on 'connection' , (socket) ->
      
  socket.on 'admin', (data) ->
    #TODO CHECK BD FOR ADMIN
    console.log 'admin connected'
    
  socket.on 'reset', (data) ->
    console.log 'admin asks for reseting'
    socket.broadcast.emit 'sreset', data

  socket.on 'user', (data)->
    socket.name = data.name
    console.log 'user connected'

  socket.on 'next', (data) ->
    brodcastSlide 'snext', data

  brodcastSlide = (message, data) ->
    socket.emit message, data
    socket.broadcast.emit message, data

console.log 'Serveur lancé'

  