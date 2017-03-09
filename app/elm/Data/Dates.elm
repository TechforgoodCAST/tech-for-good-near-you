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


filterByDate : Model -> List Event -> List Event
filterByDate { selectedDate, currentDate } =
    case selectedDate of
        "Today" ->
            List.filter (isEventBefore Day currentDate)

        "This week" ->
            List.filter (isEventBefore Week currentDate)

        "This month" ->
            List.filter (isEventBefore Month currentDate)

        _ ->
            List.filter (always True)


isEventBefore : Interval -> Maybe Date -> Event -> Bool
isEventBefore interval currentDate event =
    Just (event.time)
        |> Maybe.map3 isBetween currentDate (Maybe.map (Date.Extra.ceiling interval) currentDate)
        |> Maybe.withDefault False


toggleSelectedDate : Model -> String -> ( Model, Cmd Msg )
toggleSelectedDate model date =
    let
        noDateSelected =
            { model | selectedDate = "" }

        newDateSelected =
            { model | selectedDate = date }
    in
        if model.selectedDate == date then
            noDateSelected ! [ updateMarkers (eventMarkers (filterByDate noDateSelected noDateSelected.events)) ]
        else
            newDateSelected ! [ updateMarkers (eventMarkers (filterByDate newDateSelected newDateSelected.events)) ]
