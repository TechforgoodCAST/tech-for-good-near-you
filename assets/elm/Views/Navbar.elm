module Views.Navbar exposing (..)

import Helpers.Style exposing (desktopOnly, mobileOnly, showAtResults)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Views.Dates exposing (..)
import Views.Distance exposing (..)


navbar : Model -> Html Msg
navbar model =
    nav []
        [ desktopNavbar model
        , mobileNavbar model
        ]


desktopNavbar : Model -> Html Msg
desktopNavbar model =
    div [ class desktopOnly ]
        [ div [ class "flex justify-between white pa3 pb3 bg-green fixed h-100 w5 dib left-0 top-0 z-5" ]
            [ div []
                [ div [ class "pointer", onClick Restart ]
                    [ logo
                    , p [ class "mt0 ml1" ] [ text "near you" ]
                    ]
                , navbarOptions model
                , div [ class "absolute center bottom-2 left-0 right-0" ] [ centerMap model ]
                ]
            ]
        ]


mobileNavbar : Model -> Html Msg
mobileNavbar model =
    let
        navHeight =
            (toString model.mobileNavHeight) ++ "px"
    in
        div [ class mobileOnly, style [ ( "margin-bottom", navHeight ) ] ]
            [ div [ class "fixed z-5 bg-green white top-0 left-0 w-100 flex justify-between items-center", style [ ( "height", navHeight ) ] ]
                [ div [ class "ml2 mt2 pointer flex", onClick Restart ] [ logo, p [ class "ml2" ] [ text "near you" ] ]
                , div
                    [ style [ ( "width", "20px" ) ]
                    , class "mr3 pointer"
                    , onClick ToggleNavbar
                    ]
                    [ img [ class "w-100", src "/images/plus.png" ] [] ]
                ]
            , mobileNavOptions model
            ]


mobileNavOptions : Model -> Html Msg
mobileNavOptions model =
    if model.navbarOpen then
        div [ class "w-100 bg-green fixed h-100 z-5 ph3 fade-in a-3" ]
            [ navbarOptions model
            , div [ class "flex mt3", classList [ showAtResults model ] ]
                [ div [ class "dib spin", onClick ToggleNavbar ] [ centerMap model ]
                , p [ class "white ml2" ] [ text "center map on your location" ]
                ]
            ]
    else
        span [] []


logo : Html Msg
logo =
    div [ class "w3 w4-ns" ] [ img [ class "w-100", src "/images/tech-for-good.png" ] [] ]


navbarOptions : Model -> Html Msg
navbarOptions model =
    div [ class "pt1 pb3-ns t-3 all ease bg-green" ]
        [ dateSideOptions model
        , distanceOptions model
        ]
