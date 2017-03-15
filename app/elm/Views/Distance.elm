module Views.Distance exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes as Atr exposing (..)
import Html.Events exposing (..)


distanceOptions : Model -> Html Msg
distanceOptions model =
    div [ class "mt5 white pr3" ]
        [ p [] [ text "events within:" ]
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


centerMap : Html Msg
centerMap =
    div []
        [ p [ class "white" ] [ text "center map" ]
        , div [ class "w3 center pointer", onClick CenterMapUserLocation ] [ img [ class "w-100", src "img/crosshair-white.svg" ] [] ]
        ]