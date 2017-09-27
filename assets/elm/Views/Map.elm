module Views.Map exposing (..)

import Data.Events exposing (filterEvents, numberVisibleEvents)
import Helpers.Html exposing (emptyProperty)
import Helpers.Style exposing (classes, isMobile, px)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)


renderMap : Model -> Html Msg
renderMap model =
    if model.mapVisible then
        div
            [ class <| classes [ "flex w-100 z-5", mapPositioning model ]
            , style [ ( "height", px <| mapHeight model ) ]
            , handleHideMobileDateOptions model
            ]
            [ div [ class "ml6-ns pl4-ns" ] []
            , div [ id model.mapId, class mapBaseClasses ] []
            ]
    else
        mapPlaceholder model


handleHideMobileDateOptions : Model -> Attribute Msg
handleHideMobileDateOptions model =
    if isMobile model then
        onClick ResetMobileNav
    else
        emptyProperty


mapHeight : Model -> Int
mapHeight ({ window, mobileNav } as model) =
    if isMobile model then
        if model.bottomNavOpen then
            ((window.height - mobileNav.topHeight) // 2) - mobileNav.bottomHeight
        else
            window.height - mobileNav.topHeight - mobileNav.bottomHeight
    else
        window.height // 2


mapPlaceholder : Model -> Html msg
mapPlaceholder model =
    div []
        [ div [] []
        , div [ id model.mapId, class "dn" ] []
        ]


mapPositioning : Model -> String
mapPositioning model =
    if numberVisibleEvents model > 0 then
        "fixed"
    else
        "absolute"


mapBaseClasses : String
mapBaseClasses =
    "fade-in bg-light-gray w-100 leaflet-container"
