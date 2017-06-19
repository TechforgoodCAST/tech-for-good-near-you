module Update exposing (..)

import Data.Dates exposing (..)
import Data.Events exposing (..)
import Data.Location.Geo exposing (..)
import Data.Location.Postcode exposing (..)
import Data.Maps exposing (..)
import Data.Ports exposing (..)
import Date exposing (fromTime)
import Model exposing (..)


init : ( Model, Cmd Msg )
init =
    initialModel ! [ getCurrentDate ]


initialModel : Model
initialModel =
    { postcode = NotEntered
    , selectedDate = NoDate
    , events = []
    , fetchingEvents = False
    , userLocation = Nothing
    , userLocationError = False
    , fetchingLocation = False
    , currentDate = Nothing
    , mapVisible = False
    , view = MyLocation
    , searchRadius = 300
    , navbarOpen = False
    }


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

        ReceiveGeolocation (Err _) ->
            (model |> handleGeolocationError) ! []

        ReceiveGeolocation (Ok location) ->
            (model |> handleGeolocation location) ! []

        CurrentDate currentDate ->
            { model | currentDate = Just (fromTime currentDate) } ! []

        SetView view ->
            { model | view = view } ! []

        NavigateToResults ->
            { model
                | view = Results
                , fetchingEvents = True
                , mapVisible = True
            }
                ! [ getEvents, initMap centerAtLondon, setUserLocation model.userLocation ]

        PostcodeToLatLng (Err err) ->
            model ! []

        PostcodeToLatLng (Ok coords) ->
            { model | userLocation = Just coords } ! []

        GoToDates ->
            { model | view = MyDates } ! [ getLatLngFromPostcode model ]

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

        Restart ->
            { model | view = MyLocation, mapVisible = False } ! []

        CenterEvent marker ->
            model ! [ centerEvent marker ]

        ToggleNavbar ->
            { model | navbarOpen = not model.navbarOpen } ! []
