#!/bin/sh

BASE_URL=${1:-http://localhost:3000}

curl -s -o /dev/null -w "%{http_code} GET /health\n" \
  $BASE_URL/health

curl -s -o /dev/null -w "%{http_code} POST /users\n" \
  -X POST $BASE_URL/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com"}'

curl -s -o /dev/null -w "%{http_code} PUT /users/42\n" \
  -X PUT $BASE_URL/users/42 \
  -H "Content-Type: application/json" \
  -d '{"name":"Bob","role":"admin"}'

curl -s -o /dev/null -w "%{http_code} DELETE /orders/99\n" \
  -X DELETE $BASE_URL/orders/99

curl -s -o /dev/null -w "%{http_code} POST /events/track\n" \
  -X POST $BASE_URL/events/track \
  -H "Content-Type: application/json" \
  -d '{"event":"page_view","page":"/dashboard","userId":7}'

curl -s -o /dev/null -w "%{http_code} GET /search?q=express&page=2\n" \
  "${BASE_URL}/search?q=express&page=2"

curl -s -o /dev/null -w "%{http_code} POST /upload (binary)\n" \
  -X POST $BASE_URL/upload \
  -H "Content-Type: application/octet-stream" \
  --data-binary @test-files/text.txt.gz

curl -s -o /dev/null -w "%{http_code} POST /submit (multipart fields)\n" \
  -X POST $BASE_URL/submit \
  -F "username=alice" \
  -F "message=hello world"

curl -s -o /dev/null -w "%{http_code} POST /upload (multipart file)\n" \
  -X POST $BASE_URL/upload \
  -F "file=@test-files/text.txt;type=text/plain"

curl -s -o /dev/null -w "%{http_code} POST /upload (multipart fields + file)\n" \
  -X POST $BASE_URL/upload \
  -F "description=test upload" \
  -F "file=@test-files/text.txt;type=text/plain"

curl -s -o /dev/null -w "%{http_code} POST /upload (multipart binary file)\n" \
  -X POST $BASE_URL/upload \
  -F "file=@test-files/text.txt.gz;type=application/gzip"
