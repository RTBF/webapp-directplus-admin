mongoose = require  "mongoose"
Schema = mongoose.Schema

OrganisationSchema = Schema
    _admin: 
      type: Schema.Types.ObjectId 
      ref: 'Admin'
      required: true
    name: 
      type: String
      required: true
    tumb:
      type: String
    description:
      type:String
    conferences: [
      type: Schema.Types.ObjectId
      ref: 'Conference'
      index:
        unique: true
    ] 

module.exports= mongoose.model 'Organisation', OrganisationSchema , 'organisations'