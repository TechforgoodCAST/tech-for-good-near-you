module Views.Categories exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


categories : Model -> Html Msg
categories model =
    div [ class "white mt4" ] (List.map category [ "business", "science & tech", "music" ])


category : String -> Html Msg
category catText =
    div [] [ p [] [ text catText ] ]
