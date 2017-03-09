module Data.Events exposing (..)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)
import Date exposing (..)


getEvents : Cmd Msg
getEvents =
    Http.send Events (Http.get "http://localhost:3000/events" (list decodeEvent))


decodeEvent : Decoder Event
decodeEvent =
    decode Event
        |> required "name" string
        |> optional "description" string ""
        |> required "event_url" string
        |> required "time" floatToDate
        |> optionalAt [ "venue", "address_1" ] string ""
        |> optionalAt [ "venue", "name" ] string ""
        |> optionalAt [ "venue", "lat" ] float 51
        |> optionalAt [ "venue", "lon" ] float 0
        |> required "yes_rsvp_count" int
        |> requiredAt [ "group", "name" ] string


floatToDate : Decoder Date
floatToDate =
    float
        |> andThen (\x -> (succeed (fromTime x)))


defaultImgUrl : String
defaultImgUrl =
    "https://benrmatthews.com/wp-content/uploads/2015/05/tech-for-good.jpg"


eventMarkers : List Event -> List Marker
eventMarkers events =
    events
        |> List.map (\{ lat, lng, description, url } -> { url = url, lat = lat, lng = lng, description = description })
