module Data.Location.Postcode exposing (..)

import Model exposing (..)
import Http
import Regex exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


validatePostcode : String -> Postcode
validatePostcode postcode =
    if Regex.contains postcodeRegex postcode then
        Valid postcode
    else
        Invalid postcode


postcodeRegex : Regex
postcodeRegex =
    regex "^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))$"


getLatLngFromPostcode : Model -> Cmd Msg
getLatLngFromPostcode model =
    case model.postcode of
        NotEntered ->
            Cmd.none

        Invalid _ ->
            Cmd.none

        Valid postcode ->
            postcodeRequest postcode


postcodeRequest : String -> Cmd Msg
postcodeRequest postcode =
    Http.get ("http://api.postcodes.io/postcodes/" ++ postcode) (at [ "result" ] postcodeDecoder)
        |> Http.send PostcodeToLatLng


postcodeDecoder : Decoder Coords
postcodeDecoder =
    decode Coords
        |> required "latitude" float
        |> required "longitude" float
