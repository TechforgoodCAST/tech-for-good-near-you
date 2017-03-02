module Main exposing (..)

import Html exposing (program)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Data.Categories exposing (..)


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
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { postcode = ""
    , categories = allCategories
    , date = ""
    , events = []
    }
