module Update exposing (..)

import Data.Dates exposing (getCurrentDate, handleSelectedDate, setCurrentDate)
import Data.Events exposing (handleSearchResults)
import Data.Location.Geo exposing (getGeolocation, handleGeolocation, handleGeolocationError, setUserLocation)
import Data.Location.Postcode exposing (handleUpdatePostcode, validatePostcode)
import Data.Location.Radius exposing (handleSearchRadius)
import Data.Maps exposing (handleMobileBottomNavOpen, handleUpdateFilteredMarkers, initMapAtLondon, refreshMap)
import Data.Navigation exposing (handleResetMobileNav, handleToggleTopNavbar)
import Data.Ports exposing (centerEvent, centerMapOnUser, fitBounds, mapAttached, resizeMap, scrollToEvent)
import Delay exposing (after)
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
            (handleGeolocation location model ! [])
                |> andThen update GoToDates

        CurrentDate date ->
            (model |> setCurrentDate date) ! []

        SetView view ->
            { model | view = view } ! []

        NavigateToResults ->
            (model |> handleSearchResults) ! [ initMapAtLondon model ]

        ReceiveMeetupEvents (Err err) ->
            { model | fetchingEvents = False } ! []

        ReceiveMeetupEvents (Ok events) ->
            (handleReceiveMeetupEvents events model ! [])
                |> andThen update FilteredMarkers
                |> addCmd refreshMap

        ReceiveCustomEvents (Err err) ->
            { model | fetchingEvents = False } ! []

        ReceiveCustomEvents (Ok events) ->
            (handleReceiveCustomEvents events model ! [])
                |> andThen update FilteredMarkers
                |> addCmd refreshMap

        GoToDates ->
            { model | view = MyDates }
                ! [ handleGetLatLngFromPostcode model
                  , getMeetupEvents
                  , getCustomEvents
                  ]

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
            (model |> handleToggleTopNavbar) ! []

        BottomNavOpen bool ->
            { model | bottomNavOpen = bool } ! [ after 50 ResizeMap ]

        ResetMobileNav ->
            (model |> handleResetMobileNav) ! [ after 50 ResizeMap ]

        FilteredMarkers ->
            model ! [ handleUpdateFilteredMarkers model ]

        CenterMapOnUser ->
            model ! [ centerMapOnUser ]

        MapAttached _ ->
            (model ! [ setUserLocation model.userLocation ])
                |> andThen update FilteredMarkers
                |> addCmd refreshMap

        ResizeMap ->
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
        , mapAttached MapAttached
        ]
