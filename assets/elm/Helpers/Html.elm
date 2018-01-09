module Helpers.Html exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Encode exposing (string)
import Json.Decode as Decode
import Html.Events exposing (on, keyCode)


responsiveImg : String -> Html msg
responsiveImg imgSrc =
    img [ class "w-100", src imgSrc ] []


emptyProperty : Attribute msg
emptyProperty =
    property "" <| string ""


onEnter : msg -> Attribute msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Decode.succeed msg
            else
                Decode.fail ""
    in
        on "keydown" (Decode.andThen isEnter keyCode)
