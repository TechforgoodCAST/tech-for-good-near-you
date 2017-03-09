module Views.Location exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


location : Model -> Html Msg
location model =
    div [ class "tc w-100 mt5-ns" ]
        [ h2 [ class "green" ] [ text "Find Tech for Good Events near you" ]
        , p [ class "green f6 mt5" ] [ text "get my location" ]
        , div [ class "w3 center", onClick GetLocation ] [ img [ class "w-100", src "img/crosshair.svg" ] [] ]
        ]
