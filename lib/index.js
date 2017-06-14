const server = require('./server.js')

server.start((err) => {
  if (err) throw err
  console.log(`Server running at: ${server.info.uri}`)
})
