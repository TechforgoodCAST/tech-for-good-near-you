let _map
let infoWindow
let mapDiv
let visibleMarkers = []

function initMap (center) {
  var mapOptions = {
    zoom: 10,
    center: {
      lat: center.lat,
      lng: center.lng
    }
  }

  mapDiv = document.getElementById('myMap')
  _map = new google.maps.Map(mapDiv, mapOptions)
  infoWindow = new google.maps.InfoWindow()
}

function makeMarker (options) {
  var _options = {
    map: _map,
    position: {
      lat: options.lat,
      lng: options.lng
    }
  }

  return {
    url: options.url,
    description: options.description,
    instance: new google.maps.Marker(_options)
  }
}

function clearVisibleMarkers () {
  visibleMarkers.map(m => m.instance.setMap(null))
  visibleMarkers = []
}

function makeDescription (_marker) {
  return `
    <div>
      <a class="no-underline green" href="${_marker.url}" target="_blank">
        <p>${_marker.description}</p>
      </a>
    </div>
  `
}

function fitBounds (_markers) {
  var bounds = new google.maps.LatLngBounds()
  _markers.forEach(m => bounds.extend(m.instance.getPosition()))
  _map.fitBounds(bounds)
}

function addMarkerListener (_marker) {
  google.maps.event.addListener(_marker.instance, 'click', function () {
    infoWindow.setContent(makeDescription(_marker))
    infoWindow.open(_map, this)
  })
}

function normalizeZoom (n) {
  if (_map.getZoom() > n) {
    _map.setZoom(n)
  }
}

function updateMarkers (newMarkers) {
  clearVisibleMarkers()
  newMarkers.forEach(m => visibleMarkers.push(makeMarker(m)))
  visibleMarkers.forEach(m => addMarkerListener(m))

  if (visibleMarkers.length > 0) {
    fitBounds(visibleMarkers)
    normalizeZoom(13)
  }
}

function updateUserLocation (coords) {
  var _options = {
    map: _map,
    icon: 'https://cloud.githubusercontent.com/assets/14013616/23849995/8989fe0a-07d5-11e7-9e81-c3786679d312.png',
    position: {
      lat: coords.lat,
      lng: coords.lng
    }
  }

  return { instance: new google.maps.Marker(_options) }
}
