module Data.Location.Postcode exposing (..)

import Types exposing (..)
import Regex exposing (..)


handleUpdatePostcode : String -> Model -> Model
handleUpdatePostcode postcode model =
    { model
        | postcode =
            postcode
                |> stripSpaces
                |> validatePostcode
    }


validatePostcode : String -> Postcode
validatePostcode postcode =
    if Regex.contains postcodeRegex postcode then
        Valid postcode
    else
        Invalid postcode


stripSpaces : String -> String
stripSpaces =
    String.filter ((/=) ' ')


postcodeRegex : Regex
postcodeRegex =
    regex "^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))$"
