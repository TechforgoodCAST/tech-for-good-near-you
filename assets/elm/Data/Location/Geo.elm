module Data.Location.Geo exposing (..)

import Data.Ports exposing (updateUserLocation)
import Geolocation exposing (Location, Options)
import Model exposing (..)
import RemoteData exposing (RemoteData(..))


handleGeolocation : GeolocationData -> Model -> Model
handleGeolocation locationData model =
    case locationData of
        Success location ->
            { model
                | userGeolocation = locationData
                , selectedUserLocation = Just <| getCoords location
            }

        _ ->
            { model | userGeolocation = locationData }


getGeolocation : Cmd Msg
getGeolocation =
    Geolocation.nowWith geoOptions
        |> RemoteData.asCmd
        |> Cmd.map ReceiveGeolocation


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
