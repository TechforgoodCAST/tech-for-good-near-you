module Main exposing (..)

import Html exposing (program)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Data.Request exposing (..)
import Data.Dates exposing (..)


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getCurrentDate )


initialModel : Model
initialModel =
    { postcode = ""
    , selectedDate = ""
    , events = []
    , userLocation = Nothing
    , currentDate = Nothing
    }
