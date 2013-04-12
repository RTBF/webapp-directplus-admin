###class Serveur
  constructor: () ->

  init: ->###
express = require 'express'
app = express()
server = require('http').createServer app
io = require('socket.io').listen server
server.listen 3000
io.set 'log level' , 1
io.set 'transports', ['websocket', 'flashsocket', 'htmlfile', 'xhr-polling', 'jsonp-polling']
DBCom = require('./DBCom.js')


io.sockets.on 'connection' , (socket) =>
 
  console.log socket.id    
  socket.on 'slider', (id) =>
    DBCom.readSlideListForSlider id, (dbdata)=>
      socket.emit 'sslides', dbdata
    #TODO CHECK BD FOR ADMIN
    console.log 'admin connected'
    
  socket.on 'reset', (data) =>
    console.log 'admin asks for reseting'
    socket.broadcast.emit 'sreset', data

  socket.on 'user', (data)=>
    #socket.emit 'organisations', organisations
    DBCom.getOrgaList (dbdata)=>
      socket.emit 'organisations', dbdata
    console.log 'user connected'

  socket.on 'organisationChoosed', (id)=>
    DBCom.readConference id, (dbdata)=>
      socket.emit 'conferences', dbdata

  socket.on 'conferenceChoosed', (id)=>
    console.log 'conf choosed', id
    socket.join id
    DBCom.readSlideList id, (dbdata)=>
      socket.emit 'slides', dbdata

  socket.on 'send', (data) =>
    DBCom.readSlideToSend data._id, (dbdata)=>
      DBCom.setSent true , data._id
      socket.emit 'snext', data
      brodcastSlide 'snext', dbdata


  socket.on 'remove', (data) =>
    DBCom.readSlideToSend data._id, (dbdata)=>
      DBCom.setSent false , data._id
      socket.emit 'sremove', data 
      brodcastSlide 'sremove', dbdata 

  brodcastSlide = (message, data) =>
    console.log data._conf
    io.sockets.in(data._conf).emit message , data
  

console.log 'Serveur lancé'

  