port module Data.Maps exposing (..)

import Model exposing (..)


port initMap : Marker -> Cmd msg


port updateMarkers : List Marker -> Cmd msg


eventMarkers : List Event -> List Marker
eventMarkers events =
    events
        |> List.map (\{ lat, lng, description, url } -> { url = url, lat = lat, lng = lng, description = description })
