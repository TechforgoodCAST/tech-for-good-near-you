module.exports = {
  method: 'GET',
  path: '/',
  handler: function (request, reply) {
    reply.file('./public/index.html')
  }
}
