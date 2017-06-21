module Views.Map exposing (..)

import Data.Events exposing (filterEvents)
import Helpers.Style exposing (classes, isMobile, px)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


renderMap : Model -> Html Msg
renderMap model =
    if model.mapVisible then
        div
            [ class <| classes [ "flex w-100 z-5", mapPositioning model ]
            , style [ ( "height", px <| mapHeight model ) ]
            ]
            [ div [ class "ml6-ns pl4-ns" ] []
            , div [ id model.mapId, class mapBaseClasses ] []
            ]
    else
        mapPlaceholder model


mapHeight : Model -> Int
mapHeight ({ window, mobileNav } as model) =
    if isMobile model then
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
    let
        visibleEvents =
            List.length <| filterEvents model
    in
        if visibleEvents > 0 then
            "fixed"
        else
            "absolute"


mapBaseClasses : String
mapBaseClasses =
    "fade-in bg-light-gray w-100"
