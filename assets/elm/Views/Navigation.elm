module Views.Navigation exposing (..)

import Helpers.Html exposing (responsiveImg)
import Helpers.Style exposing (classes, desktopOnly, mobileFullHeight, mobileOnly, px, showAtResults)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Views.Dates exposing (..)
import Views.Distance exposing (..)


topNav : Model -> Html Msg
topNav model =
    nav []
        [ desktopNavbar model
        , mobileTopBar model
        ]


bottomNav : Model -> Html Msg
bottomNav model =
    nav [ class mobileOnly ]
        [ mobileBottomNav model
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
                , div [ class "absolute center bottom-2 left-0 right-0 t-3 all ease", classList [ showAtResults model ] ]
                    [ div [ class "spin" ] [ centerMap model ]
                    ]
                ]
            ]
        ]


mobileTopBar : Model -> Html Msg
mobileTopBar model =
    div [ class mobileOnly, style [ ( "margin-bottom", px model.mobileNav.topHeight ) ] ]
        [ div [ class "fixed z-5 bg-green white top-0 left-0 w-100 flex justify-between items-center", style [ ( "height", px model.mobileNav.topHeight ) ] ]
            [ div [ class "ml2 mt2 pointer flex", onClick Restart ] [ logo, p [ class "ml2" ] [ text "near you" ] ]
            , div
                [ style [ ( "width", "20px" ) ]
                , class "mr3 pointer"
                , onClick ToggleNavbar
                ]
                [ responsiveImg "/images/plus.png" ]
            ]
        , mobileTopBarContent model
        ]


mobileTopBarContent : Model -> Html Msg
mobileTopBarContent model =
    if model.navbarOpen then
        div
            [ class "w-100 bg-green flex items-center justify-center white fixed z-999 ph3 fade-in a-3"
            , style [ mobileFullHeight model ]
            ]
            [ p [] [ text "made with love at CAST" ]
            ]
    else
        span [] []


mobileBottomNav : Model -> Html Msg
mobileBottomNav model =
    div
        [ class <| classes [ "bg-green w-100 fixed left-0 bottom-0 z-5 flex items-center justify-center" ]
        , classList [ showAtResults model ]
        , style [ ( "height", px model.mobileNav.bottomHeight ) ]
        ]
        [ dateBottomBarOptions model ]


logo : Html Msg
logo =
    div [ class "w3 w4-ns" ] [ responsiveImg "/images/tech-for-good.png" ]


navbarOptions : Model -> Html Msg
navbarOptions model =
    div [ class "pt1 pb3-ns t-5 all ease bg-green" ]
        [ dateSideOptions model
        , distanceOptions model
        ]
