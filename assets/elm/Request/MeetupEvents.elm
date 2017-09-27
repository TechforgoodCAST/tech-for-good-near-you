module Request.MeetupEvents exposing (..)

import Date exposing (..)
import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)
import RemoteData exposing (WebData)


handleReceiveMeetupEvents : WebData (List Event) -> Model -> Model
handleReceiveMeetupEvents meetupEvents model =
    { model | meetupEvents = meetupEvents }


getMeetupEvents : Cmd Msg
getMeetupEvents =
    Http.get "api/meetup-events" (list decodeEvent)
        |> RemoteData.sendRequest
        |> Cmd.map ReceiveMeetupEvents


decodeEvent : Decoder Event
decodeEvent =
    decode Event
        |> required "name" string
        |> required "event_url" string
        |> required "time" floatToDate
        |> optionalAt [ "venue", "address_1" ] string ""
        |> optionalAt [ "venue", "name" ] string ""
        |> optionalAt [ "venue", "lat" ] (maybe float) Nothing
        |> optionalAt [ "venue", "lon" ] (maybe float) Nothing
        |> optionalAt [ "group", "group_lat" ] (maybe float) Nothing
        |> optionalAt [ "group", "group_lon" ] (maybe float) Nothing
        |> required "yes_rsvp_count" int
        |> requiredAt [ "group", "urlname" ] urlToGroupTitle
        |> hardcoded 0


floatToDate : Decoder Date
floatToDate =
    float |> Json.map fromTime


urlToGroupTitle : Decoder String
urlToGroupTitle =
    string |> Json.map (String.split "-" >> String.join " ")
