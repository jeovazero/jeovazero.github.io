module Main exposing (..)
import Browser
import Html.Styled exposing (toUnstyled)
import Home
import Projects
import Projects exposing (Msg(..))
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
            , body = List.map toUnstyled view
            }
    }


type alias Model =
    { isProject : Bool
    }




init : () -> (Model, Cmd Msg)
init _ =
    (Model False, Cmd.none)


subscriptions model = Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Toggle -> ({model|isProject = not model.isProject}, Cmd.none)


view  =
    [ globalCss
    , Home.view
    , Projects.view
    ]
