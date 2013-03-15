// Generated by CoffeeScript 1.4.0
var Admin, Organisations, dsn, mongoose, populate;

mongoose = require('mongoose');

Admin = require('./Models/adminModel.js');

Organisations = require("./Models/organisationModel.js");

dsn = "mongodb://localhost/test";

mongoose.connect(dsn, function(err) {
  return console.log(err);
});

populate = function() {
  var fabriceData;
  fabriceData = new Admin({
    firstname: 'Fabrice',
    lastname: 'Kyams',
    email: 'fabrice.kyams@gmail.com'
  });
  fabriceData.save(function(err) {
    if (err) {
      return console.log(err);
    } else {
      return console.log('Fabrice as admin added');
    }
  });
  return console.log('Admin population');
};

populate();
