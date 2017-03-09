module Update exposing (..)

import Model exposing (..)
import Data.Events exposing (getEvents)
import Data.Location exposing (..)
import Data.Dates exposing (..)
import Data.Ports exposing (..)
import Date exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetPostcode postcode ->
            { model | postcode = postcode } ! []

        SetDate date ->
            toggleSelectedDate model date

        GetEvents ->
            model ! [ getEvents ]

        Events (Ok events) ->
            { model | events = events } ! [ updateMarkers (eventMarkers events) ]

        Events (Err err) ->
            let
                log =
                    Debug.log "Request Error" err
            in
                model ! []

        GetLocation ->
            model ! [ getLocation ]

        Location (Ok location) ->
            { model | userLocation = Just (getCoords location) } ! []

        Location (Err err) ->
            let
                log =
                    Debug.log "Location Error" err
            in
                model ! []

        CurrentDate currentDate ->
            { model | currentDate = Just (fromTime currentDate) } ! []
