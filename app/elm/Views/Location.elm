module Views.Location exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


location : Model -> Html Msg
location model =
    div [ class "tc w-100 mt5-ns" ]
        [ h2 [ class "green" ] [ text "Find Tech for Good Events near you" ]
        , p [ class "green f6 mt5" ] [ text "Get my location" ]
        , div [ class "w3 center", onClick GetGeolocation ] [ img [ class "w-100", src "img/crosshair.svg" ] [] ]
        , p [ class "green" ] [ text "-- OR --" ]
        , p [ class "green" ] [ text "Enter your postcode" ]
        , input ([ onInput UpdatePostcode ] ++ viewPostcode model.postcode) []
        ]


viewPostcode : Postcode -> List (Attribute Msg)
viewPostcode x =
    case x of
        Valid postcode ->
            [ placeholder postcode, class "green tc bn outline-0 f5 fw4" ]

        Invalid postcode ->
            [ placeholder postcode, class "red tc bn outline-0 f5 fw4" ]
