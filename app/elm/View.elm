module View exposing (..)

import Model exposing (..)
import Html exposing (..)
import Views.Navbar exposing (navbar)
import Views.Search exposing (search)


view : Model -> Html Msg
view model =
    div []
        [ navbar model
        , search model
        ]
