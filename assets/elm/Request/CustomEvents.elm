module Request.CustomEvents exposing (..)

import Data.Events exposing (addDistanceToEvents)
import Date exposing (..)
import Date.Extra exposing (compare)
import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)


handleReceiveCustomEvents : List Event -> Model -> Model
handleReceiveCustomEvents events model =
    let
        eventsWithDistance =
            addDistanceToEvents model events

        allEvents =
            (eventsWithDistance ++ model.events)
                |> sortEventsByDate
    in
        { model | events = allEvents }


getCustomEvents : Cmd Msg
getCustomEvents =
    Http.get "api/custom-events" (field "data" (list decodeCustomEvent))
        |> Http.send ReceiveCustomEvents


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


sortEventsByDate : List Event -> List Event
sortEventsByDate =
    List.sortWith (\e1 e2 -> Date.Extra.compare e1.time e2.time)
