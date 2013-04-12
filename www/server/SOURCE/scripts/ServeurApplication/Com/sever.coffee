###class Serveur
  constructor: () ->

  init: ->###
mongoose = require 'mongoose'
Admin = require '../Models/Admin.js'
Slide = require '../Models/Slide.js'
Organisation = require "../Models/Organisation.js"
Conference =  require "../Models/Conference.js"
async = require 'async'
    
dsn = "mongodb://localhost/WebConference"
mongoose.connect dsn
confDB = mongoose.connection
confDB.on 'error', console.error.bind(console, 'connection error:')

express = require 'express'
app = express()
server = require('http').createServer app
io = require('socket.io').listen server
indice = 0
server.listen 3000
io.set 'log level' , 1
io.set 'transports', ['websocket', 'flashsocket', 'htmlfile', 'xhr-polling', 'jsonp-polling']


io.sockets.on 'connection' , (socket) ->
  console.log "hello"
  confDB.once 'open', ()=>      
    console.log "I am here"
    @Admin
    .findOne 
      _id:AdminId
      (err, admin)=>
        console.log "please come here"
        if err
          callback(err)
          return
          #console.log "error while trying to find the organisations of this admin"
    .populate('organisations')
    .exec (err, admin)=>
      console.log  organisation = JSON.stringify admin.organisations
      console.log "premier log:" , organisation    
      #TODO CHECK BD FOR ADMIN
    socket.on 'admin', (data) ->
      console.log 'admin connected'
      
    socket.on 'reset', (data) ->
      console.log 'admin asks for reseting'
      socket.broadcast.emit 'sreset', data

    socket.on 'user', (data)->
      socket.name = data.name
      console.log 'user connected'

    socket.on 'next', (data) ->
      brodcastSlide 'snext', data

    socket.on 'remove', (data) ->
      brodcastSlide 'sremove', data

    brodcastSlide = (message, data) ->
      socket.emit message, data
      socket.broadcast.emit message, data

console.log 'Serveur lancé'

  