module Config exposing (..)


mapId : String
mapId =
    "t4g-google-map"


eventsContainerId : String
eventsContainerId =
    "events-container"


searchRadius : Int
searchRadius =
    400


mobileNav : { topHeight : Int, bottomHeight : Int }
mobileNav =
    { topHeight = 60, bottomHeight = 50 }
