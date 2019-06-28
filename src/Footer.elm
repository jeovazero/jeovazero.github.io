module Footer exposing (view)

import Common.Styles
    exposing
        ( bgBlack
        , centerContentContainer
        , centerContentFlex
        , contentContainer
        , sectionLink
        , sectionLinkWrapperStyle
        , textLeft
        , theme
        , titleSection
        , titleWrapper
        , underlineEl
        )
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, id, src, style)


textWrapper t =
    p
        [ css
            [ fontFamilies [ "Ropa Sans", "Verdana", "sans serif" ]
            , fontSize (rem 1.2)
            , lineHeight (rem 1.8)
            , letterSpacing (px 1)
            , textAlign center
            ]
        ]
        [ text t ]


view =
    footer [ css [ bgBlack, textLeft ] ]
        [ centerContentContainer
            [ div [ css [ contentContainer, padding (rem 1) ] ]
                [ textWrapper "Feito com Elm Lang 💜 "
                , textWrapper "por @jeovazero"
                ]
            ]
        ]
