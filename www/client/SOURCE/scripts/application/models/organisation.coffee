define [
  'jquery'
  'backbone'
  'application/views/organisationView'
  ],($,Backbone,OrganisationView)->

    class Organisation extends Backbone.Model

      defaults:
        _id :' ' 
        name : 'noname'

     
      constructor: (aOrg)->
        super aOrg
         # ...

  

   
  
