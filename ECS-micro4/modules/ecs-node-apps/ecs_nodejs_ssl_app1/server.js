const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('./certs/private.key'),
  cert: fs.readFileSync('./certs/primary.crt')
};

https.createServer(options, (req, res) => {
  res.writeHead(200);
  res.end('App1:3020:Hello world\n');
}).listen(3020);
