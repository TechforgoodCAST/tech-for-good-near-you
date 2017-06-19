module Data.Results exposing (..)

import Data.Location.Geo exposing (setUserLocation)
import Model exposing (..)
import Request.Events exposing (getEvents)


handleSearchResults : Model -> ( Model, Cmd Msg )
handleSearchResults model =
    { model
        | view = Results
        , fetchingEvents = True
        , mapVisible = True
    }
        ! [ getEvents, setUserLocation model.userLocation ]


handleSearchRadius : String -> Model -> Model
handleSearchRadius radius model =
    setSearchRadius radius model


setSearchRadius : String -> Model -> Model
setSearchRadius radius model =
    let
        newRadius =
            radius
                |> String.toInt
                |> Result.withDefault 300
    in
        { model | searchRadius = newRadius }
