module Views.Location exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


location : Model -> Html Msg
location model =
    div
        [ class "tc w-100 mt5-ns" ]
        [ h2 [ class "green" ] [ text "Find Tech for Good Events near you" ]
        , p [ class "green f6 mt5" ] [ text "Get my location" ]
        , div [ class "w3 center spin", onClick GetGeolocation ] [ img [ class "w-100", src "img/crosshair.svg" ] [] ]
        , handleLocationFetch model
        ]


handleLocationFetch : Model -> Html Msg
handleLocationFetch model =
    if model.fetchingLocation then
        fetchingLocation
    else
        enterPostcode model


fetchingLocation : Html Msg
fetchingLocation =
    div [] [ p [] [ text "finding your location" ] ]


enterPostcode : Model -> Html Msg
enterPostcode model =
    div []
        [ p [ class "green" ] [ text "-- OR --" ]
        , p [ class "green" ] [ text "Enter your postcode" ]
        , input ([ onInput UpdatePostcode ] ++ viewPostcode model.postcode) []
        , showNext model
        ]


showNext : Model -> Html Msg
showNext model =
    case model.postcode of
        Valid _ ->
            p [ onClick GoToDates, class "green pointer" ] [ text "next" ]

        _ ->
            span [] []


viewPostcode : Postcode -> List (Attribute Msg)
viewPostcode x =
    case x of
        NotEntered ->
            [ placeholder "W1T 4JE", class "green tc bn outline-0 f5 fw4" ]

        Valid postcode ->
            [ class "green tc bn outline-0 f5 fw4", value (String.toUpper postcode) ]

        Invalid postcode ->
            [ class "red tc bn outline-0 f5 fw4", value (String.toUpper postcode) ]
