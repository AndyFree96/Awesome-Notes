const slugify = require('slugify');
const http = require('http');
const fs = require('fs');
const url = require('url');

const server = http.createServer((req, res) => {
  console.log(req.url);
  res.end('Hello World');
});

server.listen(5000, '127.0.0.1', () => {
  console.log('Start on port 5000');
});
