function sendScrollDistanceToElm (app, _marker) {
  console.log(_marker.url)
  const el = document.getElementById(_marker.url)
  app.ports.scrollToEvent.send(el.offsetTop)
}

module.exports = {
  sendScrollDistanceToElm
}
