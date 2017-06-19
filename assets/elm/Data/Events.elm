module Data.Events exposing (..)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Data.Location.Radius exposing (..)
import Data.Dates exposing (..)
import Model exposing (..)
import Date exposing (..)


getEvents : Cmd Msg
getEvents =
    Http.get "/events" (list decodeEvent)
        |> Http.send Events


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
    float
        |> andThen (\x -> (succeed (fromTime x)))


calculateEventDistance : Coords -> Event -> Event
calculateEventDistance c1 event =
    { event | distance = latLngToMiles c1 (Coords event.lat event.lng) }


defaultImgUrl : String
defaultImgUrl =
    "https://benrmatthews.com/wp-content/uploads/2015/05/tech-for-good.jpg"


addDistanceToEvents : Model -> List Event -> List Event
addDistanceToEvents model events =
    case model.userLocation of
        Nothing ->
            events

        Just c1 ->
            List.map (calculateEventDistance c1) events


filterEvents : Model -> List Event
filterEvents model =
    model.events
        |> filterByDate model
        |> filterByDistance model
