module Request.CustomEvents exposing (..)

import Data.Events exposing (addDistanceToEvents, sortEventsByDate)
import Date exposing (..)
import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)
import RemoteData exposing (WebData)


handleReceiveCustomEvents : WebData (List Event) -> Model -> Model
handleReceiveCustomEvents customEvents model =
    { model | customEvents = addDistanceToEvents model customEvents }


getCustomEvents : Cmd Msg
getCustomEvents =
    Http.get "api/custom-events" (field "data" (list decodeCustomEvent))
        |> RemoteData.sendRequest
        |> Cmd.map ReceiveCustomEvents


decodeCustomEvent : Decoder Event
decodeCustomEvent =
    decode Event
        |> required "name" string
        |> required "url" string
        |> required "time" stringToDate
        |> optional "address" string ""
        |> optional "venue_name" string ""
        |> optional "latitude" (maybe float) Nothing
        |> optional "longitude" (maybe float) Nothing
        |> optional "group_lat" (maybe float) Nothing
        |> optional "goup_lng" (maybe float) Nothing
        |> optional "yes_rsvp_count" int 0
        |> optional "group_name" string ""
        |> hardcoded 0


stringToDate : Decoder Date
stringToDate =
    string
        |> Json.map Date.fromString
        |> Json.map (Result.withDefault <| fromTime 0)
