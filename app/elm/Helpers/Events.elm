module Helpers.Events exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json


onEnter : msg -> Attribute msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail ""
    in
        on "keydown" (Json.andThen isEnter keyCode)
