// app/index.js

// force production mode, gain = less than 500 req/s
process.env.NODE_ENV='production'

const express = require('express')
const app = express()
const port = 8585
const host = "169.254.237.101"

const commondHandler = require('./CommonHandler')

// disable automatic eTag header, gain = 2000 req/s
// SHA hash isn't free
app.set('etag', false);

app.get('/json', (request, response) => {
	var jsonData = commondHandler.makeJSONfast();
	response.json(jsonData);
  response.end()
})

/* Serve Static Files after /json, gain = 4000 req/s !*/
app.use(express.static('public'));

app.listen(port, host, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on ${host}:${port}`)
})
