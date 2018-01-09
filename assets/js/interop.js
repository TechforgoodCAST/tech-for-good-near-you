function sendScrollDistanceToElm (app, _marker) {
  const el = document.getElementById(_marker.url)
  app.ports.scrollToEvent.send(el.offsetTop)
}

module.exports = { sendScrollDistanceToElm }
