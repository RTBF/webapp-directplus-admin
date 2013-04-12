var mongoose = require('mongoose');

mongoose.connect('mongo://localhost/xxx');

var conn = mongoose.connection;

['aaa','bbb','ccc'].forEach(function(name){
    conn.collection(name).drop(function(err) {
        console.log('dropped');
    });
});
console.log('all dropped');