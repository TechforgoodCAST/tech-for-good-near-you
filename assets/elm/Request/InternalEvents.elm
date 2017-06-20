module Request.InternalEvents exposing (..)

import Date exposing (..)
import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)


handleReceiveInternalEvents : List Event -> Model -> Model
handleReceiveInternalEvents events model =
    { model
        | events = events ++ model.events
        , fetchingEvents = False
    }


getInternalEvents : Cmd Msg
getInternalEvents =
    Http.get "api/internal-events" (field "data" (list decodeInternalEvent))
        |> Http.send ReceiveInternalEvents


decodeInternalEvent : Decoder Event
decodeInternalEvent =
    decode Event
        |> required "name" string
        |> required "url" string
        |> required "time" floatToDate
        |> optionalAt [ "venue", "address_1" ] string ""
        |> optionalAt [ "venue", "name" ] string ""
        |> optionalAt [ "venue", "lat" ] float 51
        |> optionalAt [ "venue", "lon" ] float 0
        |> optional "yes_rsvp_count" int 0
        |> optionalAt [ "group", "name" ] string ""
        |> hardcoded 0


floatToDate : Decoder Date
floatToDate =
    string |> Json.map fromString |> Json.map (Result.withDefault <| fromTime 0)


defaultImgUrl : String
defaultImgUrl =
    "https://benrmatthews.com/wp-content/uploads/2015/05/tech-for-good.jpg"
