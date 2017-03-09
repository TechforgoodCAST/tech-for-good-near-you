port module Main exposing (..)

import Html exposing (program)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Data.Dates exposing (..)
import Data.Maps exposing (..)


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
    ( initialModel, Cmd.batch commands )


commands : List (Cmd Msg)
commands =
    [ getCurrentDate, initMap (Marker "1" "hello" 51.5062 0.1164) ]


initialModel : Model
initialModel =
    { postcode = ""
    , selectedDate = ""
    , events = []
    , userLocation = Nothing
    , currentDate = Nothing
    }
