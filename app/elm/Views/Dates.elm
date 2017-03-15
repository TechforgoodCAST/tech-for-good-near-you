module Views.Dates exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)
import Data.Dates exposing (datesList, dateRangeToString)


type DateButton
    = SideBar
    | Main


dates : Model -> Html Msg
dates model =
    div [ class "mt5-ns tc" ]
        [ h3 [ class "green" ] [ text "See events from:" ]
        , dateMainOptions model
        , showNext model
        ]


showNext : Model -> Html Msg
showNext { selectedDate } =
    if selectedDate /= NoDate then
        p [ class "gold tracked mt4 pointer no-select", onClick NavigateToResults ] [ text "FIND EVENTS" ]
    else
        span [] []


dateMainOptions : Model -> Html Msg
dateMainOptions model =
    div [ class "tc mt4" ] <| List.map (dateButton Main model) datesList


dateSideOptions : Model -> Html Msg
dateSideOptions model =
    div [ class "mt5-ns" ]
        [ p [ class "white" ] [ text "events from:" ]
        , div [] (List.map (dateButton SideBar model) datesList)
        ]


dateButton : DateButton -> Model -> DateRange -> Html Msg
dateButton componentType model date =
    let
        ( bodyClasses, offClasses, onClasses ) =
            case componentType of
                SideBar ->
                    ( "b--white pv1 ph2 ma2 ml0", "bg-white green", "white" )

                Main ->
                    ( "b--green pv2 ph5 ma2", "bg-green white", "green" )
    in
        div
            [ class ("br2 ba pointer no-select " ++ bodyClasses)
            , classList
                [ ( offClasses, date == model.selectedDate )
                , ( onClasses, date /= model.selectedDate )
                ]
            , onClick (SetDate date)
            ]
            [ span [ class "f6 fw4" ] [ text (dateRangeToString date) ] ]
