module State exposing (..)

import Data.Dates exposing (getCurrentDate, handleSelectedDate, setCurrentDate)
import Data.Events exposing (handleFetchEvents, handleGoToSearchResults)
import Data.Location.Geo exposing (getGeolocation, handleGeolocation, setUserLocation)
import Data.Location.Postcode exposing (handleUpdatePostcode, validatePostcode)
import Data.Location.Radius exposing (handleSearchRadius)
import Data.Maps exposing (handleMobileBottomNavOpen, initMapAtLondon, refreshMapSize, updateFilteredMarkers, updateMap)
import Data.Navigation exposing (handleResetMobileNav, handleToggleTopNavbar)
import Data.Ports exposing (centerEvent, centerMapOnUser, fitBounds, resizeMap, scrollToEvent)
import Helpers.Window exposing (getWindowSize, handleScrollEventsToTop, scrollEventContainer)
import Types exposing (..)
import RemoteData exposing (RemoteData(..))
import Request.CustomEvents exposing (getCustomEvents, handleReceiveCustomEvents)
import Request.MeetupEvents exposing (getMeetupEvents, handleReceiveMeetupEvents)
import Request.Postcode exposing (handleGetLatLngFromPostcode, handleRecievePostcodeLatLng)
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
    , meetupEvents = NotAsked
    , customEvents = NotAsked
    , userPostcodeLocation = NotAsked
    , userGeolocation = NotAsked
    , selectedUserLocation = Nothing
    , currentDate = Nothing
    , mapVisible = False
    , view = MyLocation
    , searchRadius = 300
    , topNavOpen = False
    , mapId = "t4g-google-map"
    , eventsContainerId = "events-container"
    , mobileDateOptionsVisible = False
    , bottomNavOpen = False
    , window = { width = 0, height = 0 }
    , mobileNav = { topHeight = 60, bottomHeight = 50 }
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
            { model | userGeolocation = Loading } ! [ getGeolocation ]

        ReceiveGeolocation (Success location) ->
            ((model |> handleGeolocation (Success location)) ! [])
                |> andThen update (SetView MyDates)
                |> andThen update FetchEvents

        ReceiveGeolocation remoteData ->
            (model |> handleGeolocation remoteData) ! []

        CurrentDate date ->
            (model |> setCurrentDate date) ! []

        SetView view ->
            { model | view = view } ! []

        NavigateToResults ->
            ((model |> handleGoToSearchResults) ! [ setUserLocation model.selectedUserLocation ])
                |> andThen update UpdateMap

        ReceiveMeetupEvents events ->
            (handleReceiveMeetupEvents events model ! [])
                |> andThen update UpdateMap

        ReceiveCustomEvents events ->
            (handleReceiveCustomEvents events model ! [])
                |> andThen update UpdateMap

        FetchEvents ->
            (model |> handleFetchEvents) ! [ getMeetupEvents, getCustomEvents ]

        GoToDates ->
            { model | view = MyDates } ! [ handleGetLatLngFromPostcode model ]

        RecievePostcodeLatLng (Success coords) ->
            (handleRecievePostcodeLatLng (Success coords) model ! [])
                |> andThen update FetchEvents

        RecievePostcodeLatLng remoteData ->
            handleRecievePostcodeLatLng remoteData model ! []

        SetSearchRadius radius ->
            (handleSearchRadius radius model ! [])
                |> andThen update FilteredMarkers

        MobileDateVisible bool ->
            { model | mobileDateOptionsVisible = bool } ! []

        UpdateMap ->
            model ! [ updateMap ]

        Restart ->
            { model | view = MyLocation, mapVisible = False } ! []

        CenterEvent marker ->
            model ! [ centerEvent marker ]

        FitBounds ->
            model ! [ fitBounds ]

        ToggleTopNavbar ->
            (model |> handleToggleTopNavbar) ! []

        BottomNavOpen bool ->
            { model | bottomNavOpen = bool } ! [ refreshMapSize ]

        ResetMobileNav ->
            (model |> handleResetMobileNav) ! [ refreshMapSize ]

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
