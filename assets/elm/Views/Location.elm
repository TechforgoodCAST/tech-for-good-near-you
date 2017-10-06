module Views.Location exposing (..)

import Helpers.Html exposing (responsiveImg)
import Helpers.HtmlEvents exposing (onEnter)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import RemoteData exposing (RemoteData(..), isLoading)
import Views.Distance exposing (locationMsg)


location : Model -> Html Msg
location model =
    div
        [ class "tc w-100 mt5-ns fade-in" ]
        [ h2 [ class "green mt0 mt4-ns ph3" ] [ text "Find Tech for Good Events near you" ]
        , handleUserLocationError model
        , handleLocationFetch model
        ]


handleUserLocationError : Model -> Html Msg
handleUserLocationError model =
    case model.userGeolocation of
        Failure _ ->
            div [ class "gold mv5" ]
                [ p [] [ text "Could not get your location" ]
                , p [] [ text "Try entering your postcode" ]
                ]

        _ ->
            locationCrosshair model


locationCrosshair : Model -> Html Msg
locationCrosshair model =
    div []
        [ p [ class "green f6 mt5" ] [ text "Get my location" ]
        , div [ class "w3 center pointer spin", onClick GetGeolocation ] [ responsiveImg "/images/crosshair.svg" ]
        , p [ class "green mv4 mv5-ns", classList [ ( "dn", isLoading model.userGeolocation ) ] ] [ text "-- OR --" ]
        ]


centerCrosshairWhite : Model -> Html Msg
centerCrosshairWhite model =
    div [ onClick <| locationMsg model.userGeolocation ] [ responsiveImg "/images/crosshair-white.svg" ]


handleLocationFetch : Model -> Html Msg
handleLocationFetch model =
    case model.userGeolocation of
        Loading ->
            fetchingLocation

        _ ->
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
            p [ onClick GoToDates, class "gold mt4 tracked pointer tracked fade-in" ] [ text "NEXT" ]

        _ ->
            span [] []


viewPostcode : Postcode -> List (Attribute Msg)
viewPostcode x =
    case x of
        NotEntered ->
            [ placeholder "W1T4JE", class "green tc bn outline-0 f5 fw4" ]

        Valid postcode ->
            [ class "green tc bn outline-0 f5 fw4", value (String.toUpper postcode), onEnter GoToDates ]

        Invalid postcode ->
            [ class "red tc bn outline-0 f5 fw4", value (String.toUpper postcode) ]
