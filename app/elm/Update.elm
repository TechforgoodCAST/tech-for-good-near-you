module Update exposing (..)

import Model exposing (..)
import Data.Request exposing (getResults)
import Geolocation exposing (now)
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePostcode postcode ->
            { model | postcode = postcode } ! []

        SetDate date ->
            { model | date = date } ! []

        GetSearchResults ->
            model ! [ getResults ]

        SearchResults (Ok results) ->
            { model | events = results } ! []

        SearchResults (Err err) ->
            let
                log =
                    Debug.log "Request Error" err
            in
                model ! []

        GetLocation ->
            model ! [ getLocation ]

        Location (Ok location) ->
            let
                log =
                    Debug.log "Location results" location
            in
                { model | userLocation = Just (getCoords location) } ! []

        Location (Err err) ->
            let
                log =
                    Debug.log "Location Error" err
            in
                model ! []


getLocation : Cmd Msg
getLocation =
    Task.attempt Location now


getCoords : Geolocation.Location -> Coords
getCoords location =
    { lat = location.latitude
    , lon = location.longitude
    }
