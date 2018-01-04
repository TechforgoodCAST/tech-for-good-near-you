module Data.Maps exposing (..)

import Data.Events exposing (eventLat, eventLng, filterEvents)
import Data.Ports exposing (initMap, openBottomNav, updateMarkers)
import Helpers.Delay exposing (googleMapDelay)
import Helpers.Style exposing (isMobile)
import Types exposing (..)
import RemoteData exposing (RemoteData)


updateMap : Cmd Msg
updateMap =
    Cmd.batch
        [ googleMapDelay FitBounds
        , googleMapDelay RefreshMapSize
        , googleMapDelay FilteredMarkers
        ]


handleMobileBottomNavOpen : Model -> Sub Msg
handleMobileBottomNavOpen model =
    if isMobile model then
        openBottomNav BottomNavOpen
    else
        Sub.none


refreshMapSize : Cmd Msg
refreshMapSize =
    googleMapDelay RefreshMapSize


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
        |> RemoteData.withDefault []
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
