module Helpers.Style exposing (..)

import Model exposing (..)


toggleNavClasses : Model -> List ( String, Bool )
toggleNavClasses model =
    [ ( "trans-y--320 trans-y-0-ns", not model.navbarOpen ), ( "trans-y-0", model.navbarOpen ) ]


showAtResults : Model -> ( String, Bool )
showAtResults model =
    ( "o-0", model.view /= Results )
