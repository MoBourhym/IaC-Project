const http = require('http');

const port = 3000;
const version = 'v 2.225'; // Update this manually or via CI/CD later

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end(`Hello GLSID ${version}\n`);
  } else {
    res.writeHead(404);
    res.end('Page not found\n');
  }
});

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});