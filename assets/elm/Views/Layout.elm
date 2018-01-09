module Views.Layout exposing (..)

import Data.Events exposing (stillLoading)
import Helpers.Style exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Views.Navigation exposing (bottomNav, logo, topNav)


layout : Model -> Html Msg -> Html Msg
layout model content =
    div [ class "flex-ns" ]
        [ topNav model
        , div
            [ class "w-100 ml6-ns pl4-ns flex items-center justify-center"
            , style [ handleMobileHeight model ]
            ]
            [ mobileContainer model content
            , div
                [ class anchorBottom
                , style [ ( "margin-left", "11.5em" ) ]
                ]
                [ desktopCredit ]
            ]
        , bottomNav model
        ]


desktopCredit : Html msg
desktopCredit =
    a
        [ href "http://www.wearecast.org.uk/"
        , target "_blank"
        , classes [ "green no-underline f6", desktopOnly ]
        ]
        [ p [] [ text "made with love at CAST" ] ]


handleMobileHeight : Model -> Style
handleMobileHeight model =
    mobileFullHeight model |> ifMobile model


mobileContainer : Model -> Html Msg -> Html Msg
mobileContainer model content =
    if isMobile model then
        div [ style [ percentScreenHeight 86 model ] ] [ content ]
    else
        content


loadingScreen : Model -> Html msg
loadingScreen model =
    if stillLoading model then
        loading "o-100" model
    else
        loading "o-0 disabled t-delay-500ms" model


loading : String -> Model -> Html msg
loading extraClasses model =
    div
        [ classes
            [ "fixed t-500ms bg-green w-100 white z-999 flex items-center justify-center h-100"
            , extraClasses
            ]
        ]
        [ div [ class "flex items-center flex-column" ]
            [ logo
            , p [ class "mt3" ] [ text "Fetching tech for good events" ]
            ]
        ]
