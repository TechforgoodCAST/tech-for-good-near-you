module Helpers.Delay exposing (..)

import Model exposing (..)
import Process
import Time
import Task exposing (Task)


delay : Float -> Msg -> Cmd Msg
delay ms msg =
    Process.sleep (Time.millisecond * ms)
        |> Task.andThen (always (Task.succeed msg))
        |> Task.perform identity
