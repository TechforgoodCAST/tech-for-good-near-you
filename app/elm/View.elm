module View exposing (..)

import Model exposing (..)
import Html exposing (..)
import Views.Navbar exposing (navbar)


view : Model -> Html Msg
view model =
    div []
        [ navbar model
        ]
