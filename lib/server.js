const Hapi = require('hapi')
const server = new Hapi.Server()

const Plugins =
  ['inert'
  , 'hapi-require-https'
  ].map(require)

const Routes =
  [ './routes/index'
  , './routes/static'
  , './routes/events'
  ].map(require)

server.connection({
  port: process.env.PORT || 3000,
  routes: { cors: true }
})

server.register(Plugins, (err) => { if (err) throw err })
server.route(Routes)

module.exports = server
