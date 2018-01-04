module Types exposing (..)

import Date exposing (..)
import Dom
import Geolocation
import RemoteData exposing (WebData, RemoteData)
import Time exposing (..)
import Window


type alias Model =
    { postcode : Postcode
    , selectedDate : DateRange
    , meetupEvents : WebData (List Event)
    , customEvents : WebData (List Event)
    , userGeolocation : GeolocationData
    , userPostcodeLocation : WebData Coords
    , selectedLocation : Coords
    , currentDate : Maybe Date
    , topNavOpen : Bool
    , searchRadius : Int
    , mapId : String
    , eventsContainerId : String
    , window : Window.Size
    , mobileDateOptionsVisible : Bool
    , bottomNavOpen : Bool
    , mobileNav :
        { topHeight : Int
        , bottomHeight : Int
        }
    }


type alias Event =
    { title : String
    , url : String
    , time : Date
    , address : String
    , venueName : String
    , lat : Maybe Float
    , lng : Maybe Float
    , groupLat : Maybe Float
    , groupLng : Maybe Float
    , rsvpCount : Int
    , groupName : String
    , distance : Int
    }


type Postcode
    = NotEntered
    | Invalid String
    | Valid String


type DateRange
    = Today
    | ThisWeek
    | ThisMonth
    | All


type alias Coords =
    { lat : Float
    , lng : Float
    }


type alias MapOptions =
    { marker : Marker
    , mapId : String
    }


type alias Marker =
    { url : String
    , title : String
    , lat : Float
    , lng : Float
    }


type alias GeolocationData =
    RemoteData Geolocation.Error Geolocation.Location


type Msg
    = UpdatePostcode String
    | SetDateRange DateRange
    | ReceiveMeetupEvents (WebData (List Event))
    | ReceiveCustomEvents (WebData (List Event))
    | GetGeolocation
    | ReceiveGeolocation GeolocationData
    | CurrentDate Time
    | RecievePostcodeLatLng (WebData Coords)
    | CenterMapOnUser
    | CenterEvent Marker
    | FetchEvents
    | FitBounds
    | ToggleTopNavbar
    | MobileDateVisible Bool
    | BottomNavOpen Bool
    | UpdateMap
    | ResetMobileNav
    | FilteredMarkers
    | RefreshMapSize
    | WindowSize Window.Size
    | ScrollToEvent Float
    | Scroll (Result Dom.Error ())


type alias Style =
    ( String, String )
