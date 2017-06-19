module Data.Maps exposing (..)

import Model exposing (..)
import Data.Ports exposing (..)
import Data.Events exposing (..)


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
makeMarker { url, title, lat, lng } =
    Marker url title lat lng


centerAtLondon : Marker
centerAtLondon =
    Marker "" "" 51.5062 0.1164
