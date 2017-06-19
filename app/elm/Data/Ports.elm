port module Data.Ports
    exposing
        ( initMap
        , updateMarkers
        , updateUserLocation
        , centerMapOnUser
        , centerEvent
        , resizeMap
        )

import Model exposing (..)


port initMap : Marker -> Cmd msg


port updateMarkers : List Marker -> Cmd msg


port updateUserLocation : Coords -> Cmd msg


centerMapOnUser : Cmd Msg
centerMapOnUser =
    centerMapOnUser_ ()


port centerMapOnUser_ : () -> Cmd msg


port centerEvent : Marker -> Cmd msg


resizeMap : Cmd msg
resizeMap =
    resizeMap_ ()


port resizeMap_ : () -> Cmd msg
