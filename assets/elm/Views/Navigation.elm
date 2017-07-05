module Views.Navigation exposing (..)

import Helpers.Html exposing (responsiveImg)
import Helpers.Style exposing (classes, desktopOnly, mobileFullHeight, mobileMaxHeight, mobileOnly, px, rotateZ, showAtResults, translateY)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Views.Dates exposing (..)
import Views.Distance exposing (..)
import Views.Location exposing (centerCrosshairWhite, locationCrosshair)


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
                , div
                    [ class "absolute left-0 right-0 ph3"
                    , style [ ( "bottom", "-0.3em" ) ]
                    ]
                    [ techForGoodSummer ]
                ]
            ]
        ]


techForGoodSummer : Html msg
techForGoodSummer =
    a
        [ class "no-underline white tc db"
        , href "/user-event/new"
        ]
        [ div []
            [ p [ class "f5 f6-ns" ] [ text "Add your own Tech for Good event!" ]
            , div [ class "w-100 ph2" ] [ responsiveImg "/images/tech-for-good-summer.png" ]
            ]
        ]


mobileTopBar : Model -> Html Msg
mobileTopBar model =
    div [ class mobileOnly, style [ ( "margin-bottom", px model.mobileNav.topHeight ) ] ]
        [ div
            [ class "fixed z-5 bg-green white top-0 left-0 w-100 flex justify-between items-center"
            , style [ ( "height", px model.mobileNav.topHeight ) ]
            ]
            [ div [ class "ml2 mt2 pointer flex", onClick Restart ] [ logo, p [ class "ml2" ] [ text "near you" ] ]
            , div
                [ style [ ( "width", "20px" ), plusIconRotation model ]
                , class "mr3 pointer"
                , onClick ToggleTopNavbar
                ]
                [ responsiveImg "/images/plus.png" ]
            ]
        , mobileTopBarContent model
        ]


plusIconRotation : Model -> ( String, String )
plusIconRotation model =
    if model.topNavOpen then
        ( "transform", rotateZ 45 )
    else
        ( "transform", rotateZ 0 )


mobileTopBarContent : Model -> Html Msg
mobileTopBarContent model =
    if model.topNavOpen then
        div
            [ class "w-100 bg-green flex items-center justify-center flex-column white fixed z-999 ph3 fade-in a-3"
            , style [ mobileMaxHeight model ]
            ]
            [ div [ class "ph4 mb5" ] [ techForGoodSummer ]
            , a [ href "http://www.wearecast.org.uk/", target "_blank", class "no-underline white db" ] [ p [] [ text "made with love at CAST" ] ]
            ]
    else
        span [] []


mobileBottomNav : Model -> Html Msg
mobileBottomNav model =
    div
        [ class <| classes [ "bg-green w-100 fixed left-0 bottom-0 z-5 flex items-center justify-center" ]
        , classList [ showAtResults model ]
        , style
            [ ( "height", px model.mobileNav.bottomHeight )
            , bottomMobileNavPosition model
            ]
        ]
        [ mobileBottomNavOptions model ]


bottomMobileNavPosition : Model -> ( String, String )
bottomMobileNavPosition model =
    if model.bottomNavOpen then
        ( "transform", translateY <| (model.window.height - model.mobileNav.topHeight) // -2 )
    else
        ( "transform", translateY 0 )


mobileBottomNavOptions : Model -> Html Msg
mobileBottomNavOptions model =
    if model.mobileDateOptionsVisible then
        mobileDateOptions model
    else
        mobileMainOptions model


mobileMainOptions : Model -> Html Msg
mobileMainOptions model =
    div [ class "flex items-center justify-between w-100 ph3" ]
        [ div [ style [ ( "width", "30px" ) ], class "spin" ] [ centerCrosshairWhite model ]
        , div [ style [ ( "width", "25px" ) ], class "pointer", onClick <| MobileDateVisible True ] [ responsiveImg "/images/calendar-white.svg" ]
        , div [ style [ ( "width", "25px" ), chevronDirection model ], class "pointer", handleBottomNavToggle model ] [ responsiveImg "/images/chevron.svg" ]
        ]


mobileDateOptions : Model -> Html Msg
mobileDateOptions model =
    div [ class "flex items-center justify-between w-100 ph3" ]
        [ div
            [ class "absolute left-0 top-0"
            , style [ ( "margin-left", "0.5rem" ), ( "margin-top", "0.5em" ) ]
            ]
            [ dateBottomBarOptions model ]
        , div
            [ onClick <| MobileDateVisible False
            , style
                [ ( "transform", rotateZ 45 )
                , ( "width", "20px" )
                , ( "margin-right", "0.7rem" )
                , ( "margin-top", "1em" )
                ]
            , class "absolute right-0 top-0"
            ]
            [ responsiveImg "/images/plus.png" ]
        ]


chevronDirection : Model -> ( String, String )
chevronDirection model =
    if model.bottomNavOpen then
        ( "transform", rotateZ 180 )
    else
        ( "transform", rotateZ 0 )


handleBottomNavToggle : Model -> Attribute Msg
handleBottomNavToggle model =
    if model.bottomNavOpen then
        onClick <| BottomNavOpen False
    else
        onClick <| BottomNavOpen True


logo : Html Msg
logo =
    div [ class "w3 w4-ns" ] [ responsiveImg "/images/tech-for-good.png" ]


navbarOptions : Model -> Html Msg
navbarOptions model =
    div [ class "pt1 pb3-ns t-5 all ease bg-green" ]
        [ dateSideOptions model
        , eventsNearMe model
        , distanceOptions model
        ]


eventsNearMe : Model -> Html Msg
eventsNearMe model =
    div [ class "white t-3 all ease mt4", classList [ showAtResults model ] ]
        [ p [] [ text "events near me:" ]
        , div [ class "spin w4" ] [ centerMap model ]
        ]
