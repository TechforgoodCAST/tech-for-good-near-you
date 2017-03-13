module Model exposing (..)

import Http
import Geolocation
import Time exposing (..)
import Date exposing (..)


type alias Model =
    { postcode : Postcode
    , selectedDate : DateRange
    , events : List Event
    , userLocation : Maybe Coords
    , fetchingLocation : Bool
    , currentDate : Maybe Date
    , mapVisible : Bool
    , view : View
    }


type alias Event =
    { name : String
    , description : String
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


type alias Coords =
    { lat : Float
    , lng : Float
    }


type alias Marker =
    { url : String
    , description : String
    , lat : Float
    , lng : Float
    }


type Msg
    = UpdatePostcode String
    | SetDate String
    | GetEvents
    | Events (Result Http.Error (List Event))
    | GetGeolocation
    | Location (Result Geolocation.Error Geolocation.Location)
    | CurrentDate Time
    | SetView View
    | InitMap
    | NavigateToResults
    | PostcodeToLatLng (Result Http.Error Coords)
    | GetLatLngFromPostcode
    | GoToDates
