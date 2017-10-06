module Views.Distance exposing (..)

import Helpers.Html exposing (responsiveImg)
import Helpers.Style exposing (showAtResults)
import Html exposing (..)
import Html.Attributes as Atr exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import RemoteData exposing (..)


distanceOptions : Model -> Html Msg
distanceOptions model =
    div [ class "mt4 white pr3 t-5 all ease", classList [ showAtResults model ] ]
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


locationMsg : GeolocationData -> Msg
locationMsg location =
    case location of
        Success a ->
            CenterMapOnUser

        _ ->
            GetGeolocation


centerMap : Model -> Html Msg
centerMap model =
    div [ class crosshairClasses ]
        [ div [ class "center", onClick <| locationMsg model.userGeolocation ] [ responsiveImg "/images/crosshair-white.svg" ] ]


crosshairClasses : String
crosshairClasses =
    "w3 h3 pa2 center t-5 all ease pointer"
