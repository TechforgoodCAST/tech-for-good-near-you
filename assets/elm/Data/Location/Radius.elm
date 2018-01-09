module Data.Location.Radius exposing (..)

import Types exposing (..)


filterByDistance : Int -> List Event -> List Event
filterByDistance searchRadius =
    List.filter (filterEventByDistance searchRadius)


filterEventByDistance : Int -> Event -> Bool
filterEventByDistance searchRadius event =
    event.distance <= searchRadius


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


degreesToRadians : Float -> Float
degreesToRadians deg =
    deg * (pi / 180)
