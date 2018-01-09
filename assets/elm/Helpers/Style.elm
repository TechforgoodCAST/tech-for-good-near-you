module Helpers.Style exposing (..)

import Config exposing (mobileNav)
import Html exposing (Attribute)
import Html.Attributes exposing (class, style)
import Types exposing (..)


classes : List String -> Attribute msg
classes =
    class << String.join " "


styles : List (List Style) -> Attribute msg
styles =
    style << List.concat


mobileOnly : String
mobileOnly =
    "db dn-ns"


desktopOnly : String
desktopOnly =
    "dn db-ns"


anchorBottom : String
anchorBottom =
    "absolute bottom-0 left-0"


px : number -> String
px n =
    (toString n) ++ "px"


deg : number -> String
deg n =
    (toString n) ++ "deg"


transform : String -> Style
transform x =
    ( "transform", x )


translateY : number -> String
translateY y =
    "translateY(" ++ px y ++ ")"


rotateZ : number -> String
rotateZ angle =
    "rotateZ(" ++ deg angle ++ ")"


ifDesktop : Style -> Model -> Style
ifDesktop style model =
    if isDesktop model then
        style
    else
        emptyStyle


ifMobile : Model -> Style -> Style
ifMobile model style =
    if isMobile model then
        style
    else
        emptyStyle


isDesktop : Model -> Bool
isDesktop model =
    model.window.width >= 480


isMobile : Model -> Bool
isMobile model =
    isDesktop model |> not


hideWhenShortScreen : Model -> String
hideWhenShortScreen model =
    if shortScreen model then
        "dn"
    else
        ""


shortScreen : Model -> Bool
shortScreen model =
    model.window.height < 630


percentScreenHeight : Int -> Model -> Style
percentScreenHeight percent { window } =
    let
        height =
            window.height // 100 * percent
    in
        ( "height", px height )


mobileMaxHeight : Model -> Style
mobileMaxHeight ({ window } as model) =
    ( "height", px <| window.height - mobileNav.topHeight )
        |> ifMobile model


mobileFullHeight : Model -> Style
mobileFullHeight ({ window } as model) =
    ( "height", px <| window.height - mobileNav.topHeight - mobileNav.bottomHeight )
        |> ifMobile model


emptyStyle : Style
emptyStyle =
    ( "", "" )
