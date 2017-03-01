module Model exposing (..)

import Dict exposing (Dict)


type alias Model =
    { postcode : String
    , categories : Categories
    }


type alias Categories =
    Dict Int ( String, Bool )


type Msg
    = UpdatePostcode String
    | ToggleCategory Int
