const Hapi = require('hapi')
const handlePlugins = require('./helpers/sever_helpers.js')

const Plugins = [ 'inert' ].map(require)
const Routes = [ './routes/index', './routes/static', './routes/events' ].map(require)

const server = new Hapi.Server()

server.connection({ port: process.env.PORT || 3000, routes: { cors: true } })

server.register(Plugins, handlePlugins)
server.route(Routes)

module.exports = server
