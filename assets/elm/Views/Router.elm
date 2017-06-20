module Views.Router exposing (..)

import Model exposing (..)
import Html exposing (..)
import Views.Location exposing (location)
import Views.Dates exposing (dates)
import Views.Events exposing (events)


router : Model -> Html Msg
router model =
    case model.view of
        MyLocation ->
            location model

        MyDates ->
            dates model

        Results ->
            events model
