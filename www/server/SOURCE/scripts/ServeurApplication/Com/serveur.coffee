express = require 'express'
app = express()
server = require('http').createServer app
io = require('socket.io').listen server
dbrequest = require './DBRequest.js'
indice = 0
server.listen 3000
io.set 'log level' , 1
io.set 'transports', ['websocket', 'flashsocket', 'htmlfile', 'xhr-polling', 'jsonp-polling']

class Serveur
  
  constructor: ->
    console.log "construction"
    @init()
    # ...

  init: ->
    console.log dbrequest.readOrganisations('515c1b1950e5c6a674000001')

    io.sockets.on 'connection' , (socket) =>
      
      socket.on 'admin', (data) =>
        #TODO CHECK BD FOR ADMIN
        console.log 'admin connected'
      
      socket.on 'reset', (data) =>
        console.log 'admin asks for reseting'
        socket.broadcast.emit 'sreset', data

      socket.on 'user', (data)=>
        socket.name = data.name
        console.log 'user connected'

      socket.on 'next', (data) =>
        @brodcastSlide 'snext', data , socket

      socket.on 'remove', (data) =>
        @brodcastSlide 'sremove', data , socket
 
  brodcastSlide : (message, data, socket) =>
    socket.emit message, data
    socket.broadcast.emit message, data

serveur = new Serveur()





  
