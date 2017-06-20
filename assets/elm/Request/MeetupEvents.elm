module Request.MeetupEvents exposing (..)

import Data.Events exposing (addDistanceToEvents)
import Date exposing (..)
import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)


handleReceiveMeetupEvents : List Event -> Model -> Model
handleReceiveMeetupEvents events model =
    { model | events = addDistanceToEvents model events }


getMeetupEvents : Cmd Msg
getMeetupEvents =
    Http.get "api/events" (list decodeEvent)
        |> Http.send ReceiveMeetupEvents


decodeEvent : Decoder Event
decodeEvent =
    decode Event
        |> required "name" string
        |> required "event_url" string
        |> required "time" floatToDate
        |> optionalAt [ "venue", "address_1" ] string ""
        |> optionalAt [ "venue", "name" ] string ""
        |> optionalAt [ "venue", "lat" ] float 51
        |> optionalAt [ "venue", "lon" ] float 0
        |> required "yes_rsvp_count" int
        |> requiredAt [ "group", "name" ] string
        |> hardcoded 0


floatToDate : Decoder Date
floatToDate =
    float |> Json.map fromTime
