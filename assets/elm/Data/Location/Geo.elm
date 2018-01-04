module Data.Location.Geo exposing (..)

import Geolocation exposing (Location, Options)
import Types exposing (..)
import RemoteData exposing (RemoteData(..))


handleGeolocation : GeolocationData -> Model -> Model
handleGeolocation locationData model =
    case locationData of
        Success location ->
            { model
                | userGeolocation = locationData
                , selectedLocation = getCoords location
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
