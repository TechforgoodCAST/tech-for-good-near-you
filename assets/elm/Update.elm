module Update exposing (..)

import Data.Dates exposing (getCurrentDate, handleSelectedDate, setCurrentDate)
import Data.Events exposing (handleSearchResults)
import Data.Location.Geo exposing (getGeolocation, handleGeolocation, handleGeolocationError, setUserLocation)
import Data.Location.Postcode exposing (handleUpdatePostcode, validatePostcode)
import Data.Location.Radius exposing (handleSearchRadius)
import Data.Maps exposing (handleMobileBottomNavOpen, initMapAtLondon, refreshMapSize, updateFilteredMarkers)
import Data.Ports exposing (centerEvent, centerMapOnUser, fitBounds, resizeMap, scrollToEvent)
import Helpers.Window exposing (getWindowSize, handleScrollEventsToTop, scrollEventContainer)
import Model exposing (..)
import Request.CustomEvents exposing (getCustomEvents, handleReceiveCustomEvents)
import Request.MeetupEvents exposing (getMeetupEvents, handleReceiveMeetupEvents)
import Request.Postcode exposing (handleGetLatLngFromPostcode)
import Update.Extra exposing (addCmd, andThen)
import Window exposing (resizes)


init : ( Model, Cmd Msg )
init =
    initialModel
        ! [ getCurrentDate
          , initMapAtLondon initialModel
          , getWindowSize
          ]


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
    , topNavOpen = False
    , mapId = "t4g-google-map"
    , eventsContainerId = "events-container"
    , window =
        { width = 0
        , height = 0
        }
    , mobileDateOptionsVisible = False
    , bottomNavOpen = False
    , mobileNav =
        { topHeight = 60
        , bottomHeight = 50
        }
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePostcode postcode ->
            (model |> handleUpdatePostcode postcode) ! []

        SetDateRange date ->
            (handleSelectedDate date model ! [])
                |> andThen update FilteredMarkers
                |> addCmd (handleScrollEventsToTop model)

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
            (model |> handleSearchResults) ! [ getMeetupEvents, setUserLocation model.userLocation ]

        ReceiveMeetupEvents (Err err) ->
            { model | fetchingEvents = False } ! []

        ReceiveMeetupEvents (Ok events) ->
            (handleReceiveMeetupEvents events model ! [])
                |> addCmd getCustomEvents

        ReceiveCustomEvents (Err err) ->
            { model | fetchingEvents = False } ! []

        ReceiveCustomEvents (Ok events) ->
            (handleReceiveCustomEvents events model ! [])
                |> addCmd resizeMap
                |> addCmd fitBounds
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

        MobileDateVisible bool ->
            { model | mobileDateOptionsVisible = bool } ! []

        Restart ->
            { model | view = MyLocation, mapVisible = False } ! []

        CenterEvent marker ->
            model ! [ centerEvent marker ]

        ToggleTopNavbar ->
            { model | topNavOpen = not model.topNavOpen } ! []

        BottomNavOpen bool ->
            { model | bottomNavOpen = bool } ! [ refreshMapSize ]

        ResetMobileNav ->
            { model | bottomNavOpen = False, mobileDateOptionsVisible = False } ! [ refreshMapSize ]

        FilteredMarkers ->
            model ! [ updateFilteredMarkers model ]

        CenterMapOnUser ->
            model ! [ centerMapOnUser ]

        RefreshMapSize ->
            model ! [ resizeMap ]

        WindowSize size ->
            { model | window = size } ! []

        ScrollToEvent offset ->
            model ! [ scrollEventContainer offset model ]

        Scroll _ ->
            model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ resizes WindowSize
        , scrollToEvent ScrollToEvent
        , handleMobileBottomNavOpen model
        ]
