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
            [ id model.mapId
            , class "w-100"
            , style [ ( "height", px <| model.window.height // 2 ) ]
            ]
            []
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
    "fade-in bg-light-gray w-100"
