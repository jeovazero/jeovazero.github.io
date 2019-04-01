import Browser
import Html exposing (..)
import Html.Attributes exposing (..)

main =
  Browser.element
    { init = \() -> ( {}, Cmd.none )
    , update = \msg model -> (model, Cmd.none)
    , subscriptions = \model -> Sub.none
    , view = view
    }

view model =
    div [ class "wrapper" ]
        [ div [ class "logo" ]
            [ text "jeovazero",
            text "Desenvolvedor JavaScript"
            ]
        ]
