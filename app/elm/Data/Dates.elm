module Data.Dates exposing (..)

import Model exposing (..)
import Date.Extra exposing (..)
import Date exposing (..)
import Task
import Time exposing (..)
import Data.Ports exposing (..)
import Data.Events exposing (..)


datesList : List String
datesList =
    [ "Today"
    , "This week"
    , "This month"
    ]


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform CurrentDate Time.now


filterByDate : Model -> Maybe (List Event) -> Maybe (List Event)
filterByDate { selectedDate, currentDate } =
    case selectedDate of
        Just "Today" ->
            Maybe.map (List.filter (isEventBefore Day currentDate))

        Just "This week" ->
            Maybe.map (List.filter (isEventBefore Week currentDate))

        Just "This month" ->
            Maybe.map (List.filter (isEventBefore Month currentDate))

        _ ->
            Maybe.map (List.filter (always True))


isEventBefore : Interval -> Maybe Date -> Event -> Bool
isEventBefore interval currentDate event =
    Just (event.time)
        |> Maybe.map3 isBetween currentDate (Maybe.map (Date.Extra.ceiling interval) currentDate)
        |> Maybe.withDefault False


toggleSelectedDate : Model -> String -> ( Model, Cmd Msg )
toggleSelectedDate model date =
    let
        noDateSelected =
            { model | selectedDate = Nothing }

        newDateSelected =
            { model | selectedDate = Just date }
    in
        if model.selectedDate == Just date then
            noDateSelected ! [ Maybe.withDefault Cmd.none (Maybe.map updateMarkers (Maybe.map eventMarkers (filterByDate noDateSelected noDateSelected.events))) ]
        else
            newDateSelected ! [ Maybe.withDefault Cmd.none (Maybe.map updateMarkers (Maybe.map eventMarkers (filterByDate newDateSelected newDateSelected.events))) ]
