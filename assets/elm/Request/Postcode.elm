module Request.Postcode exposing (..)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Types exposing (..)
import RemoteData exposing (RemoteData(..), WebData)


handleRecievePostcodeLatLng : WebData Coords -> Model -> Model
handleRecievePostcodeLatLng webData model =
    case webData of
        Success coords ->
            { model | userLocation = Success coords }

        _ ->
            { model | userLocation = webData }


handleGetLatLngFromPostcode : Model -> Cmd Msg
handleGetLatLngFromPostcode model =
    case model.postcode of
        NotEntered ->
            Cmd.none

        Invalid _ ->
            Cmd.none

        Valid postcode ->
            postcodeRequest postcode


postcodeRequest : String -> Cmd Msg
postcodeRequest postcode =
    Http.get (postcodeUrl postcode) (at [ "result" ] postcodeDecoder)
        |> RemoteData.sendRequest
        |> Cmd.map RecievePostcodeLatLng


postcodeUrl : String -> String
postcodeUrl postcode =
    "https://api.postcodes.io/postcodes/" ++ (String.filter ((/=) ' ') postcode)


postcodeDecoder : Decoder Coords
postcodeDecoder =
    decode Coords
        |> required "latitude" float
        |> required "longitude" float
