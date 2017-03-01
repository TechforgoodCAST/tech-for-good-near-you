module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    {}


type Msg
    = NoOp


update msg model =
    case msg of
        NoOp ->
            model


main =
    div [ class "bg-blue" ] [ text "wooo" ]
