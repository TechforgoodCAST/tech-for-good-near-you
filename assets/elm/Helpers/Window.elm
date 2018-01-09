module Helpers.Window exposing (..)

import Config exposing (mobileNav)
import Data.Events exposing (someEventsRetrieved)
import Dom.Scroll as Scroll
import Helpers.Style exposing (isMobile)
import Task
import Types exposing (..)
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
    Scroll.toTop Config.eventsContainerId
        |> Task.attempt Scroll


scrollEventContainer : Float -> Model -> Cmd Msg
scrollEventContainer offset model =
    Scroll.toY Config.eventsContainerId (calculateEventsOffset offset model)
        |> Task.attempt Scroll


calculateEventsOffset : Float -> Model -> Float
calculateEventsOffset offset model =
    if isMobile model then
        offset - toFloat (model.window.height // 2) - toFloat (mobileNav.bottomHeight // 2)
    else
        offset - toFloat (model.window.height // 2)
