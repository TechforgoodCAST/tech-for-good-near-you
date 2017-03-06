module Data.Request exposing (..)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)


getResults : Cmd Msg
getResults =
    Http.send SearchResults (Http.get "http://localhost:3000/events" (list decodeEvent))


decodeEvent : Decoder SearchResult
decodeEvent =
    decode SearchResult
        |> required "name" string
        |> optional "description" string ""
        |> required "event_url" string
        |> required "time" int
        |> optionalAt [ "venue", "address_1" ] string ""
        |> optionalAt [ "venue", "name" ] string ""
        |> optionalAt [ "venue", "lat" ] float 51
        |> optionalAt [ "venue", "lon" ] float 0
        |> required "yes_rsvp_count" int
        |> requiredAt [ "group", "name" ] string


defaultImgUrl : String
defaultImgUrl =
    "https://benrmatthews.com/wp-content/uploads/2015/05/tech-for-good.jpg"
