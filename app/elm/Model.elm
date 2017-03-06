module Model exposing (..)

import Http
import Geolocation


type alias Model =
    { postcode : String
    , date : String
    , events : List SearchResult
    , location : { lat : Float, lon : Float }
    }


type alias SearchResult =
    { name : String
    , description : String
    , url : String
    , time : Int
    , address : String
    , venueName : String
    , lat : Float
    , lon : Float
    , rsvpCount : Int
    , groupName : String
    }


type Msg
    = UpdatePostcode String
    | SetDate String
    | GetSearchResults
    | SearchResults (Result Http.Error (List SearchResult))
    | GetLocation
    | Location (Result Geolocation.Error Geolocation.Location)
