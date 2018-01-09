import {
  initMap,
  updateMarkers,
  updateUserLocation,
  clearUserLocation,
  centerMapOnUser,
  centerEvent,
  fitBounds,
  resizeMap
} from './gmap'

function init (Elm) {
  var node = document.getElementById('elm-app')
  var app = Elm.App.embed(node)

  app.ports.initMap.subscribe(initMap)
  app.ports.updateMarkers.subscribe(updateMarkers(app))
  app.ports.updateUserLocation.subscribe(updateUserLocation)
  app.ports.clearUserLocation_.subscribe(clearUserLocation)
  app.ports.centerMapOnUser_.subscribe(centerMapOnUser)
  app.ports.centerEvent.subscribe(centerEvent)
  app.ports.fitBounds_.subscribe(fitBounds)
  app.ports.resizeMap_.subscribe(resizeMap)
}

module.exports = { init }
