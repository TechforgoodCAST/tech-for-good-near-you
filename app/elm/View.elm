module View exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Views.Navbar exposing (navbar)
import Views.Router exposing (router)
import Helpers.Style exposing (toggleNavClasses)


view : Model -> Html Msg
view model =
    div [ class "flex-ns" ]
        [ navbar model
        , div [ class "w-100 ml6-ns pl4-ns t-5 all ease", classList <| toggleNavClasses model ]
            [ div [ class "flex justify-center" ] [ router model ]
            ]
        ]
