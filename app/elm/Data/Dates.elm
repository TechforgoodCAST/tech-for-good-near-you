module Data.Dates exposing (..)

import Model exposing (..)
import Date.Extra exposing (..)
import Date exposing (..)
import Task
import Time


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
filterByDate model =
    List.filter (isEventThisWeek model)


isEventThisWeek : Model -> Event -> Bool
isEventThisWeek model event =
    Just (fromTime event.time)
        |> Maybe.map3 isBetween (Maybe.map fromTime model.currentDate) (Just (Date.Extra.ceiling Week (fromTime event.time)))
        |> Maybe.withDefault False
