module Helpers.Html exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Encode exposing (string)


responsiveImg : String -> Html msg
responsiveImg imgSrc =
    img [ class "w-100", src imgSrc ] []


emptyProperty : Attribute msg
emptyProperty =
    property "" <| string ""
