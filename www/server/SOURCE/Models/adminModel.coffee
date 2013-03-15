mongoose = require  "mongoose"
Schema = mongoose.Schema

AdminSchema = new Schema 
  firstname: String
  lastname: String
  email: 
    type: String
    required: true
    index:
      unique: true 
  organisations: [
    type: Schema.Types.ObjectId
    ref: 'Organisation' 
  ]

module.exports = mongoose.model 'Admin', AdminSchema , 'admins'