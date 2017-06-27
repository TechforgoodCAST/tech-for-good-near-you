function sendScrollDistanceToElm (app, _marker) {
  const el = document.getElementById(_marker.url)
  app.ports.scrollToEvent.send(el.offsetTop)
}

function openElmMobileBottomNav (app) {
  app.ports.openBottomNav.send(true)
}

module.exports = {
  sendScrollDistanceToElm,
  openElmMobileBottomNav
}
