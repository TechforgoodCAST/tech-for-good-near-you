module Views.Search exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)
import Data.Dates exposing (..)


search : Model -> Html Msg
search model =
    div [ class "dib" ]
        [ h2 [ class "green" ] [ text "Tech for good events near you" ]
        , locationSearch model
        , dateSearch model
        , div [ class "bg-green white pa2 ma2 pointer", onClick GetEvents ] [ text "Search" ]
        ]


locationSearch : Model -> Html Msg
locationSearch model =
    div [ class "flex" ]
        [ h3 [ class "green" ] [ text "Where are you based?" ]
        , input [ class "ba b--green", onInput SetPostcode ] []
        ]


dateSearch : Model -> Html Msg
dateSearch model =
    div []
        ([ h3 [ class "green" ] [ text "See events from " ] ] ++ (List.map (dateButton model) datesList))


dateButton : Model -> String -> Html Msg
dateButton model date =
    div
        [ class "white pa2 ma2 pointer"
        , classList [ ( "bg-yellow", Just date == model.selectedDate ), ( "bg-blue", Just date /= model.selectedDate ) ]
        , onClick (SetDate date)
        ]
        [ text date ]
