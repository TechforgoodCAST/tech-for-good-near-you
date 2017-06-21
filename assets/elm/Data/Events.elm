module Data.Events exposing (..)

import Data.Dates exposing (filterByDate)
import Data.Location.Radius exposing (filterByDistance, latLngToMiles)
import Model exposing (..)


handleSearchResults : Model -> Model
handleSearchResults model =
    { model
        | view = Results
        , fetchingEvents = True
        , mapVisible = True
    }


calculateEventDistance : Coords -> Event -> Event
calculateEventDistance c1 event =
    { event | distance = latLngToMiles c1 (eventLatLng event) }


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


eventLatLng : Event -> Coords
eventLatLng event =
    Coords (eventLat event) (eventLng event)


eventLat : Event -> Float
eventLat event =
    if isPrivateEvent event then
        event.groupLat |> fallbackLat
    else
        event.lat |> fallbackLng


eventLng : Event -> Float
eventLng event =
    if isPrivateEvent event then
        event.groupLng |> fallbackLng
    else
        event.lng |> fallbackLat


isPrivateEvent : Event -> Bool
isPrivateEvent event =
    event.lat == Nothing || event.lng == Nothing


fallbackLat : Maybe Float -> Float
fallbackLat =
    Maybe.withDefault 51


fallbackLng : Maybe Float -> Float
fallbackLng =
    Maybe.withDefault 0
