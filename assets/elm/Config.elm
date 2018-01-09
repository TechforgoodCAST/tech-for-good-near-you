module Config exposing (..)


mapId : String
mapId =
    "t4g-google-map"


eventsContainerId : String
eventsContainerId =
    "events-container"


mobileNav : { topHeight : Int, bottomHeight : Int }
mobileNav =
    { topHeight = 60, bottomHeight = 50 }


searchRadii : { national : Int, local : Int }
searchRadii =
    { national = 400, local = 50 }
