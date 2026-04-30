const express = require('express');

const app = express();
const PORT = 3000;

app.use((req, res) => {
  const chunks = [];
  req.on('data', chunk => chunks.push(chunk));
  req.on('end', () => {
    const raw = Buffer.concat(chunks);
    const contentType = req.headers['content-type'] || '';
    const isText = /text|json|xml|form-urlencoded/.test(contentType);
    const body = raw.length === 0
      ? '(empty)'
      : isText
        ? raw.toString('utf8')
        : `<binary: ${raw.length} bytes>`;

    console.log({
      method: req.method,
      path: req.path,
      query: { ...req.query },
      headers: req.headers,
      body,
    });
    res.sendStatus(200);
  });
});

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});
