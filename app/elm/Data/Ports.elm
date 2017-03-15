port module Data.Ports exposing (..)

import Model exposing (..)


port initMap : Marker -> Cmd msg


port updateMarkers : List Marker -> Cmd msg


port updateUserLocation : Coords -> Cmd msg


port centerMapOnUser : () -> Cmd msg


port centerEvent : Marker -> Cmd msg
