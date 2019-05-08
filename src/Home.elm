module Home exposing (homeView, statusListLength)
-- import Html.Attributes exposing (class, style)
import Basics exposing (..)
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src, class, style)



-- HOME
container =
    styled div
        [ width (px 600)
        , margin auto
        , fontSize (rem 1.5)
        ]

logo =
    styled img
        [ width (pct 100)
        ]

homeView model =
    let
        translateX = model.translateX |> toStrTx
        opacity = model.opacity
        current = model.curFrame
    in
    div [ class "wrapper" ]
        [ container [ ]
              [ logo [ src "./assets/logo.png" ] []
              , div [ class "desc"]
                    [ text "Desenvolvedor JavaScript"
                    , br [] []
                    , text "Back-end/Front-end"
                    ]
              , div [ class "bio" ] [ text "Bio" ]
              , contactsView
              , buttonsView
              ]
        , div [ class "status" ]
              [ carousel current translateX opacity ]
        ]


buttonsView =
    div [ class "buttons" ]
        [ a [ class "button", href "#about"] [ text "# Sobre" ]
        , a [ class "button", href "#projects"] [ text "# Projetos" ]
        ]

brandIcon : String -> String -> Html msg
brandIcon name link =
    a [ href link ]
      [ i [ class (String.concat ["fab ", name]) ] []
      ]


contactsView : Html msg
contactsView =
    div [ class "contacts" ]
        [ brandIcon "fa-telegram" "https://t.me/jeotario"
        , brandIcon "fa-github" "https://github.com/jeovazero"
        , brandIcon "fa-twitter" "https://twitter.com/jeovazero"
        , brandIcon "fa-linkedin" "https://linkedin.com/in/jeovazero"
        ]


statusList =
    [ "Try hard \u{1F44A}"
    , "Em construção com ELM \u{1F6A7}"
    , "Será que faço um blog? \u{1F4DD}"
    , "Elm é Haskell-like"
    , "Gosto de Haskell"
    , "Primeiro eu faço, depois aprimoro"
    , "Se eu não sei, vou pesquisar \u{1F624} "
    , "Ocaml não é funcional pura \u{1F42B}"
    , "Elm é funcional pura \u{1F49C}"
    , "Haskell é funcional pura \u{1F49C}"
    ]

statusListLength = List.length statusList

suffixStatusList list = list ++ [ List.head list |> Maybe.withDefault "" ]


statusListHtml current opacity =
    suffixStatusList
        statusList
            |> List.indexedMap
                (\i x -> div [ style "opacity" (if i == current then (String.fromFloat opacity) else "1") ] [ text x ] )


toStrTx : Float -> String
toStrTx i = (i |> String.fromFloat ) ++ "px"


carousel current tx opacity =
    div [ class "carousel"
        , style "transform" ("translate3d(" ++ tx ++ ", 0px, 0px)")
        ]
        (statusListHtml current opacity)

