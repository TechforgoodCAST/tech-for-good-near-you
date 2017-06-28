port module Data.Ports
    exposing
        ( initMap
        , updateMarkers
        , updateUserLocation
        , centerMapOnUser
        , centerEvent
        , fitBounds
        , resizeMap
        , scrollToEvent
        , openBottomNav
        , mapAttached
        )

import Model exposing (..)


port initMap : MapOptions -> Cmd msg


port updateMarkers : List Marker -> Cmd msg


port updateUserLocation : Coords -> Cmd msg


centerMapOnUser : Cmd Msg
centerMapOnUser =
    centerMapOnUser_ ()


port centerMapOnUser_ : () -> Cmd msg


port centerEvent : Marker -> Cmd msg


fitBounds : Cmd msg
fitBounds =
    fitBounds_ ()


port fitBounds_ : () -> Cmd msg


resizeMap : Cmd msg
resizeMap =
    resizeMap_ ()


port resizeMap_ : () -> Cmd msg


port mapAttached : (Bool -> msg) -> Sub msg


port scrollToEvent : (Float -> msg) -> Sub msg


port openBottomNav : (Bool -> msg) -> Sub msg
