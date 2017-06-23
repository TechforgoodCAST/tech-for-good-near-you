module Views.Events exposing (..)

import Data.Dates exposing (..)
import Data.Events exposing (..)
import Data.Maps exposing (..)
import Helpers.Html exposing (responsiveImg)
import Helpers.Style exposing (classes, desktopOnly, px)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)
import Views.Dates exposing (dateMainOptions)


events : Model -> Html Msg
events model =
    if List.isEmpty (filterEvents model) && not model.fetchingEvents then
        selectOtherDates model
    else
        let
            mapMargin =
                model.window.height // 2
        in
            div
                [ class <| classes [ "ph4 w-100", desktopOnly ]
                , style [ ( "margin-top", px mapMargin ) ]
                ]
                (List.map event <| filterEvents model)


selectOtherDates : Model -> Html Msg
selectOtherDates model =
    div [ class "green tc fade-in", style [ ( "margin-top", "50vh" ) ] ]
        [ p [ class "fade-in f4 mt5-ns mt4" ] [ text <| noEventsInRangeText model ]
        , p [ class "f6" ] [ text "Choose another date" ]
        , div [ class "center mw5" ] [ dateMainOptions model ]
        ]


noEventsInRangeText : Model -> String
noEventsInRangeText model =
    "No events "
        ++ (model.selectedDate
                |> dateRangeToString
                |> String.toLower
           )


event : Event -> Html Msg
event event =
    div [ class "ph4 mt3 mb4 mw7 center fade-in flex flex-column items-center" ]
        [ a [ href event.url, class "no-underline dark-green hover-gold tc t-3 all ease", target "_blank" ] [ h3 [ class "mt4 mb3" ] [ text event.title ] ]
        , div [ class "flex flex-column flex-row-m items-start w-100" ]
            [ whenDetails event
            , whereDetails event
            , whoDetails event
            ]
        ]


whenDetails : Event -> Html Msg
whenDetails event =
    div [ class "gold w-33-m w-100 flex flex-column justify-center items-center tc" ]
        [ h3 [ class "f6" ] [ text "WHEN?" ]
        , div [ style [ ( "width", "30px" ) ] ] [ responsiveImg "/images/calendar.svg" ]
        , p [ class "f6" ] [ text <| displayDate event.time ]
        ]


whereDetails : Event -> Html Msg
whereDetails event =
    div
        [ class "green w-33-m w-100 flex flex-column justify-center items-center tc pointer"
        , onClick <| CenterEvent (makeMarker event)
        ]
        [ h3 [ class "f6" ] [ text "WHERE?" ]
        , div
            [ style
                [ ( "width", "35px" )
                , ( "height", "33px" )
                ]
            , class "spin"
            ]
            [ responsiveImg "/images/crosshair.svg" ]
        , venueAddress event
        ]


whoDetails : Event -> Html Msg
whoDetails event =
    div [ class <| classes [ "light-red", iconContainerClasses ] ]
        [ h3 [ class "f6" ] [ text "WHO?" ]
        , div [ style [ ( "width", "30px" ) ] ] [ responsiveImg "/images/group.svg" ]
        , p [ class "f6" ] [ text event.groupName ]
        ]


iconContainerClasses : String
iconContainerClasses =
    "w-33-m w-100 flex flex-column justify-center items-center tc"


venueAddress : Event -> Html Msg
venueAddress event =
    if isPrivateEvent event then
        p [ class "orange f6" ] [ text "join the meetup group to see the location" ]
    else
        div [ style [ ( "margin-top", "0.65em" ) ] ]
            [ span [ class "f6" ] [ text <| event.venueName ++ ", " ]
            , br [] []
            , span [ class "f6" ] [ text event.address ]
            ]
