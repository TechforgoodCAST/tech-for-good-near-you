module Views.Events exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Dates exposing (..)
import Data.Location.Radius exposing (..)


events : Model -> Html Msg
events model =
    div [ class "w-100" ]
        [ div [ id "myMap", class "w-100 vh-50" ] []
        , div [] (List.map eventView (filterEvents model))
        ]


eventView : Event -> Html Msg
eventView event =
    div [ class "ma2 green" ] [ text event.name, text (toString event.time), text (toString event.distance) ]


filterEvents : Model -> List Event
filterEvents model =
    model.events
        |> filterByDate model
        |> filterByDistance model
