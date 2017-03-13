module Test.Location.Radius exposing (..)
import 

suite : Test
suite =
  test "test" <|
    \_ -> Expect.equal 1 1






-- suite : Test
-- suite =
--     describe "The String module"
--         [ describe "String.reverse" -- Nest as many descriptions as you like.
--             [ test "has no effect on a palindrome" <|
--                 \() ->
--                     let
--                         palindrome =
--                             "hannah"
--                     in
--                         Expect.equal palindrome (String.reverse palindrome)
--
--             -- Expect.equal is designed to be used in pipeline style, like this.
--             , test "reverses a known string" <|
--                 \() ->
--                     "ABCDEFG"
--                         |> String.reverse
--                         |> Expect.equal "GFEDCBA"
--
--             -- fuzz runs the test 100 times with randomly-generated inputs!
--             , fuzz string "restores the original string if you run it again" <|
--                 \randomlyGeneratedString ->
--                     randomlyGeneratedString
--                         |> String.reverse
--                         |> String.reverse
--                         |> Expect.equal randomlyGeneratedString
--             ]
--         ]
