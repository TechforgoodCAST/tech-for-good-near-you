module Helpers.Style exposing (..)

import Model exposing (..)


classes : List String -> String
classes =
    String.join " "


toggleNavClasses : Model -> List ( String, Bool )
toggleNavClasses model =
    [ ( "trans-y--350 trans-y-0-ns", not model.navbarOpen )
    , ( "trans-y-0", model.navbarOpen )
    ]


showAtResults : Model -> ( String, Bool )
showAtResults model =
    ( "o-0", model.view /= Results )
