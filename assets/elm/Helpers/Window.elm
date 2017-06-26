module Helpers.Window exposing (..)

import Dom.Scroll exposing (toTop, toY)
import Helpers.Style exposing (isMobile)
import Model exposing (..)
import Task
import Window exposing (size)


handleScrollEventsToTop : Model -> Cmd Msg
handleScrollEventsToTop model =
    if List.length model.events > 0 then
        scrollEventsToTop model
    else
        Cmd.none


getWindowSize : Cmd Msg
getWindowSize =
    size |> Task.perform WindowSize


scrollEventsToTop : Model -> Cmd Msg
scrollEventsToTop model =
    toTop model.eventsContainerId
        |> Task.attempt Scroll


scrollEventContainer : Float -> Model -> Cmd Msg
scrollEventContainer offset model =
    toY model.eventsContainerId (calculateOffset offset model)
        |> Task.attempt Scroll


calculateOffset : Float -> Model -> Float
calculateOffset offset model =
    if isMobile model then
        offset - toFloat (model.window.height // 2) - toFloat (model.mobileNav.bottomHeight // 2)
    else
        offset - toFloat (model.window.height // 2)
