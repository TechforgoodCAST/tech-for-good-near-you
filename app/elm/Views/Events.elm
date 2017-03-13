module Views.Events exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Dates exposing (..)


events : Model -> Html Msg
events model =
    div []
        [ div [ id "myMap", class "w-100 vh-50" ] []
        , div [] (List.map eventView (filterByDate model model.events))
        ]


eventView : Event -> Html Msg
eventView event =
    div [ class "ma2 green" ] [ text event.name, text (toString event.time) ]
