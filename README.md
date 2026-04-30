# cool-story-bro

A minimal Express REST HTTP service that responds `200 OK` to every request — regardless of method, path, query parameters, or body — and logs the request details to the console.

## What it does

- Accepts any HTTP method (`GET`, `POST`, `PUT`, `DELETE`, etc.)
- Accepts any path
- Always responds with `200 OK`
- Logs method, path, query params, headers, and body to stdout

## Why?

Useful for standing up as the recipient of a webhook to see / verify content being sent.

## Running locally

```bash
npm install
npm start
```

The server listens on port **3000**.

## Running with Docker

```bash
docker build -t cool-story-bro .
docker run -p 3000:3000 cool-story-bro
```

## Testing

A `test.sh` script is included that fires a handful of requests covering different methods, paths, bodies, and a binary upload:

```bash
./test.sh
```

Each line of output shows the HTTP status code and the request that was made:

```
200 GET /health
200 POST /users
200 PUT /users/42
200 DELETE /orders/99
200 POST /events/track
200 GET /search?q=express&page=2
200 POST /upload (binary)
```

## Example

```bash
curl -X POST "http://localhost:3000/foo?bar=1" \
  -H "Content-Type: application/json" \
  -d '{"hello":"world"}'
```

**Response:** `OK` (HTTP 200)

**Console output:**
```
{
  method: 'POST',
  path: '/foo',
  query: { bar: '1' },
  headers: { 'content-type': 'application/json', ... },
  body: { hello: 'world' }
}
```
