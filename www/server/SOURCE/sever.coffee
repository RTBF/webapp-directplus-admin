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
DBCreate = require('./DBCreate.js')


io.sockets.on 'connection' , (socket) =>
  
  ### CONNECTION DE L'ADMIN ###
  console.log socket.id    
  socket.on 'slider', (id) =>
    DBCom.readSlideListForSlider id, (dbdata)=>
      socket.emit 'sslides', dbdata
    #TODO CHECK BD FOR ADMIN
    console.log 'admin connected'

    
  ### ###
  socket.on 'reset', (data) =>
    console.log 'admin asks for reseting'
    socket.broadcast.emit 'sreset', data


  ### CONNECTION USER ###
  socket.on 'user', (data)=>
    #socket.emit 'organisations', organisations
    DBCom.getOrgaList (dbdata)=>
      socket.emit 'organisations', dbdata
    console.log 'user connected'

  ### CONNECTION DE L'ADMIN###
  socket.on 'admin', (id)=>
    console.log "received connection from admin: ", id
    DBCom.getOrgaListfromAdmin id, (dbdata)=>
      console.log dbdata
      socket.emit 'organisations' , dbdata 


  ### CHOIX DE L'ORGANISATION PAR LE USER ###
  socket.on 'organisationChoosed', (id)=>
    DBCom.readConference id, (dbdata)=>
      socket.emit 'conferences', dbdata


  ### CHOIX DE LA CONFERENCE PAR LE USER ###
  socket.on 'conferenceChoosed', (id)=>
    console.log 'conf choosed', id
    socket.join id
    DBCom.readSlideList id, (dbdata)=>
      socket.emit 'slides', dbdata


  ### ENVOIE D'UN SLIDE PAR L'ADMIN ###
  socket.on 'send', (data) =>
    console.log data
    DBCom.readSlideToSend data, (dbdata)=>
      DBCom.setSent true , data
      socket.emit 'sent', data
      brodcastSlide 'snext', dbdata


  ### RETRAIT D'UN SLIDE PAR L'ADMIN ###
  socket.on 'remove', (data) =>
    DBCom.readSlideToSend data, (dbdata)=>
      DBCom.setSent false , data
      socket.emit 'sremove', data 
      brodcastSlide 'sremove', dbdata 


  ### CREATION D'UN SLIDE PAR L'ADMIN ###
  socket.on 'createSlide', (data)=>
    #console.log data
    DBCreate.CreateSlide data, (dbdata)=>
      console.log dbdata
      socket.emit 'slideCreated', dbdata


  ### UPDATE D'UN SLIDE PAR L'ADMIN ###
  socket.on 'updateSlide', (data)=>
    DBCreate.UpdateSlide data, (dbdata)=>
      socket.emit 'slideUpdated', dbdata
      if dbdata.Sent is true
        brodcastSlide 'slideUpdated', dbdata 
        # ...
      

  ### SUPPRESSION D'UNE SLIDE PAR L'ADMIN ###
  socket.on 'deleteSlide', (data)=>
    console.log 'reçu un slide à detruire'
    DBCreate.DeleteSlide data, (dbdata)=>
      console.log dbdata
      socket.emit 'slideDeleted', (dbdata)
      if dbdata.Sent is true
        brodcastSlide 'sremove', dbdata 

  socket.on 'newOrganisation', (data)=>
    DBCreate.CreateOrganisation data, (dbdata)=>
      socket.emit 'orgCreated', dbdata

  socket.on 'newConference', (data)=>
    DBCreate.CreateConference data, (dbdata)=>
      console.log dbdata
      socket.emit 'confCreated', dbdata

  socket.on 'deleteConference', (data)=>
    DBCreate.DeleteConference data , (dbdata)=>
      socket.emit 'confDeleted', dbdata 
  
  socket.on 'deleteOrganisation', (data)=>
    DBCreate.DeleteOrganisation data, (dbdata)=>
      socket.emit 'orgDeleted', dbdata

  socket.on 'updateOrganisation', (data)=>
    DBCreate.UpdateOrganisation data, (dbdata)=>
      socket.emit 'orgUpdated', dbdata

  socket.on 'updateConference', (data)=>
    DBCreate.UpdateConference data , (dbdata)=>
      socket.emit 'confUpdated', dbdata 




  brodcastSlide = (message, dbdata) =>
    console.log dbdata._conf
    io.sockets.in(dbdata._conf).emit message , dbdata
  

console.log 'Serveur lancé'

  