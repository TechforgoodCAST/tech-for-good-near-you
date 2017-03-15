module Views.Distance exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


distances : List ( Int, String )
distances =
    [ ( 5, "5" )
    , ( 10, "10" )
    , ( 15, "15" )
    , ( 20, "20" )
    , ( 25, "25" )
    , ( 300, "+30" )
    ]


distanceOptions : Model -> Html Msg
distanceOptions model =
    div [ class "mt4" ]
        [ p [ class "white" ] [ text "events within (mi):" ]
        , div [ class "flex justify-around" ] (List.map (distanceOption model) distances)
        ]


distanceOption : Model -> ( Int, String ) -> Html Msg
distanceOption model ( distance, distanceLabel ) =
    div [ onClick (SetSearchRadius distance), class "flex justify-center items-center flex-column w2" ]
        [ div [ class "pointer br-100 bg-white", style [ ( "width", "10px" ), ( "height", "10px" ) ] ] []
        , p [ class "f6", classList [ ( "white", model.searchRadius == distance ), ( "green", model.searchRadius /= distance ) ] ] [ text distanceLabel ]
        ]


centerMap : Html Msg
centerMap =
    div []
        [ p [ class "white" ] [ text "center map" ]
        , div [ class "w3 center pointer spin", onClick CenterMap ] [ img [ class "w-100", src "img/crosshair-white.svg" ] [] ]
        ]
