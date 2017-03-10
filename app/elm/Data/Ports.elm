port module Data.Ports exposing (..)

import Model exposing (..)


port initMap : Marker -> Cmd msg


port updateMarkers : List Marker -> Cmd msg


port setUserLocation : () -> Cmd msg
