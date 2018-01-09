module Views.Location exposing (..)

import Data.Location.Postcode exposing (validPostcode)
import Helpers.Html exposing (emptyProperty, onEnter, responsiveImg)
import Helpers.Style exposing (classes, px)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import RemoteData exposing (WebData, RemoteData(..))
import Types exposing (..)


eventsNearPostcode : Model -> Html Msg
eventsNearPostcode model =
    div [ class "white t-3 all ease mt4" ]
        [ p [] [ text "events near:" ]
        , input
            [ style [ ( "width", px 100 ) ]
            , class "placeholder-white bg-green ba b--white br2 outline-0 f6 fw4 tl pv1 ph2 white"
            , onInput UpdatePostcode
            , placeholder "postcode"
            , fetchOnEnter model.postcode
            , extractPostcode model.postcode
            ]
            []
        , search model
        ]


search : Model -> Html Msg
search model =
    div [ class "mt2 flex justify-between" ]
        [ fetchEventsForPostcode model.postcode
        , clearUserLocation model.userLocation
        ]


fetchEventsForPostcode : Postcode -> Html Msg
fetchEventsForPostcode postcode =
    if validPostcode postcode then
        div
            [ onClick FetchEventsForPostcode
            , class "pointer fade-in o-0"
            ]
            [ text "search" ]
    else
        span [ class "w1" ] []


clearUserLocation : WebData Coords -> Html Msg
clearUserLocation userLocation =
    case userLocation of
        NotAsked ->
            span [ class "w1" ] []

        _ ->
            div
                [ onClick ClearUserLocation
                , class "pointer mr1 fade-in o-0"
                ]
                [ text "clear" ]


fetchOnEnter : Postcode -> Attribute Msg
fetchOnEnter postcode =
    if validPostcode postcode then
        onEnter FetchEventsForPostcode
    else
        emptyProperty


extractPostcode : Postcode -> Attribute Msg
extractPostcode x =
    case x of
        NotEntered ->
            value ""

        Valid postcode ->
            value <| String.toUpper postcode

        Invalid postcode ->
            value <| String.toUpper postcode
