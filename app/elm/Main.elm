module Main exposing (..)

import Html exposing (program)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Data.Dates exposing (..)


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


init : ( Model, Cmd Msg )
init =
    initialModel ! commands


commands : List (Cmd Msg)
commands =
    [ getCurrentDate ]


initialModel : Model
initialModel =
    { postcode = Valid "W1T 4JE"
    , selectedDate = ""
    , events = []
    , userLocation = Nothing
    , currentDate = Nothing
    , mapVisible = False
    }
