module Helpers.Window exposing (..)

import Data.Events exposing (someEventsRetrieved)
import Dom.Scroll as Scroll
import Helpers.Style exposing (isMobile)
import Model exposing (..)
import Task
import Window


handleScrollEventsToTop : Model -> Cmd Msg
handleScrollEventsToTop model =
    if someEventsRetrieved model then
        scrollEventsToTop model
    else
        Cmd.none


getWindowSize : Cmd Msg
getWindowSize =
    Window.size |> Task.perform WindowSize


scrollEventsToTop : Model -> Cmd Msg
scrollEventsToTop model =
    Scroll.toTop model.eventsContainerId
        |> Task.attempt Scroll


scrollEventContainer : Float -> Model -> Cmd Msg
scrollEventContainer offset model =
    Scroll.toY model.eventsContainerId (calculateEventsOffset offset model)
        |> Task.attempt Scroll


calculateEventsOffset : Float -> Model -> Float
calculateEventsOffset offset model =
    if isMobile model then
        offset - toFloat (model.window.height // 2) - toFloat (model.mobileNav.bottomHeight // 2)
    else
        offset - toFloat (model.window.height // 2)
