import { sendScrollDistanceToElm, openElmMobileBottomNav } from './interop.js'

const L = require('leaflet')
require('leaflet.markercluster')
require('leaflet-providers')

let _map
let _markerCluster
let userPosition
let visibleMarkers = []

function initMap ({ marker, mapId }) {
  _map = L.map(mapId).setView([marker.lat, marker.lng], 10)
  L.tileLayer.provider('Stamen.Toner').addTo(_map)
  _markerCluster = L.markerClusterGroup()
  _markerCluster.addTo(_map)
}


function makeMarker (options) {
  return {
    url: options.url,
    title: options.title,
    instance: new L.marker([options.lat, options.lng]).addTo(_markerCluster)
  }
}

function clearVisibleMarkers () {
  _markerCluster.clearLayers()
  visibleMarkers = []
}

function makeDescription (_marker) {
  return `
    <div>
      <a class="no-underline green" href="${_marker.url}" target="_blank">
        <p>${_marker.title}</p>
      </a>
    </div>
  `
}

function _fitBounds (_markers) {
  var bounds = new L.latLngBounds()
  _markers.forEach(m => bounds.extend(m.instance.getLatLng()))
  _map.fitBounds(bounds)
}

function fitBounds () {
  if (visibleMarkers.length) {
    resizeMap()
    _fitBounds(visibleMarkers)
  }
}

function addMarkerListener (elmApp, _marker) {
  _marker.instance.addEventListener('click', function () {
    sendScrollDistanceToElm(elmApp, _marker)
    openElmMobileBottomNav(elmApp)
    _marker.instance.bindPopup(makeDescription(_marker)).openPopup()
  })
}

function normalizeZoom (n) {
  if (_map.getZoom() > n) {
    _map.setZoom(n)
  }
}

function updateMarkers (elmApp) {
  return function (newMarkers) {
    clearVisibleMarkers()
    newMarkers.forEach(m => visibleMarkers.push(makeMarker(m)))
    visibleMarkers.forEach(m => addMarkerListener(elmApp, m))

    if (visibleMarkers.length > 0) {
      _fitBounds(visibleMarkers)
      resizeMap()
      normalizeZoom(13)
    }
  }
}

function updateUserLocation (coords) {
  var _options = {
    icon: new L.Icon({
      iconUrl: 'https://cloud.githubusercontent.com/assets/14013616/23849995/8989fe0a-07d5-11e7-9e81-c3786679d312.png'
    })
  }
  if (userPosition) {
    userPosition.setMap(null)
  }
  userPosition = new L.Marker([coords.lat, coords.lng], _options).addTo(_map)
}

function centerMapOnUser () {
  _map.setView(userPosition.getLatLng(), 13)
}

function centerEvent (event) {
  var selectedMarkerArr = visibleMarkers.filter(function (marker) {
    return marker.title === event.title
  })

  var selectedMarker = selectedMarkerArr.length
    ? selectedMarkerArr[0].instance
    : {}

  _map.setView(event, 16)
  selectedMarker.bindPopup(makeDescription(event)).openPopup()
}

function resizeMap () {
  _map.invalidateSize()
}

module.exports = {
  initMap,
  updateMarkers,
  updateUserLocation,
  centerMapOnUser,
  centerEvent,
  resizeMap,
  fitBounds
}
