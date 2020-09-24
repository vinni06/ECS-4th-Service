const https = require('https');
const fs = require('fs');
const express = require('express');
var app = express();
const httpsPort = 3022;
var logger = require('./cloudwatchLogger');
//var https = require('https');

const options = {
    key: fs.readFileSync('./certs/private.key'),
    cert: fs.readFileSync('./certs/primary.crt')
};

var secureServer = https.createServer(options, app).listen(httpsPort, () => {
    console.log(">> CentraliZr winston listening at port " + httpsPort);
});

app.get('/', function (req, res) {
  res.send('Health check path / accessed!!..')
})

app.get('/apple/contacts', function (req, res) {
    res.sendFile(__dirname + '/public/index.htm');
});

app.get('/apple/leads', function (req, res) {
    res.sendFile(__dirname + '/public/index1.htm');
});
app.get('/apple/accounts', function (req, res) {
    res.sendFile(__dirname + '/public/index2.htm');
});



/*https.createServer(options, (req, res) => {
res.writeHead(200);
res.end('hello! application 2 on 3021\n');
}).listen(3021);*/
