port module Update exposing (..)

import Model exposing (..)
import Data.Request exposing (getEvents)
import Data.Location exposing (..)
import Data.Dates exposing (..)
import Date exposing (..)


port updateMarkers : List Marker -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetPostcode postcode ->
            { model | postcode = postcode } ! []

        SetDate date ->
            let
                noDateSelected =
                    { model | selectedDate = "" }

                newDateSelected =
                    { model | selectedDate = date }
            in
                if model.selectedDate == date then
                    noDateSelected ! [ updateMarkers (eventMarkers (filterByDate noDateSelected noDateSelected.events)) ]
                else
                    newDateSelected ! [ updateMarkers (eventMarkers (filterByDate newDateSelected newDateSelected.events)) ]

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


eventMarkers : List Event -> List Marker
eventMarkers events =
    events
        |> List.map (\{ lat, lng, description, url } -> { url = url, lat = lat, lng = lng, description = description })
