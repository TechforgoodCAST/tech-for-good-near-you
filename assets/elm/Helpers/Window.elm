module Helpers.Window exposing (..)

import Dom.Scroll exposing (toY)
import Model exposing (..)
import Task
import Window exposing (size)


getWindowSize : Cmd Msg
getWindowSize =
    size |> Task.perform WindowSize


scrollEventContainer : Float -> Model -> Cmd Msg
scrollEventContainer offset model =
    toY model.eventsContainerId (calculateOffset offset model)
        |> Task.attempt Scroll


calculateOffset : Float -> Model -> Float
calculateOffset offset model =
    offset - toFloat (model.window.height // 2)
