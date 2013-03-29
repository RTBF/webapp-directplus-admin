mongoose = require  "mongoose"
Schema = mongoose.Schema

OrganisationSchema = Schema
    _admin: 
      type: Schema.Types.ObjectId 
      ref: 'Admin'
    name: String
    conferences: [
      type: Schema.Types.ObjectId
      ref: 'Conference'] 

module.exports= mongoose.model 'Organisation', OrganisationSchema , 'organisations'