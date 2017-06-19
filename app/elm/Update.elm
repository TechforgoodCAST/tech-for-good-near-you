module Update exposing (..)

import Data.Dates exposing (getCurrentDate, handleCurrentDate, handleSelectedDate)
import Data.Location.Geo exposing (getGeolocation, handleGeolocation, handleGeolocationError)
import Data.Location.Postcode exposing (validatePostcode)
import Data.Maps exposing (initMapAtLondon, updateFilteredMarkers)
import Data.Ports exposing (centerEvent, centerMapOnUser, resizeMap)
import Data.Results exposing (handleSearchRadius, handleSearchResults)
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
            { model | postcode = validatePostcode postcode } ! []

        SetDateRange date ->
            (handleSelectedDate date model ! [])
                |> andThen update FilteredMarkers

        GetGeolocation ->
            { model | fetchingLocation = True } ! [ getGeolocation ]

        ReceiveGeolocation (Err _) ->
            (model |> handleGeolocationError) ! []

        ReceiveGeolocation (Ok location) ->
            (model |> handleGeolocation location) ! []

        CurrentDate currentDate ->
            (model |> handleCurrentDate currentDate) ! []

        SetView view ->
            { model | view = view } ! []

        NavigateToResults ->
            (model |> handleSearchResults)

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
