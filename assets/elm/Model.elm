module Model exposing (..)

import Date exposing (..)
import Geolocation
import Http
import Time exposing (..)
import Window


type alias Model =
    { postcode : Postcode
    , selectedDate : DateRange
    , events : List Event
    , fetchingEvents : Bool
    , userLocation : Maybe Coords
    , userLocationError : Bool
    , fetchingLocation : Bool
    , currentDate : Maybe Date
    , mapVisible : Bool
    , navbarOpen : Bool
    , view : View
    , searchRadius : Int
    , mapId : String
    , window : Window.Size
    , mobileNavHeight : Int
    }


type alias Event =
    { title : String
    , url : String
    , time : Date
    , address : String
    , venueName : String
    , lat : Float
    , lng : Float
    , rsvpCount : Int
    , groupName : String
    , distance : Int
    }


type View
    = MyLocation
    | MyDates
    | Results


type Postcode
    = NotEntered
    | Invalid String
    | Valid String


type DateRange
    = NoDate
    | Today
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
    | SetDateRange DateRange
    | ReceiveMeetupEvents (Result Http.Error (List Event))
    | ReceiveCustomEvents (Result Http.Error (List Event))
    | GetGeolocation
    | ReceiveGeolocation (Result Geolocation.Error Geolocation.Location)
    | CurrentDate Time
    | SetView View
    | NavigateToResults
    | RecievePostcodeLatLng (Result Http.Error Coords)
    | GoToDates
    | CenterMapOnUser
    | CenterEvent Marker
    | SetSearchRadius String
    | ToggleNavbar
    | Restart
    | FilteredMarkers
    | WindowSize Window.Size
