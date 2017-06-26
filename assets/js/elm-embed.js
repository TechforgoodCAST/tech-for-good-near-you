import {
  initMap,
  updateMarkers,
  updateUserLocation,
  centerMapOnUser,
  centerEvent,
  fitBounds,
  resizeMap
} from './gmap'

function init (Elm) {
  var node = document.getElementById('elm-app')
  var app = Elm.Main.embed(node)

  app.ports.initMap.subscribe(initMap)
  app.ports.updateMarkers.subscribe(updateMarkers(app))
  app.ports.updateUserLocation.subscribe(updateUserLocation)
  app.ports.centerMapOnUser_.subscribe(centerMapOnUser)
  app.ports.centerEvent.subscribe(centerEvent)
  app.ports.fitBounds_.subscribe(fitBounds)
  app.ports.resizeMap_.subscribe(resizeMap)
}

module.exports = { init }
