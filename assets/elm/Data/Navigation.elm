module Data.Navigation exposing (..)

import Helpers.Style exposing (isMobile)
import Types exposing (..)


handleResetMobileNav : Model -> Model
handleResetMobileNav model =
    { model
        | bottomNavOpen = False
        , mobileDateOptionsVisible = False
    }


handleToggleTopNavbar : Model -> Model
handleToggleTopNavbar model =
    if isMobile model then
        { model | topNavOpen = not model.topNavOpen }
    else
        model
