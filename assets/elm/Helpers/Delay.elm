module Helpers.Delay exposing (..)

import Types exposing (..)
import Delay


googleMapDelay : Msg -> Cmd Msg
googleMapDelay msg =
    Delay.after 50 msg
