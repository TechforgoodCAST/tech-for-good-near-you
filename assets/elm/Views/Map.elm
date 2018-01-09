module Views.Map exposing (..)

import Config
import Data.Events exposing (filterEvents, numberVisibleEvents)
import Helpers.Html exposing (emptyProperty)
import Helpers.Style exposing (classes, isMobile, px)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)


renderMap : Model -> Html Msg
renderMap model =
    div
        [ classes [ "flex w-100 z-5", mapPositioning model ]
        , style [ ( "height", px <| mapHeight model ) ]
        , handleHideMobileDateOptions model
        ]
        [ div [ class "ml6-ns pl4-ns" ] []
        , div [ id Config.mapId, class mapBaseClasses ] []
        ]


handleHideMobileDateOptions : Model -> Attribute Msg
handleHideMobileDateOptions model =
    if isMobile model then
        onClick ResetMobileNav
    else
        emptyProperty


mapHeight : Model -> Int
mapHeight ({ window } as model) =
    let
        { topHeight, bottomHeight } =
            Config.mobileNav
    in
        if isMobile model then
            if model.bottomNavOpen then
                ((window.height - topHeight) // 2) - bottomHeight
            else
                window.height - topHeight - bottomHeight
        else
            window.height // 2


mapPositioning : Model -> String
mapPositioning model =
    if numberVisibleEvents model > 0 then
        "fixed"
    else
        "absolute"


mapBaseClasses : String
mapBaseClasses =
    "fade-in bg-light-gray w-100"
