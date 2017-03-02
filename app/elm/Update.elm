module Update exposing (..)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)
import Data.Categories exposing (toggleCategory)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePostcode postcode ->
            { model | postcode = postcode } ! []

        ToggleCategory catId ->
            { model | categories = toggleCategory catId model.categories } ! []

        SetDate date ->
            { model | date = date } ! []

        GetSearchResults ->
            model ! [ decodeResults ]

        SearchResults (Ok results) ->
            { model | events = results } ! []

        SearchResults (Err err) ->
            let
                log =
                    Debug.log "Request Error" err
            in
                model ! []


decodeResults : Cmd Msg
decodeResults =
    Http.send SearchResults (Http.get "/events" (list decodeEvent))


decodeEvent : Decoder SearchResult
decodeEvent =
    decode SearchResult
        |> requiredAt [ "name", "text" ] string
        |> requiredAt [ "description", "text" ] string
        |> required "url" string
        |> optionalAt [ "logo", "url" ] string defaultImgUrl
        |> requiredAt [ "start", "local" ] string
        |> optional "category_id" string "999"
        |> optionalAt [ "venue", "latitude" ] string "51.01"
        |> optionalAt [ "venue", "longitude" ] string "0.11"


defaultImgUrl : String
defaultImgUrl =
    "https://benrmatthews.com/wp-content/uploads/2015/05/tech-for-good.jpg"
