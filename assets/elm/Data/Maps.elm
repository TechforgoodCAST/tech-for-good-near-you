module Data.Maps exposing (..)

import Data.Events exposing (eventLat, eventLng, filterEvents)
import Data.Ports exposing (fitBounds, initMap, openBottomNav, resizeMap, updateMarkers)
import Helpers.Style exposing (isMobile)
import Model exposing (..)


handleMobileBottomNavOpen : Model -> Sub Msg
handleMobileBottomNavOpen model =
    if isMobile model then
        openBottomNav BottomNavOpen
    else
        Sub.none


refreshMap : Cmd Msg
refreshMap =
    Cmd.batch
        [ resizeMap
        , fitBounds
        ]


initMapAtLondon : Model -> Cmd Msg
initMapAtLondon model =
    initMap
        { marker = centerAtLondon
        , mapId = model.mapId
        }


handleUpdateFilteredMarkers : Model -> Cmd Msg
handleUpdateFilteredMarkers model =
    if model.view == Results then
        model
            |> filterEvents
            |> extractMarkers
            |> updateMarkers
    else
        Cmd.none


extractMarkers : List Event -> List Marker
extractMarkers =
    List.map makeMarker


makeMarker : Event -> Marker
makeMarker e =
    Marker e.url e.title (eventLat e) (eventLng e)


centerAtLondon : Marker
centerAtLondon =
    Marker "" "" 51.5062 0.1164
