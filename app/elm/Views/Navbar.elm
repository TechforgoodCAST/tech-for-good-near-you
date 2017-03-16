module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Views.Dates exposing (..)
import Views.Distance exposing (..)


navbar : Model -> Html Msg
navbar model =
    nav [ class "bg-green fixed-ns w5-ns white dib-ns vh-100-ns left-0 top-0 fade-in w-100 z-5" ]
        [ div [ class "flex justify-between pa3 pb0 pb3-ns" ]
            [ div []
                [ logo
                , p [ class "mt0 ml1" ] [ text "near you" ]
                ]
            , div [ class "pa2 pointer db dn-ns", onClick ToggleNavbar ] [ p [] [ text "click" ] ]
            ]
        , navbarOptions model
        ]


logo : Html Msg
logo =
    div [ class "w3 w4-ns" ] [ img [ class "w-100", src "/img/tech-for-good.png" ] [] ]


navbarOptions : Model -> Html Msg
navbarOptions model =
    div [ classList [ ( "dn", not model.navbarOpen ) ], class " db-ns pa3 pb0 pb3-ns" ]
        [ dateSideOptions model
        , distanceOptions model
        , centerMap model
        ]
