module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Views.Dates exposing (..)
import Views.Distance exposing (..)


navbar : Model -> Html Msg
navbar model =
    nav [ class "bg-green pa3 fixed white dib w5-ns vh-100 left-0 top-0 fade-in" ]
        [ logo
        , p [ class "mt0 ml1" ] [ text "near you" ]
        , dateSideOptions model
        , distanceOptions model
        , centerMap model
        ]


logo : Html Msg
logo =
    div [ class "w4" ] [ img [ class "w-100", src "/img/tech-for-good.png" ] [] ]
