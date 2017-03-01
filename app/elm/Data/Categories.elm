module Data.Categories exposing (..)

import Model exposing (..)
import Dict


categoriesDict : Categories
categoriesDict =
    Dict.fromList
        [ ( 111, ( "Charity & Causes", False ) )
        , ( 103, ( "Music", False ) )
        , ( 107, ( "Health & Wellness", False ) )
        , ( 102, ( "Science & Tech", False ) )
        , ( 101, ( "Business", False ) )
        , ( 119, ( "Hobbies", False ) )
        ]


toggleCategory : Int -> Categories -> Categories
toggleCategory catId categories =
    categories
        |> Dict.update catId updateCategoryValue


updateCategoryValue : Maybe ( String, Bool ) -> Maybe ( String, Bool )
updateCategoryValue categoryValue =
    categoryValue
        |> Maybe.map (\( catName, selected ) -> ( catName, not selected ))
