module Model exposing (..)

import Http


type alias Model =
    { postcode : String
    , date : String
    , events : List SearchResult
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
