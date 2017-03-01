module Update exposing (..)

import Model exposing (..)
import Data.Categories exposing (toggleCategory)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePostcode postcode ->
            { model | postcode = postcode } ! []

        ToggleCategory catId ->
            { model | categories = toggleCategory catId model.categories } ! []
