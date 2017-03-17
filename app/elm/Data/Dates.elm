module Data.Dates exposing (..)

import Model exposing (..)
import Date.Extra exposing (..)
import Date exposing (..)
import Task
import Time exposing (..)


datesList : List DateRange
datesList =
    [ Today
    , ThisWeek
    , ThisMonth
    , All
    ]


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform CurrentDate Time.now


filterByDate : Model -> List Event -> List Event
filterByDate { selectedDate, currentDate } =
    case selectedDate of
        Today ->
            List.filter <| isEventBefore Day currentDate

        ThisWeek ->
            List.filter <| isEventBefore Week currentDate

        ThisMonth ->
            List.filter <| isEventBefore Month currentDate

        All ->
            List.filter <| always True

        NoDate ->
            List.filter <| always True


isEventBefore : Interval -> Maybe Date -> Event -> Bool
isEventBefore interval currentDate event =
    Just (event.time)
        |> Maybe.map3 isBetween currentDate (Maybe.map (Date.Extra.ceiling interval) currentDate)
        |> Maybe.withDefault False


dateRangeToString : DateRange -> String
dateRangeToString date =
    case date of
        Today ->
            "Today"

        ThisWeek ->
            "This week"

        ThisMonth ->
            "This month"

        All ->
            "All meetups"

        NoDate ->
            ""


toggleSelectedDate : Model -> DateRange -> Model
toggleSelectedDate model date =
    if model.selectedDate == date then
        { model | selectedDate = NoDate }
    else
        { model | selectedDate = date }


displayDate : Date -> String
displayDate date =
    Date.Extra.toFormattedString "MMMM d, h:mm a" date
