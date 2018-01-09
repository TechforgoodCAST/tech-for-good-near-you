module Types exposing (..)

import Date exposing (..)
import Dom
import RemoteData exposing (WebData)
import Time exposing (..)
import Window


type alias Model =
    { postcode : Postcode
    , selectedDate : DateRange
    , today : Maybe Date
    , meetupEvents : WebData (List Event)
    , customEvents : WebData (List Event)
    , userLocation : WebData Coords
    , searchRadius : Int
    , topNavOpen : Bool
    , bottomNavOpen : Bool
    , mobileDateOptionsVisible : Bool
    , window : Window.Size
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


type Msg
    = UpdatePostcode String
    | ClearUserLocation
    | SetDateRange DateRange
    | ReceiveMeetupEvents (WebData (List Event))
    | ReceiveCustomEvents (WebData (List Event))
    | CurrentDate Time
    | RecievePostcodeLatLng (WebData Coords)
    | CenterMapOnUser
    | CenterEvent Marker
    | FetchEvents
    | FetchEventsForPostcode
    | FitBounds
    | ToggleTopNavbar
    | MobileDateVisible Bool
    | BottomNavOpen Bool
    | UpdateMap
    | UpdateUserLocation Coords
    | ResetMobileNav
    | FilteredMarkers
    | RefreshMapSize
    | WindowSize Window.Size
    | ScrollToEvent Float
    | Scroll (Result Dom.Error ())


type alias Style =
    ( String, String )
