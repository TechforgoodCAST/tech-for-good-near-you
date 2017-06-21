module Views.Map exposing (..)

import Data.Events exposing (filterEvents)
import Helpers.Style exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


renderMap : Model -> Html Msg
renderMap model =
    if model.mapVisible then
        div
            [ class <| classes [ "flex w-100 z-5", mapPositioning model ]
            , style [ ( "height", (mapHeight model) ++ "px" ) ]
            ]
            [ div [ class "ml6-ns pl4-ns" ] []
            , div [ id model.mapId, class mapBaseClasses ] []
            ]
    else
        mapPlaceholder model


mapHeight : Model -> String
mapHeight { window, mobileNavHeight } =
    if window.width < 480 then
        window.height - mobileNavHeight |> toString
    else
        window.height // 2 |> toString


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
