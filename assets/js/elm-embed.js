import {
  initMap,
  updateMarkers,
  updateUserLocation,
  centerMapOnUser,
  centerEvent
} from './gmap'

function init (Elm) {
  var node = document.getElementById('elm-app')
  var app = Elm.Main.embed(node)

  app.ports.initMap.subscribe(initMap)
  app.ports.updateMarkers.subscribe(updateMarkers)
  app.ports.updateUserLocation.subscribe(updateUserLocation)
  app.ports.centerMapOnUser.subscribe(centerMapOnUser)
  app.ports.centerEvent.subscribe(centerEvent)
}

module.exports = { init }
