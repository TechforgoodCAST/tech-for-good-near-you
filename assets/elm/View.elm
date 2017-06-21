module View exposing (..)

import Html exposing (..)
import Model exposing (..)
import Views.Layout exposing (layout)
import Views.Map exposing (renderMap)
import Views.Router exposing (router)


view : Model -> Html Msg
view model =
    div []
        [ renderMap model
        , layout model <| router model
        ]
