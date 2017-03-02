module Views.Categories exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Dict


categories : Model -> Html Msg
categories model =
    div [ class "white mt4" ] (renderCategories model.categories)


renderCategories : Categories -> List (Html Msg)
renderCategories categories =
    categories
        |> Dict.toList
        |> List.map renderCategory


renderCategory : ( Int, ( String, Bool ) ) -> Html Msg
renderCategory ( catId, ( catName, selected ) ) =
    div
        [ onClick (ToggleCategory catId), class "pointer pa3 mt1 t-3 all ease", classList [ ( "bg-white green", selected ) ] ]
        [ p [ class "ma0 f6" ] [ text catName ] ]
