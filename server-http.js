const express = require('express');
const { spawn } = require('child_process');

const app = express();
const PORT = 9002;

app.use(express.json());

app.post('/mcp', (req, res) => {
  const child = spawn(process.execPath, ['build/index.js'], {
    stdio: ['pipe', 'pipe', 'inherit'],
  });

  let responseBuffer = '';

  child.stdout.on('data', (chunk) => {
    responseBuffer += chunk.toString();
  });

  child.on('error', (error) => {
    res.status(500).send(error.message);
  });

  child.on('close', () => {
    res.type('application/json').send(responseBuffer);
  });

  let payload = JSON.stringify(req.body ?? {});
  if (!payload.endsWith('\n')) {
    payload += '\n';
  }
  child.stdin.end(payload);
});

app.listen(PORT, () => {
  console.log(`MCP HTTP bridge listening on port ${PORT}`);
});
