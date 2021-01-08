const express = require('express');

let app = express();
let server = require('http').createServer(app);


app.get('/', function(req, res) {
    res.send("online");
});

server.listen(5002);
