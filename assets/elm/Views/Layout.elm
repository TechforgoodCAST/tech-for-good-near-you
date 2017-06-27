module Views.Layout exposing (..)

import Helpers.Style exposing (ifMobile, isMobile, mobileFullHeight, mobileMaxHeight, percentScreenHeight)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Views.Navigation exposing (bottomNav, topNav)


layout : Model -> Html Msg -> Html Msg
layout model content =
    div [ class "flex-ns" ]
        [ topNav model
        , div
            [ class "w-100 ml6-ns pl4-ns flex items-center justify-center"
            , style [ handleMobileHeight model ]
            ]
            [ mobileContainer model content
            ]
        , bottomNav model
        ]


handleMobileHeight : Model -> Style
handleMobileHeight model =
    (if model.view == Results then
        mobileFullHeight model
     else
        mobileMaxHeight model
    )
        |> ifMobile model


mobileContainer : Model -> Html Msg -> Html Msg
mobileContainer model content =
    if isMobile model && model.view == Results then
        div [ style [ percentScreenHeight 100 model ] ] [ content ]
    else if isMobile model then
        div [ style [ percentScreenHeight 85 model ] ] [ content ]
    else
        content
