module Data.Location.Radius exposing (..)


degreesToRadians : Float -> Float
degreesToRadians deg =
    deg * (pi / 180)


getDistanceFromLatLngInMiles : Float -> Float -> Float -> Float -> Float
getDistanceFromLatLngInMiles lat1 lng1 lat2 lng2 =
    let
        r =
            3959

        distanceLat =
            degreesToRadians (lat2 - lat1)

        distanceLng =
            degreesToRadians (lng2 - lng1)

        a =
            ((sin (distanceLat / 2)) ^ 2)
                + cos (degreesToRadians lat1)
                * cos (degreesToRadians lat2)
                * ((sin (distanceLng / 2)) ^ 2)

        c =
            2 * atan2 (sqrt a) (sqrt (1 - a))
    in
        r * c
