module Data.Location exposing (..)

import Model exposing (..)
import Task
import Geolocation


getLocation : Cmd Msg
getLocation =
    Task.attempt Location Geolocation.now


getCoords : Geolocation.Location -> Coords
getCoords location =
    { lat = location.latitude
    , lng = location.longitude
    , accuracy = location.accuracy
    }
