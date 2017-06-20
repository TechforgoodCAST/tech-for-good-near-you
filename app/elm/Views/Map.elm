module Views.Map exposing (..)

import Data.Events exposing (filterEvents)
import Helpers.Style exposing (classes)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


renderMap : Model -> Html Msg
renderMap model =
    if model.mapVisible then
        div [ class <| classes [ "flex w-100 z-5", mapPositioning model ] ]
            [ div [ class "ml6-ns pl4-ns" ] []
            , div [ id "myMap", class mapBaseClasses ] []
            ]
    else
        div []
            [ div [] []
            , div [ id "myMap", class "dn" ] []
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
    "vh-50-ns vh-25 fade-in bg-light-gray w-100"
