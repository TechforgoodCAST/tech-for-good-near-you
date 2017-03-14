module Views.Distance exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


distances : List ( String, Int )
distances =
    [ ( "Within 5 miles", 5 )
    , ( "Within 10 miles", 10 )
    , ( "+10 miles", 300 )
    ]


distanceOptions : Model -> Html Msg
distanceOptions model =
    div []
        (List.map distanceOption distances)


distanceOption : ( String, Int ) -> Html Msg
distanceOption ( distanceLabel, distance ) =
    div [ class "pa2 pointer", onClick (SetSearchRadius distance) ] [ text distanceLabel ]
