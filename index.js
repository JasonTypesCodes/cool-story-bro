const util = require('util');
const express = require('express');
const busboy = require('busboy');

const app = express();
const PORT = 3000;

function logMultipart(req, res) {
  const fields = {};
  const files = {};
  const bb = busboy({ headers: req.headers });

  bb.on('field', (name, value) => {
    fields[name] = value;
  });

  bb.on('file', (name, stream, info) => {
    const chunks = [];
    stream.on('data', chunk => chunks.push(chunk));
    stream.on('end', () => {
      const buf = Buffer.concat(chunks);
      files[name] = {
        filename: info.filename,
        mimeType: info.mimeType,
        size: buf.length,
        content: /^text/.test(info.mimeType) ? buf.toString('utf8') : `<binary: ${buf.length} bytes>`,
      };
    });
  });

  bb.on('finish', () => {
    console.log(util.inspect({
      method: req.method,
      path: req.path,
      query: { ...req.query },
      headers: req.headers,
      body: { fields, files },
    }, { depth: null }));
    res.sendStatus(200);
  });

  req.pipe(bb);
}

app.use((req, res) => {
  const contentType = req.headers['content-type'] || '';

  if (contentType.startsWith('multipart/form-data')) {
    return logMultipart(req, res);
  }

  const chunks = [];
  req.on('data', chunk => chunks.push(chunk));
  req.on('end', () => {
    const raw = Buffer.concat(chunks);
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
}).on('error', (err) => {
  console.error(`Failed to start: ${err.message}`);
  process.exit(1);
});
