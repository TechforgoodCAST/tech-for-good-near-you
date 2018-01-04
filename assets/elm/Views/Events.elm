module Views.Events exposing (..)

import Data.Dates exposing (..)
import Data.Events exposing (..)
import Data.Maps exposing (..)
import Helpers.Html exposing (responsiveImg)
import Helpers.Style exposing (classes, desktopOnly, isMobile, mobileFullHeight, px, showAtResults, translateY)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)
import RemoteData exposing (RemoteData)
import Views.Dates exposing (dateMainOptions)
import Views.Layout exposing (desktopCredit)


events : Model -> Html Msg
events model =
    div
        [ style [ ( "margin-top", px <| mapMargin model ) ]
        , class "w-100 smooth-scroll"
        ]
        [ eventsResultsStates model
        ]


eventsResultsStates : Model -> Html Msg
eventsResultsStates model =
    if bothEventRequestsFailed model then
        eventsError model
    else if numberVisibleEvents model == 0 && not (stillLoading model) then
        selectOtherDates model
    else
        allEvents model


eventsError : Model -> Html msg
eventsError model =
    div [ class "mt4 red tc" ]
        [ p [] [ text "something went wrong fetching the events" ]
        , p [] [ text "try refreshing the page" ]
        ]


selectOtherDates : Model -> Html Msg
selectOtherDates model =
    div [ class <| classes [ "green tc fade-in", desktopOnly ] ]
        [ p [ class "fade-in f4 mt5-ns mt4" ] [ text <| noEventsInDateRange model.selectedDate ]
        , p [ class "f6" ] [ text "Choose another date" ]
        , div [ class "center mw5" ] [ dateMainOptions model ]
        , div [ classList [ showAtResults model ], class "mt5" ] [ desktopCredit ]
        ]


allEvents : Model -> Html Msg
allEvents model =
    div
        [ class <| classes [ "ph4-ns w-100 overflow-y-scroll smooth-scroll" ]
        , style
            [ ( "height", px <| mapMargin model )
            ]
        , id model.eventsContainerId
        ]
        ((renderEvents model) ++ [ allEventsCredit model ])


allEventsCredit : Model -> Html msg
allEventsCredit model =
    div
        [ classList [ showAtResults model ]
        , style [ ( "padding-top", px 120 ) ]
        ]
        [ desktopCredit ]


renderEvents : Model -> List (Html Msg)
renderEvents model =
    model
        |> filterEvents
        |> RemoteData.withDefault []
        |> List.map renderEvent


mapMargin : Model -> Int
mapMargin ({ mobileNav, window } as model) =
    if isMobile model then
        ((window.height - mobileNav.topHeight - mobileNav.bottomHeight) // 2) + mobileNav.bottomHeight
    else
        window.height // 2


renderEvent : Event -> Html Msg
renderEvent event =
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
