import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
  Browser.element
    { init = \() -> ( {}, Cmd.none )
    , update = \msg model -> (model, Cmd.none)
    , subscriptions = \model -> Sub.none
    , view = view
    }

brandIcon : String -> String -> Html msg
brandIcon name link =
    a [ href link ]
      [ i [ class (String.concat ["fab ", name]) ] []
      ]

view model =
    div [ class "wrapper" ]
        [ div [ class "main" ]
              [ img [ src "./assets/logo.png" ] []
              , div [ class "desc"]
                    [ text "Desenvolvedor JavaScript"
                    , br [] []
                    , text "Back-end/Front-end"
                    ]
              , div [ class "bio" ] [ text "Bio" ]
              , div [ class "contacts" ]
                    [ brandIcon "fa-telegram" "https://t.me/jeotario"
                    , brandIcon "fa-github" "https://github.com/jeovazero"
                    , brandIcon "fa-twitter" "https://twitter.com/jeovazero"
                    , brandIcon "fa-linkedin" "https://linkedin.com/in/jeovazero"
                    ]
              ]
        , div [ class "status" ] [ text "Construindo com ELM <3"]
        , footer []
                 [ span [] [ text "Copyright (c) 2019 jeovazero" ] ]
        ]
