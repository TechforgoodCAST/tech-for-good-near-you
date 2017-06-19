module Data.Events exposing (..)

import Data.Dates exposing (filterByDate)
import Data.Location.Radius exposing (..)
import Model exposing (..)


calculateEventDistance : Coords -> Event -> Event
calculateEventDistance c1 event =
    { event | distance = latLngToMiles c1 (Coords event.lat event.lng) }


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
