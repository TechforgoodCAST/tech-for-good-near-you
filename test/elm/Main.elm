port module Main exposing (..)

import Radius
import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)


main : TestProgram
main =
    run emit Radius.suite


port emit : ( String, Value ) -> Cmd msg
