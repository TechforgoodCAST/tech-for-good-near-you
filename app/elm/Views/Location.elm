module Views.Location exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


location : Model -> Html Msg
location model =
    div [ class "center" ]
        [ img [ class "w3 center mt4", src "/img/crosshair.svg", onClick GetLocation ] [] ]
