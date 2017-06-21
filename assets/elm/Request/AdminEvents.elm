module Request.AdminEvents exposing (..)

import Data.Events exposing (addDistanceToEvents)
import Date exposing (..)
import Date.Extra exposing (compare)
import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)


handleReceiveAdminEvents : List Event -> Model -> Model
handleReceiveAdminEvents events model =
    let
        eventsWithDistance =
            addDistanceToEvents model events

        allEvents =
            (eventsWithDistance ++ model.events)
                |> sortEventsByDate
    in
        { model
            | events = allEvents
            , fetchingEvents = False
        }


getAdminEvents : Cmd Msg
getAdminEvents =
    Http.get "api/admin-events" (field "data" (list decodeInternalEvent))
        |> Http.send ReceiveAdminEvents


decodeInternalEvent : Decoder Event
decodeInternalEvent =
    decode Event
        |> required "name" string
        |> required "url" string
        |> required "time" stringToDate
        |> optional "address" string ""
        |> optional "venue_name" string ""
        |> optional "latitude" float 51
        |> optional "longitude" float 0
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
