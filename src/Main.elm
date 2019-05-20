import Browser
import Html.Styled exposing (toUnstyled)
import Home
import Css exposing (margin, px, padding)
import Css.Global exposing (global, body)


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            ]
        ]


-- MAIN

main =
  Browser.document
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view =
        \model ->
            { title = "jeovazero"
            , body = List.map toUnstyled (view model)
            }
    }


type alias Model = ()


init : () -> (Model, Cmd msg)
init _ =
    ((), Cmd.none)


subscriptions model = Sub.none


update msg model = ((), Cmd.none)


view model =
    [ globalCss
    ,  Home.view
    ]
