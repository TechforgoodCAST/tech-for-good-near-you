module Update exposing (..)

import Model exposing (..)
import Data.Events exposing (getEvents)
import Data.Location exposing (..)
import Data.Dates exposing (..)
import Data.Events exposing (..)
import Data.Ports exposing (..)
import Date exposing (..)
import Helpers.Delay exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePostcode postcode ->
            { model | postcode = validatePostcode postcode } ! []

        SetDate date ->
            toggleSelectedDate model date

        GetEvents ->
            model ! [ getEvents ]

        Events (Ok events) ->
            { model | events = events } ! [ updateMarkers (extractMarkers events) ]

        Events (Err err) ->
            model ! []

        GetGeolocation ->
            { model | fetchingLocation = True } ! [ getGeolocation ]

        Location (Ok location) ->
            { model
                | userLocation = Just (getCoords location)
                , view = MyDates
                , fetchingLocation = False
            }
                ! []

        InitMap ->
            model ! [ initMap centerAtLondon, setUserLocation model.userLocation ]

        Location (Err err) ->
            model ! []

        CurrentDate currentDate ->
            { model | currentDate = Just (fromTime currentDate) } ! []

        SetView view ->
            { model | view = view } ! []

        NavigateToResults ->
            { model | view = Results } ! [ getEvents, delay 10 InitMap ]
