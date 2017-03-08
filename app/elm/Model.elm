module Model exposing (..)

import Http
import Geolocation
import Time exposing (..)


type alias Model =
    { postcode : String
    , selectedDate : String
    , events : List Event
    , userLocation : Maybe Coords
    , currentDate : Maybe Time
    }


type alias Event =
    { name : String
    , description : String
    , url : String
    , time : Float
    , address : String
    , venueName : String
    , lat : Float
    , lon : Float
    , rsvpCount : Int
    , groupName : String
    }


type alias Coords =
    { lat : Float
    , lon : Float
    }


type Msg
    = UpdatePostcode String
    | SetDate String
    | GetSearchResults
    | SearchResults (Result Http.Error (List Event))
    | GetLocation
    | Location (Result Geolocation.Error Geolocation.Location)
    | CurrentDate Time
