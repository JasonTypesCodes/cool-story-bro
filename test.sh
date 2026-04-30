#!/bin/sh

curl -s -o /dev/null -w "%{http_code} GET /health\n" \
  http://localhost:3000/health

curl -s -o /dev/null -w "%{http_code} POST /users\n" \
  -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com"}'

curl -s -o /dev/null -w "%{http_code} PUT /users/42\n" \
  -X PUT http://localhost:3000/users/42 \
  -H "Content-Type: application/json" \
  -d '{"name":"Bob","role":"admin"}'

curl -s -o /dev/null -w "%{http_code} DELETE /orders/99\n" \
  -X DELETE http://localhost:3000/orders/99

curl -s -o /dev/null -w "%{http_code} POST /events/track\n" \
  -X POST http://localhost:3000/events/track \
  -H "Content-Type: application/json" \
  -d '{"event":"page_view","page":"/dashboard","userId":7}'

curl -s -o /dev/null -w "%{http_code} GET /search?q=express&page=2\n" \
  "http://localhost:3000/search?q=express&page=2"

curl -s -o /dev/null -w "%{http_code} POST /upload (binary)\n" \
  -X POST http://localhost:3000/upload \
  -H "Content-Type: application/octet-stream" \
  --data-binary @README.md
