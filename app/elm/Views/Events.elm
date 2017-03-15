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
        [ div [ id "myMap", class "w-100 vh-50" ] []
        , div [ class "vh-50 overflow-y-scroll" ] (List.map eventView (filterEvents model))
        ]


eventView : Event -> Html Msg
eventView event =
    div [ class "green ph4 pv3 mw7 center" ]
        [ h3 [ class "green pointer", onClick <| CenterEvent <| makeMarker event ] [ text event.title ]
        , p [ class "gray" ] [ text <| displayDate event.time ]
        , p [] [ text event.address ]
        , p [] [ text event.venueName ]
        ]
