module State exposing (..)

import Data.Dates exposing (getCurrentDate, handleSelectedDate, setCurrentDate)
import Data.Events exposing (..)
import Data.Location.Geo exposing (getCoords, getGeolocation, handleGeolocation)
import Data.Location.Postcode exposing (handleUpdatePostcode, validatePostcode)
import Data.Maps exposing (handleMobileBottomNavOpen, initMapAtLondon, londonCoords, refreshMapSize, updateFilteredMarkers, updateMap)
import Data.Navigation exposing (handleResetMobileNav, handleToggleTopNavbar)
import Data.Ports exposing (centerEvent, centerMapOnUser, fitBounds, resizeMap, scrollToEvent, updateUserLocation)
import Helpers.Window exposing (getWindowSize, handleScrollEventsToTop, scrollEventContainer)
import RemoteData exposing (RemoteData(..))
import Request.CustomEvents exposing (getCustomEvents, handleReceiveCustomEvents)
import Request.MeetupEvents exposing (getMeetupEvents, handleReceiveMeetupEvents)
import Request.Postcode exposing (handleGetLatLngFromPostcode, handleRecievePostcodeLatLng)
import Types exposing (..)
import Update.Extra exposing (addCmd, andThen)
import Window exposing (resizes)


init : ( Model, Cmd Msg )
init =
    initialModel
        ! [ getCurrentDate
          , initMapAtLondon initialModel
          , getMeetupEvents
          , getCustomEvents
          , getWindowSize
          ]


initialModel : Model
initialModel =
    { postcode = NotEntered
    , selectedDate = All
    , meetupEvents = Loading
    , customEvents = Loading
    , userPostcodeLocation = NotAsked
    , userGeolocation = NotAsked
    , selectedLocation = londonCoords
    , currentDate = Nothing
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
            (handleGeolocation (Success location) model ! [ updateUserLocation (getCoords location) ]) |> andThen update FetchEvents

        ReceiveGeolocation remoteData ->
            (model |> handleGeolocation remoteData) ! []

        CurrentDate date ->
            (model |> setCurrentDate date) ! []

        ReceiveMeetupEvents events ->
            (handleReceiveMeetupEvents events model ! []) |> andThen update UpdateMap

        ReceiveCustomEvents events ->
            (handleReceiveCustomEvents events model ! []) |> andThen update UpdateMap

        FetchEvents ->
            handleFetchEvents model ! [ getMeetupEvents, getCustomEvents ]

        RecievePostcodeLatLng (Success coords) ->
            (handleRecievePostcodeLatLng (Success coords) model ! []) |> andThen update FetchEvents

        RecievePostcodeLatLng remoteData ->
            handleRecievePostcodeLatLng remoteData model ! []

        MobileDateVisible bool ->
            { model | mobileDateOptionsVisible = bool } ! []

        UpdateMap ->
            model ! [ updateMap ]

        CenterEvent marker ->
            model ! [ centerEvent marker ]

        FitBounds ->
            model ! [ fitBounds ]

        ToggleTopNavbar ->
            handleToggleTopNavbar model ! []

        BottomNavOpen bool ->
            { model | bottomNavOpen = bool } ! [ refreshMapSize ]

        ResetMobileNav ->
            handleResetMobileNav model ! [ refreshMapSize ]

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
