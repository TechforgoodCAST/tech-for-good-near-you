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


anchorBottom : String
anchorBottom =
    "absolute bottom-0 left-0"


px : number -> String
px n =
    (toString n) ++ "px"


deg : number -> String
deg n =
    (toString n) ++ "deg"


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
mobileMaxHeight ({ window, mobileNav } as model) =
    ( "height", px <| window.height - mobileNav.topHeight )
        |> ifMobile model


mobileFullHeight : Model -> Style
mobileFullHeight ({ window, mobileNav } as model) =
    ( "height", px <| window.height - mobileNav.topHeight - mobileNav.bottomHeight )
        |> ifMobile model


showAtResults : Model -> ( String, Bool )
showAtResults =
    showAt [ Results ]


showAt : List View -> Model -> ( String, Bool )
showAt views model =
    ( "no-select o-0", not <| isVisible model views )


isVisible : Model -> List View -> Bool
isVisible model =
    List.foldr (isCurrentView model) False


isCurrentView : Model -> View -> Bool -> Bool
isCurrentView model view acc =
    model.view == view || acc


emptyStyle : Style
emptyStyle =
    ( "", "" )
