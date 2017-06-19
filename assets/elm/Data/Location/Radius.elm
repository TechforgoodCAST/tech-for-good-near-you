module Data.Location.Radius exposing (..)

import Model exposing (..)


degreesToRadians : Float -> Float
degreesToRadians deg =
    deg * (pi / 180)


latLngToMiles : Coords -> Coords -> Int
latLngToMiles c1 c2 =
    let
        r =
            3959

        distanceLat =
            degreesToRadians (c2.lat - c1.lat)

        distanceLng =
            degreesToRadians (c2.lng - c1.lng)

        a =
            ((sin (distanceLat / 2)) ^ 2)
                + cos (degreesToRadians c1.lat)
                * cos (degreesToRadians c2.lat)
                * ((sin (distanceLng / 2)) ^ 2)

        c =
            2 * atan2 (sqrt a) (sqrt (1 - a))
    in
        round (r * c)


filterByDistance : Model -> List Event -> List Event
filterByDistance model =
    List.filter (filterEventByDistance model.searchRadius)


filterEventByDistance : Int -> Event -> Bool
filterEventByDistance searchRadius event =
    event.distance <= searchRadius
