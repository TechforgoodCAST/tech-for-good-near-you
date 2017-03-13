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
    List.map dateRangeToString
        [ Today
        , ThisWeek
        , ThisMonth
        ]


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform CurrentDate Time.now


filterByDate : Model -> List Event -> List Event
filterByDate { selectedDate, currentDate } =
    case selectedDate of
        Today ->
            List.filter (isEventBefore Day currentDate)

        ThisWeek ->
            List.filter (isEventBefore Week currentDate)

        ThisMonth ->
            List.filter (isEventBefore Month currentDate)

        NoDate ->
            List.filter (always True)


isEventBefore : Interval -> Maybe Date -> Event -> Bool
isEventBefore interval currentDate event =
    Just (event.time)
        |> Maybe.map3 isBetween currentDate (Maybe.map (Date.Extra.ceiling interval) currentDate)
        |> Maybe.withDefault False


updateFilteredMarkers : Model -> Cmd Msg
updateFilteredMarkers model =
    model.events
        |> filterByDate model
        |> extractMarkers
        |> updateMarkers


toggleSelectedDate : Model -> DateRange -> ( Model, Cmd Msg )
toggleSelectedDate model date =
    let
        noDateSelected =
            { model | selectedDate = NoDate }

        newDateSelected =
            { model | selectedDate = date }
    in
        if model.selectedDate == date then
            noDateSelected ! [ updateFilteredMarkers noDateSelected ]
        else
            newDateSelected ! [ updateFilteredMarkers newDateSelected ]


dateRangeToString : DateRange -> String
dateRangeToString date =
    case date of
        Today ->
            "Today"

        ThisWeek ->
            "This week"

        ThisMonth ->
            "This month"

        NoDate ->
            ""
