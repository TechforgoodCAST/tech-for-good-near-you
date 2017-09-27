import {
  initMap,
  updateMarkers,
  updateUserLocation,
  centerMapOnUser,
  centerEvent,
  fitBounds,
  resizeMap
} from './gmap'

const L = require('leaflet')
require('leaflet.markercluster')
require('leaflet-providers')

var _map

function init (Elm) {
  var node = document.getElementById('elm-app')
  var app = Elm.Main.embed(node)

  app.ports.initMap.subscribe(function ({ mapId, marker }) {
    _map = L.map(mapId).setView([marker.lat, marker.lng], 13)
    L.tileLayer.provider('Stamen.Watercolor').addTo(_map)
  })

  app.ports.updateMarkers.subscribe(function (markers) {
    var markerCluster = L.markerClusterGroup()
    markers.forEach(({ lat, lng }) => {
      markerCluster.addLayer(L.marker([lat, lng]))
    })
    _map.addLayer(markerCluster)
  })

  app.ports.updateUserLocation.subscribe(function () {})
  app.ports.centerMapOnUser_.subscribe(function () {})
  app.ports.centerEvent.subscribe(function () {})
  app.ports.fitBounds_.subscribe(function () {})
  app.ports.resizeMap_.subscribe(function () {})
}

module.exports = { init }
