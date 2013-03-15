mongoose = require  "mongoose"
Schema = mongoose.Schema

OrganisationSchema = new mongoose.Schema
  _admin: 
    type: Schema.Types.ObjectId 
    ref: 'Admin'
  name: String
  date: Date
  conferences: [
    type: Schema.Types.ObjectId
    ref: 'Conference'] 

module.exports= mongoose.model 'Organisation', OrganisationSchema , 'organisations'