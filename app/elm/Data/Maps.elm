module Data.Maps exposing (..)

import Model exposing (..)
import Data.Dates exposing (..)
import Data.Location.Radius exposing (..)
import Data.Ports exposing (..)


updateFilteredMarkers : Model -> Cmd Msg
updateFilteredMarkers model =
    model.events
        |> filterByDate model
        |> filterByDistance model
        |> extractMarkers
        |> updateMarkers


extractMarkers : List Event -> List Marker
extractMarkers =
    List.map makeMarker


makeMarker : Event -> Marker
makeMarker { url, description, lat, lng } =
    Marker url description lat lng


centerAtLondon : Marker
centerAtLondon =
    Marker "" "" 51.5062 0.1164
