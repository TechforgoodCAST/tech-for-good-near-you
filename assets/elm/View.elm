module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import Views.Events exposing (events)
import Views.Layout exposing (layout, loadingScreen)
import Views.Map exposing (renderMap)


view : Model -> Html Msg
view model =
    div []
        [ loadingScreen model
        , renderMap model
        , layout model <| events model
        ]
