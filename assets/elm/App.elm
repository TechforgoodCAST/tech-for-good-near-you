module App exposing (..)

import Html exposing (program)
import Types exposing (..)
import State exposing (..)
import View exposing (..)


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
