module View exposing (..)

import Helpers.Style exposing (toggleNavClasses)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Views.Map exposing (renderMap)
import Views.Navbar exposing (navbar)
import Views.Router exposing (router)


view : Model -> Html Msg
view model =
    div []
        [ renderMap model
        , div [ class "flex-ns vh-100" ]
            [ navbar model
            , div [ class "w-100 ml6-ns pl4-ns t-5 all ease", classList <| toggleNavClasses model ]
                [ div [ class "flex justify-center" ] [ router model ]
                ]
            ]
        ]
