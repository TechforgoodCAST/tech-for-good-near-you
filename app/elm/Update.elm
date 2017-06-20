module Update exposing (..)

import Data.Dates exposing (getCurrentDate, handleSelectedDate, setCurrentDate)
import Data.Events exposing (handleSearchResults)
import Data.Location.Geo exposing (getGeolocation, handleGeolocation, handleGeolocationError, setUserLocation)
import Data.Location.Postcode exposing (handleUpdatePostcode, validatePostcode)
import Data.Location.Radius exposing (handleSearchRadius)
import Data.Maps exposing (initMapAtLondon, updateFilteredMarkers)
import Data.Ports exposing (centerEvent, centerMapOnUser, resizeMap)
import Model exposing (..)
import Request.Events exposing (getEvents, handleReceiveEvents)
import Request.Postcode exposing (handleGetLatLngFromPostcode)
import Update.Extra exposing (addCmd, andThen)


init : ( Model, Cmd Msg )
init =
    initialModel ! [ getCurrentDate, initMapAtLondon ]


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
            (model |> handleUpdatePostcode postcode) ! []

        SetDateRange date ->
            (handleSelectedDate date model ! [])
                |> andThen update FilteredMarkers

        GetGeolocation ->
            { model | fetchingLocation = True } ! [ getGeolocation ]

        ReceiveGeolocation (Err _) ->
            (model |> handleGeolocationError) ! []

        ReceiveGeolocation (Ok location) ->
            (model |> handleGeolocation location) ! []

        CurrentDate date ->
            (model |> setCurrentDate date) ! []

        SetView view ->
            { model | view = view } ! []

        NavigateToResults ->
            (model |> handleSearchResults) ! [ getEvents, setUserLocation model.userLocation ]

        ReceiveEvents (Err err) ->
            { model | fetchingEvents = False } ! []

        ReceiveEvents (Ok events) ->
            (handleReceiveEvents events model ! [])
                |> addCmd resizeMap
                |> andThen update FilteredMarkers

        GoToDates ->
            { model | view = MyDates } ! [ handleGetLatLngFromPostcode model ]

        RecievePostcodeLatLng (Err err) ->
            model ! []

        RecievePostcodeLatLng (Ok coords) ->
            { model | userLocation = Just coords } ! []

        SetSearchRadius radius ->
            (handleSearchRadius radius model ! [])
                |> andThen update FilteredMarkers

        Restart ->
            { model | view = MyLocation, mapVisible = False } ! []

        CenterEvent marker ->
            model ! [ centerEvent marker ]

        ToggleNavbar ->
            { model | navbarOpen = not model.navbarOpen } ! []

        FilteredMarkers ->
            model ! [ updateFilteredMarkers model ]

        CenterMapOnUser ->
            model ! [ centerMapOnUser ]
