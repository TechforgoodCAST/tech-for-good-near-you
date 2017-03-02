module Views.Search exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


search : Model -> Html Msg
search model =
    div [ class "dib" ]
        [ h2 [ class "green" ] [ text "Tech for good events near you" ]
        , locationSearch model
        , dateSearch model
        , button [ onClick GetSearchResults ] [ text "Search" ]
        ]


locationSearch : Model -> Html Msg
locationSearch model =
    div [ class "flex" ]
        [ h3 [ class "green" ] [ text "Where are you based?" ]
        , input [ class "ba b--green", onInput UpdatePostcode ] []
        ]


dateSearch : Model -> Html Msg
dateSearch model =
    div []
        [ h3 [ class "green" ] [ text "See events from " ]
        , button [] [ text "Today" ]
        , button [] [ text "This week" ]
        , button [] [ text "This month" ]
        ]
