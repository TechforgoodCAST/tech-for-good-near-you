module Update exposing (..)

import Model exposing (..)
import Data.Events exposing (getEvents)
import Data.Location.Geo exposing (..)
import Data.Location.Postcode exposing (..)
import Data.Dates exposing (..)
import Data.Events exposing (..)
import Data.Ports exposing (..)
import Data.Maps exposing (..)
import Date exposing (..)
import Helpers.Delay exposing (..)
import Update.Extra.Infix exposing ((:>))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePostcode postcode ->
            { model | postcode = validatePostcode postcode } ! []

        SetDate date ->
            let
                newModel =
                    toggleSelectedDate model date
            in
                newModel ! [ updateFilteredMarkers newModel ]

        Events (Err err) ->
            { model | fetchingEvents = False } ! []

        Events (Ok events) ->
            let
                newModel =
                    { model
                        | events = addDistanceToEvents model events
                        , fetchingEvents = False
                    }
            in
                newModel ! [ updateFilteredMarkers newModel ]

        GetGeolocation ->
            { model | fetchingLocation = True } ! [ getGeolocation ]

        Location (Err err) ->
            { model
                | userLocationError = True
                , fetchingLocation = False
            }
                ! []

        Location (Ok location) ->
            { model
                | userLocation = Just (getCoords location)
                , userLocationError = False
                , view = MyDates
                , fetchingLocation = False
            }
                ! []

        InitMap ->
            model ! [ initMap centerAtLondon, setUserLocation model.userLocation ]

        CurrentDate currentDate ->
            { model | currentDate = Just (fromTime currentDate) } ! []

        SetView view ->
            { model | view = view } ! []

        NavigateToResults ->
            { model | view = Results, fetchingEvents = True } ! [ getEvents, delay 100 InitMap ]

        GetLatLngFromPostcode ->
            model ! [ getLatLngFromPostcode model ]

        PostcodeToLatLng (Err err) ->
            model ! []

        PostcodeToLatLng (Ok coords) ->
            { model | userLocation = Just coords } ! []

        GoToDates ->
            (model ! [])
                :> update (SetView MyDates)
                :> update GetLatLngFromPostcode

        SetSearchRadius radius ->
            let
                newRadius =
                    radius
                        |> String.toInt
                        |> Result.withDefault 300

                newModel =
                    { model | searchRadius = newRadius }
            in
                newModel ! [ updateFilteredMarkers newModel ]

        CenterMapOnUser ->
            model ! [ centerMapOnUser () ]

        CenterEvent marker ->
            model ! [ centerEvent marker ]

        ToggleNavbar ->
            { model | navbarOpen = not model.navbarOpen } ! []
