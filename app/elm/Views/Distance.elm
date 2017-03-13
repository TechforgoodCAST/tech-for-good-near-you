module Views.Distance exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


distanceOptions : Model -> Html Msg
distanceOptions model =
    div []
        [ div [ class "pa2", onClick (SetSearchRadius 5) ] [ text "Within 5 miles" ]
        , div [ class "pa2", onClick (SetSearchRadius 10) ] [ text "Within 10 miles" ]
        , div [ class "pa2", onClick (SetSearchRadius 300) ] [ text "+10 miles" ]
        ]
