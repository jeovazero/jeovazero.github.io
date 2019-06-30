module Footer exposing (view)

import Common.Elements exposing (centerContentContainer, contentContainer)
import Common.Styles
    exposing
        ( bgBlack
        , myFontFamily
        , textLeft
        )
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, id, src, style, target)


textWrapper t =
    p
        [ css
            [ myFontFamily.ropaSans
            , fontSize (rem 1.2)
            , lineHeight (rem 1.8)
            , letterSpacing (px 1)
            , textAlign center
            ]
        ]
        [ text t ]


repoLink =
    a
        [ href "https://github.com/jeovazero/jeovazero.github.io"
        , css [ color (hex "fff") ]
        , target "_blank"
        ]
        [ textWrapper "veja o código" ]



-- VIEW


view =
    footer [ css [ bgBlack, textLeft ] ]
        [ centerContentContainer []
            [ contentContainer
                [ css [ padding (rem 1) ] ]
                [ textWrapper "Feito com Elm Lang 💜 "
                , repoLink
                , textWrapper "por @jeovazero"
                ]
            ]
        ]
