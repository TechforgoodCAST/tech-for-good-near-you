module Views.Events exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Data.Dates exposing (..)
import Data.Events exposing (..)
import Data.Maps exposing (..)


events : Model -> Html Msg
events model =
    div [ class "w-100" ]
        [ div [ id "myMap", class "w-100 vh-50-ns vh-25 fade-in bg-light-gray" ] []
        , div [ class "vh-75 vh-50-ns overflow-y-scroll" ] (List.map eventView (filterEvents model))
        ]


eventView : Event -> Html Msg
eventView event =
    div [ class "green ph4 pt3 pb4 mw7 center fade-in" ]
        [ h3 [ class "green pointer", onClick <| CenterEvent <| makeMarker event ] [ text event.title ]
        , p []
            [ span [ class "fw4 light-silver mr3" ] [ text "When? " ]
            , span [ class "fw7 gray" ] [ text <| String.toUpper <| displayDate event.time ]
            ]
        , div [ class "flex" ]
            [ p [ class "fw4 light-silver mr3" ] [ text "Where? " ]
            , div []
                [ p [] [ text event.address ]
                , p [] [ text event.venueName ]
                , a [ href event.url, target "_blank" ] [ button [ class "pv2 ph3 bg-gold br2 f6 tracked white bn outline-0 pointer" ] [ text "SEE MORE" ] ]
                ]
            ]
        ]
