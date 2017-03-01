module Main exposing (..)

import Html exposing (program)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Data.Categories exposing (..)


main : Program Never Model Msg
main =
    program
        { update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        , init = init
        }


init : ( Model, Cmd Msg )
init =
    ( Model "" categoriesDict, Cmd.none )
