module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Views.Dates exposing (..)
import Views.Distance exposing (..)
import Helpers.Style exposing (toggleNavClasses)


navbar : Model -> Html Msg
navbar model =
    nav [ class "fixed-ns bg-green-ns w5-ns white dib-ns vh-100-ns left-0 top-0 fade-in w-100 z-5" ]
        [ div [ class "flex justify-between pa3 pb0 pb3-ns bg-green relative z-5" ]
            [ div [ class "pointer", onClick <| SetView MyLocation ]
                [ logo
                , p [ class "mt0 ml1" ] [ text "near you" ]
                ]
            , div [ onClick ToggleNavbar, class "db dn-ns" ]
                [ div [ class "pa2 pb0 pointer", style [ ( "width", "2.5rem" ) ] ] [ img [ class "w-100", src "/img/plus.png" ] [] ]
                , p [ class "white mt2 f6" ] [ text "options" ]
                ]
            ]
        , navbarOptions model
        , centerMap model
        ]


logo : Html Msg
logo =
    div [ class "w3 w4-ns" ] [ img [ class "w-100", src "/img/tech-for-good.png" ] [] ]


navbarOptions : Model -> Html Msg
navbarOptions model =
    div [ classList <| toggleNavClasses model, class "db-ns pa3 pb0 pb3-ns t-5 all ease bg-green" ]
        [ dateSideOptions model
        , distanceOptions model
        ]
