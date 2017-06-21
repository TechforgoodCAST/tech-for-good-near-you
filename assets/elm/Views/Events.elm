module Views.Events exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Data.Dates exposing (..)
import Data.Events exposing (..)
import Data.Maps exposing (..)
import Views.Dates exposing (dateMainOptions)


events : Model -> Html Msg
events model =
    if List.isEmpty (filterEvents model) && not model.fetchingEvents then
        selectOtherDates model
    else
        let
            mapMargin =
                model.window.height // 2 |> toString
        in
            div [ class "w-50-m", style [ ( "margin-top", mapMargin ++ "px" ) ] ] (List.map event (filterEvents model))


selectOtherDates : Model -> Html Msg
selectOtherDates model =
    div [ class "green tc fade-in", style [ ( "margin-top", "50vh" ) ] ]
        [ p [ class "fade-in f4 mt5-ns mt4" ] [ text <| noEventsInRangeText model ]
        , p [ class "f6" ] [ text "Choose another date" ]
        , div [ class "center mw5" ] [ dateMainOptions model ]
        ]


noEventsInRangeText : Model -> String
noEventsInRangeText model =
    "No events "
        ++ (model.selectedDate
                |> dateRangeToString
                |> String.toLower
           )


event : Event -> Html Msg
event event =
    div [ class "green ph4 pt3 pb4 mw7 center fade-in" ]
        [ h3
            [ class "green pointer mv2"
            , onClick <| CenterEvent (makeMarker event)
            ]
            [ text event.title ]
        , p [ class "ma0 gold f6" ] [ text <| String.toUpper event.groupName ]
        , p []
            [ span [ class "fw4 light-silver mr3" ] [ text "When? " ]
            , span [ class "fw7 gray" ] [ text <| String.toUpper (displayDate event.time) ]
            ]
        , div [ class "flex" ]
            [ p [ class "fw4 light-silver mr3" ] [ text "Where? " ]
            , div []
                [ p [] [ text event.venueName ]
                , p [] [ text event.address ]
                , a [ href event.url, target "_blank" ] [ button [ class "pv2 ph3 bg-gold br2 f6 tracked white bn outline-0 pointer" ] [ text "SEE MORE" ] ]
                ]
            ]
        ]
