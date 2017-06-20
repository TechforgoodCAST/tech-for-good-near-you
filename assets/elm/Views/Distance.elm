module Views.Distance exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes as Atr exposing (..)
import Html.Events exposing (..)
import Helpers.Style exposing (showAtResults)


distanceOptions : Model -> Html Msg
distanceOptions model =
    div [ class "mt5 white pr3 t-5 all ease", classList [ showAtResults model ] ]
        [ p [] [ text "meetups within:" ]
        , input
            [ type_ "range"
            , Atr.min "5"
            , Atr.max "305"
            , step "10"
            , value <| toString model.searchRadius
            , onInput SetSearchRadius
            ]
            []
        , div [ class "bg-white w-100", style [ ( "margin-top", "-13px" ), ( "height", "2px" ) ] ] []
        , div []
            [ p [ class "dib f6" ] [ text "5mi" ]
            , p [ class "dib fr f6" ] [ text "300mi" ]
            ]
        ]


centerMap : Model -> Html Msg
centerMap model =
    div [ class crosshairClasses, classList [ showAtResults model ] ]
        [ div [ class "center", onClick CenterMapOnUser ] [ img [ class "w-100", src "images/crosshair-white.svg" ] [] ] ]


crosshairClasses : String
crosshairClasses =
    "w3 h3 pa2 center t-5 all ease pointer"
