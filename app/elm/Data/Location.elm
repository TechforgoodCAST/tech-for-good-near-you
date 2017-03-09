module Data.Location exposing (..)

import Model exposing (..)
import Task
import Geolocation
import Regex exposing (..)


getGeolocation : Cmd Msg
getGeolocation =
    Task.attempt Location Geolocation.now


getCoords : Geolocation.Location -> Coords
getCoords location =
    { lat = location.latitude
    , lng = location.longitude
    }


validatePostcode : String -> Postcode
validatePostcode postcode =
    if Regex.contains postcodeRegex postcode then
        Valid postcode
    else
        Invalid postcode


postcodeRegex : Regex
postcodeRegex =
    regex "^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))$"
