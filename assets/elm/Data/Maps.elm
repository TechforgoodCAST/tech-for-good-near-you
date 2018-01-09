module Data.Maps exposing (..)

import Config
import Data.Events exposing (eventLat, eventLng, filterEvents)
import Data.Ports exposing (initMap, openBottomNav, updateMarkers)
import Helpers.Delay exposing (googleMapDelay)
import Helpers.Style exposing (isMobile)
import RemoteData exposing (RemoteData)
import Types exposing (..)


updateMap : Cmd Msg
updateMap =
    Cmd.batch
        [ googleMapDelay FitBounds
        , googleMapDelay RefreshMapSize
        , googleMapDelay FilteredMarkers
        ]


refreshMapSize : Cmd Msg
refreshMapSize =
    googleMapDelay RefreshMapSize


initMapAtLondon : Model -> Cmd Msg
initMapAtLondon model =
    initMap
        { marker = centerAtLondon
        , mapId = Config.mapId
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


londonCoords : Coords
londonCoords =
    Coords 51.5062 0.1164
