module Views.Location exposing (..)

import Helpers.Html exposing (responsiveImg)
import Helpers.Style exposing (px)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import RemoteData exposing (RemoteData(..), isLoading)
import Types exposing (..)


getMyLocation : Model -> Html Msg
getMyLocation model =
    div [ class "white t-3 all ease mt4" ]
        [ p [] [ text <| locationText model.userGeolocation ]
        , div
            [ class "spin center"
            , style [ ( "height", px 50 ), ( "width", px 50 ) ]
            ]
            [ geolocationCrosshairWhite ]
        ]


locationText : GeolocationData -> String
locationText userGeolocation =
    case userGeolocation of
        Loading ->
            "finding you ..."

        Failure _ ->
            "couldn't get your location"

        _ ->
            "get my location"


centerCrosshairWhite : Html Msg
centerCrosshairWhite =
    div [ onClick CenterMapOnUser ] [ responsiveImg "/images/crosshair-white.svg" ]


geolocationCrosshairWhite : Html Msg
geolocationCrosshairWhite =
    div [ onClick GetGeolocation ] [ responsiveImg "/images/crosshair-white.svg" ]


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
        ]


viewPostcode : Postcode -> List (Attribute Msg)
viewPostcode x =
    case x of
        NotEntered ->
            [ placeholder "W1T4JE", class "green tc bn outline-0 f5 fw4" ]

        Valid postcode ->
            [ class "green tc bn outline-0 f5 fw4", value <| String.toUpper postcode ]

        Invalid postcode ->
            [ class "red tc bn outline-0 f5 fw4", value <| String.toUpper postcode ]
