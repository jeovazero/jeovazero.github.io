module Common.Elements exposing (titleSection, centerContentContainer, contentContainer, absoluteContainer)


import Common.Styles exposing (centerContentFlex, theme, fullSize)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, h1, i, img, styled, text)
import Html.Styled.Attributes exposing (alt, class, css, href, src, id)



-- CONTAINERS


centerContentContainer =
    styled div
        [ centerContentFlex
        , color (hex "fff")
        ]


contentContainer =
    styled div
        [ width (px 480)
        , padding (rem 2)
        ]


absoluteContainer =
    styled div
        [ position absolute
        , top (px 0)
        , left (px 0)
        , width (pct 100)
        ]



-- TITLE SECTION


titleSection { id_, text_ } =
    div
        [ css
            [ displayFlex
            , justifyContent spaceBetween
            ]
        ]
        [ h1
            [ css
                [ margin (px 0)
                , padding2 (rem 2) (rem 0)
                , fontFamilies [ "Nova Square", "sans-serif" ]
                , display inlineBlock
                , fontWeight normal
                ]
            , id id_
            ]
            [ text text_
            , underlineEl
            ]
        ]


underlineEl =
    div
        [ css
            [ width (pct 100)
            , borderColor (rgb 50 50 50)
            , borderWidth (px 2)
            , borderBottomStyle solid
            , marginTop (rem 0.5)
            ]
        ]
        []
