module Data.Maps exposing (..)

import Data.Events exposing (eventLat, eventLng, filterEvents)
import Data.Ports exposing (initMap, openBottomNav, updateMarkers)
import Delay
import Helpers.Style exposing (isMobile)
import Model exposing (..)


handleMobileBottomNavOpen : Model -> Sub Msg
handleMobileBottomNavOpen model =
    if isMobile model then
        openBottomNav BottomNavOpen
    else
        Sub.none


refreshMapSize : Cmd Msg
refreshMapSize =
    Delay.after 50 RefreshMapSize


initMapAtLondon : Model -> Cmd Msg
initMapAtLondon model =
    initMap
        { marker = centerAtLondon
        , mapId = model.mapId
        }


updateFilteredMarkers : Model -> Cmd Msg
updateFilteredMarkers model =
    model
        |> filterEvents
        |> extractMarkers
        |> updateMarkers


extractMarkers : List Event -> List Marker
extractMarkers =
    List.map makeMarker


makeMarker : Event -> Marker
makeMarker e =
    Marker e.url e.title (eventLat e) (eventLng e)


centerAtLondon : Marker
centerAtLondon =
    Marker "" "" 51.5062 0.1164
