module Views.Events exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Dates exposing (..)
import Data.Events exposing (..)


events : Model -> Html Msg
events model =
    div [ class "w-100" ]
        [ div [ id "myMap", class "w-100 vh-50" ] []
        , div [ class "" ] (List.map eventView (filterEvents model))
        ]


eventView : Event -> Html Msg
eventView event =
    div [ class "green ph4 pv3 mw7 center" ]
        [ a [ href event.url, class "green no-underline", target "_blank" ] [ h3 [] [ text event.title ] ]
        , p [ class "gray" ] [ (displayDate event.time) |> text ]
        , p [] [ text event.address ]
        , p [] [ text event.venueName ]
        ]
