module Views.Location exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


location : Model -> Html Msg
location model =
    div
        [ class "tc w-100 mt5-ns fade-in" ]
        [ h2 [ class "green mt4" ] [ text "Find Tech for Good Events near you" ]
        , handleUserLocationError model
        , handleLocationFetch model
        ]


handleUserLocationError : Model -> Html Msg
handleUserLocationError model =
    if model.userLocationError then
        div [] [ p [ class "gold mv5" ] [ text "Could not get your location" ] ]
    else
        locationCrosshair model


locationCrosshair : Model -> Html Msg
locationCrosshair model =
    div []
        [ p [ class "green f6 mt5" ] [ text "Get my location" ]
        , div [ class "w3 center pointer spin", onClick GetGeolocation ] [ img [ class "w-100", src "img/crosshair.svg" ] [] ]
        , p [ class "green mv4 mv5-ns", classList [ ( "dn", model.fetchingLocation ) ] ] [ text "-- OR --" ]
        ]


handleLocationFetch : Model -> Html Msg
handleLocationFetch model =
    if model.fetchingLocation then
        fetchingLocation
    else
        enterPostcode model


fetchingLocation : Html Msg
fetchingLocation =
    div [] [ p [ class "green fade-in" ] [ text "finding your location" ] ]


enterPostcode : Model -> Html Msg
enterPostcode model =
    div []
        [ p [ class "green" ] [ text "Enter your postcode" ]
        , input ([ onInput UpdatePostcode ] ++ viewPostcode model.postcode) []
        , showNext model
        ]


showNext : Model -> Html Msg
showNext model =
    case model.postcode of
        Valid _ ->
            p [ onClick GoToDates, class "gold mt4 tracked pointer tracked" ] [ text "NEXT" ]

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
