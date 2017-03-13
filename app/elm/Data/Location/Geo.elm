module Data.Location.Geo exposing (..)

import Model exposing (..)
import Task
import Geolocation
import Data.Ports exposing (..)


getGeolocation : Cmd Msg
getGeolocation =
    Task.attempt Location Geolocation.now


getCoords : Geolocation.Location -> Coords
getCoords location =
    { lat = location.latitude
    , lng = location.longitude
    }


setUserLocation : Maybe Coords -> Cmd Msg
setUserLocation userLocation =
    case userLocation of
        Just location ->
            updateUserLocation location

        Nothing ->
            Cmd.none
