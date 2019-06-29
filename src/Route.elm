module Route exposing (Route(..), routeParser, urlToRoute)

import Url
import Url.Parser exposing ((</>), Parser, fragment, map, oneOf, parse, s, string, top)


type Route
    = Blog
    | Init (Maybe String)
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Init (fragment identity)
        , map Blog (s "blog" </> top)
        ]


urlToRoute : Url.Url -> Route
urlToRoute url =
    let
        frag =
            Maybe.withDefault "" url.fragment

        url2 =
            { url
                | path =
                    if String.left 1 frag == "/" then
                        String.dropLeft 1 frag

                    else
                        ""
            }
    in
    Maybe.withDefault NotFound (parse routeParser url2)
