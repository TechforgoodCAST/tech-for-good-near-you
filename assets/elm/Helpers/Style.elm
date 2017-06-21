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


px : number -> String
px n =
    (toString n) ++ "px"


ifDesktop : Style -> Model -> Style
ifDesktop style model =
    if isDesktop model then
        style
    else
        ( "", "" )


ifMobile : Model -> Style -> Style
ifMobile model style =
    if isMobile model then
        style
    else
        ( "", "" )


isDesktop : Model -> Bool
isDesktop model =
    model.window.width > 480


isMobile : Model -> Bool
isMobile model =
    isDesktop model |> not


percentScreenHeight : Int -> Model -> Style
percentScreenHeight percent { window } =
    let
        height =
            window.height // 100 * percent
    in
        ( "height", px height )


mobileFullHeight : Model -> Style
mobileFullHeight ({ window, mobileNav } as model) =
    ( "height", px (window.height - mobileNav.topHeight - mobileNav.bottomHeight) )
        |> ifMobile model


showAtResults : Model -> ( String, Bool )
showAtResults model =
    ( "no-select o-0", model.view /= Results )
