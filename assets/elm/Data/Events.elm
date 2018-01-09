module Data.Events exposing (..)

import Config
import Data.Dates exposing (filterByDate)
import Data.Location.Radius exposing (..)
import Date.Extra
import RemoteData exposing (RemoteData(..), WebData, isFailure, isLoading)
import Types exposing (..)


handleFetchEvents : Model -> Model
handleFetchEvents model =
    { model
        | meetupEvents = Loading
        , customEvents = Loading
    }


addDistanceToEvents : Coords -> Model -> WebData (List Event) -> WebData (List Event)
addDistanceToEvents fallbackLocation model events =
    let
        location =
            RemoteData.withDefault fallbackLocation model.userLocation
    in
        RemoteData.map (List.map <| calculateEventDistance location) events


stillLoading : Model -> Bool
stillLoading model =
    isLoading model.meetupEvents || isLoading model.customEvents


bothEventRequestsFailed : Model -> Bool
bothEventRequestsFailed model =
    isFailure model.meetupEvents && isFailure model.customEvents


someEventsRetrieved : Model -> Bool
someEventsRetrieved model =
    nonEmptyEvents model.meetupEvents || nonEmptyEvents model.customEvents


nonEmptyEvents : WebData (List Event) -> Bool
nonEmptyEvents events =
    events
        |> RemoteData.map (\evts -> List.length evts > 0)
        |> RemoteData.toMaybe
        |> Maybe.withDefault False


filterEvents : Model -> WebData (List Event)
filterEvents model =
    model
        |> allEvents
        |> RemoteData.map (filterByDate model >> filterByDistance Config.searchRadius)


numberVisibleEvents : Model -> Int
numberVisibleEvents model =
    model
        |> filterEvents
        |> RemoteData.map List.length
        |> RemoteData.withDefault 0


allEvents : Model -> WebData (List Event)
allEvents model =
    RemoteData.append model.meetupEvents model.customEvents
        |> RemoteData.map (\( a, b ) -> a ++ b)
        |> RemoteData.map sortEventsByDate


sortEventsByDate : List Event -> List Event
sortEventsByDate =
    List.sortWith (\e1 e2 -> Date.Extra.compare e1.time e2.time)


calculateEventDistance : Coords -> Event -> Event
calculateEventDistance c1 event =
    { event | distance = latLngToMiles c1 (eventLatLng event) }


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
