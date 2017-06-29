module Views.Events exposing (..)

import Data.Dates exposing (..)
import Data.Events exposing (..)
import Data.Maps exposing (..)
import Helpers.Html exposing (responsiveImg)
import Helpers.Style exposing (classes, desktopOnly, isMobile, mobileFullHeight, px, translateY)
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
        div
            [ class <| classes [ "ph4-ns w-100 overflow-y-scroll" ]
            , style
                [ ( "transform", translateY <| mapMargin model )
                , ( "padding-bottom", px 120 )
                , ( "height", px <| mapMargin model )
                ]
            , id model.eventsContainerId
            ]
            (List.map event <| filterEvents model)


mapMargin : Model -> Int
mapMargin ({ mobileNav, window } as model) =
    if isMobile model then
        ((window.height - mobileNav.topHeight - mobileNav.bottomHeight) // 2) + mobileNav.bottomHeight
    else
        window.height // 2


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
    div
        [ class "ph3 ph4-ns mt3 mb4 mw7 center fade-in flex flex-column items-center"
        , id event.url
        ]
        [ a [ href event.url, class "no-underline dark-green hover-gold tc t-3 all ease", target "_blank" ] [ h3 [ class "mt4 mb3" ] [ text event.title ] ]
        , div [ class "flex flex-row items-start w-100" ]
            [ whenDetails event
            , whereDetails event
            , whoDetails event
            ]
        ]


whenDetails : Event -> Html Msg
whenDetails event =
    div [ class <| classes [ "gold", iconContainerClasses ] ]
        [ h3 [ class "f6" ] [ text "WHEN?" ]
        , div [ style [ ( "width", "30px" ) ] ] [ responsiveImg "/images/calendar.svg" ]
        , p [ class "f6" ] [ text <| displayDate event.time ]
        ]


whereDetails : Event -> Html Msg
whereDetails event =
    div
        [ class <| classes [ "green pointer", iconContainerClasses ]
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
    "w-33 flex flex-column justify-center items-center ph2 ph0-ns tc"


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
