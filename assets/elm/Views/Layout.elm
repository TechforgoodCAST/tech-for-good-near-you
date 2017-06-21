module Views.Layout exposing (..)

import Helpers.Style exposing (ifMobile, mobileFullHeight, percentScreenHeight)
import Html exposing (..)
import Html.Attributes exposing (..)
import Views.Navigation exposing (bottomNav, topNav)
import Model exposing (..)


layout : Model -> Html Msg -> Html Msg
layout model content =
    div [ class "flex-ns" ]
        [ topNav model
        , div
            [ class "w-100 ml6-ns pl4-ns flex items-center justify-center"
            , style [ mobileFullHeight model ]
            ]
            [ mobileContainer model content
            ]
        , bottomNav model
        ]


mobileContainer : Model -> Html Msg -> Html Msg
mobileContainer model content =
    div
        [ style [ percentScreenHeight 80 model |> ifMobile model ]
        ]
        [ content ]
