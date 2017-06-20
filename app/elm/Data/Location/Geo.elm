module Data.Location.Geo exposing (..)

import Model exposing (..)
import Task
import Geolocation exposing (Location, Options)
import Data.Ports exposing (updateUserLocation)


handleGeolocationError : Model -> Model
handleGeolocationError model =
    { model
        | userLocationError = True
        , fetchingLocation = False
    }


handleGeolocation : Location -> Model -> Model
handleGeolocation location model =
    { model
        | userLocation = Just (getCoords location)
        , userLocationError = False
        , view = MyDates
        , fetchingLocation = False
    }


getGeolocation : Cmd Msg
getGeolocation =
    Geolocation.nowWith geoOptions
        |> Task.attempt ReceiveGeolocation


geoOptions : Options
geoOptions =
    { enableHighAccuracy = False
    , timeout = Just 8000
    , maximumAge = Nothing
    }


getCoords : Location -> Coords
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
