// server.mjs
// M is for Module (not Common JS); lets you use import stmt

import { createServer } from 'node:http'; // get this function from this module

// now we will have a server object
// This is MIDDLEWARE - what happens in between a request and a response
const server = createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World!\n');
});

// starts a simple http server locally on port 3000
// logs to NODE (server side) not BROWSER (client)
server.listen(3000, '127.0.0.1', () => {
  console.log('Listening on 127.0.0.1:3000');
});

// run with `node server.mjs`
