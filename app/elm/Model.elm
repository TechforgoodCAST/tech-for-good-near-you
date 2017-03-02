module Model exposing (..)

import Http
import Dict exposing (Dict)


type alias Model =
    { postcode : String
    , categories : Categories
    , date : String
    , events : List SearchResult
    }


type alias Categories =
    Dict Int ( String, Bool )


type alias SearchResult =
    { name : String
    , description : String
    , url : String
    , imgUrl : String
    , date : String
    , categoryId : String
    , lat : String
    , lng : String
    }


type Msg
    = UpdatePostcode String
    | ToggleCategory Int
    | SetDate String
    | GetSearchResults
    | SearchResults (Result Http.Error (List SearchResult))
