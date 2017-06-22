module Helpers.Html exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


responsiveImg : String -> Html msg
responsiveImg imgSrc =
    img [ class "w-100", src imgSrc ] []
