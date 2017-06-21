module Helpers.Style exposing (..)

import Model exposing (..)


classes : List String -> String
classes =
    String.join " "


mobileOnly : String
mobileOnly =
    "db dn-ns"


desktopOnly : String
desktopOnly =
    "dn db-ns"


showAtResults : Model -> ( String, Bool )
showAtResults model =
    ( "no-select o-0", model.view /= Results )
