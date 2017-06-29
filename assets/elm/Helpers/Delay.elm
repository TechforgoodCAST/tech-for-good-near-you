module Helpers.Delay exposing (..)

import Model exposing (..)
import Delay


mapDelay : Msg -> Cmd Msg
mapDelay msg =
    Delay.after 50 msg
