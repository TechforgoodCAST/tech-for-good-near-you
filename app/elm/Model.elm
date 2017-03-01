module Model exposing (..)


type alias Model =
    { postcode : String
    }


type Msg
    = UpdatePostcode String
