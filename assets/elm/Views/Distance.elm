module Views.Distance exposing (..)

import Helpers.Html exposing (responsiveImg)
import Helpers.Style exposing (showAtResults)
import Html exposing (..)
import Html.Attributes as Atr exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


centerMap : Model -> Html Msg
centerMap model =
    div [ class crosshairClasses ]
        [ div [ class "center", onClick CenterMapOnUser ] [ responsiveImg "/images/crosshair-white.svg" ] ]


crosshairClasses : String
crosshairClasses =
    "w3 h3 pa2 center t-5 all ease pointer"
