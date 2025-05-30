const http = require('http');
require('dotenv').config(); // Load environment variables from .env

const port = process.env.PORT || 3000;
const version = process.env.APP_VERSION || 'v 1.0'; // Fallback to 'v 1.0' if not set

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