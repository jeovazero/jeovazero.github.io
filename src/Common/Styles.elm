module Common.Styles exposing (absoluteContainer, bgBlack, centerContentContainer, centerContentFlex, centerItemsFlex, contentContainer, fullContainer, homeContentStyle, mediaHome, myLogoStyle, mybgStyle, noVisible, noneCss, polygonAnim, sectionLink, sectionLinkWrapperStyle, svgStyle, textLeft, theme, titleSection, titleWrapper, underlineEl, verticalFlex)

import Css exposing (..)
import Css.Animations as CA
import Css.Media exposing (maxWidth, only, screen, withMedia)
import Html.Styled exposing (Html, a, div, h1, i, img, styled, text)
import Html.Styled.Attributes exposing (alt, class, css, href, src)
import Svg.Styled exposing (animateTransform, polygon, rect, svg)
import Svg.Styled.Attributes as SS


theme =
    { primary = hex "000000"
    , secondary = hex "ffffff"
    }


fullContainer =
    batch
        [ color theme.secondary
        , fontFamilies [ "Patua One", "sans-serif" ]
        , height (vh 100)
        , width (pct 100)
        ]


bgBlack =
    batch
        [ backgroundColor theme.primary ]


absoluteContainer =
    batch
        [ position absolute
        , top (px 0)
        , left (px 0)
        , width (pct 100)
        ]


sectionLink =
    batch
        [ color (hex "ffffff")
        , textDecoration none
        , fontFamilies [ "Nova Square", "sans-serif" ]
        , fontSize (rem 1.5)
        , borderColor (hex "ffffff")
        , borderWidth (px 1)
        , borderBottomStyle solid
        , paddingBottom (px 4)
        ]


centerContentFlex =
    batch
        [ displayFlex
        , justifyContent center
        ]


centerItemsFlex =
    batch
        [ alignItems center
        ]


verticalFlex =
    batch
        [ displayFlex
        , flexDirection column
        ]


mediaHome =
    batch
        [ withMedia [ only screen [ maxWidth (px 400) ] ]
            [ width (pct 100) ]
        ]


sectionLinkWrapperStyle =
    batch
        [ margin2 (rem 0.75) (px 0)
        , padding2 (rem 0.25) (rem 0)
        ]


myLogoStyle =
    batch
        [ withMedia [ only screen [ maxWidth (px 400) ] ]
            [ width (px 200) ]
        , width (px 320)
        ]


svgStyle =
    batch
        [ zIndex (int 1)
        , position absolute
        , top (px 0)
        , left (px 0)
        , height (vh 100)
        , width (pct 100)
        ]


polygonAnim =
    batch
        [ animationName
            (CA.keyframes
                [ ( 0
                  , [ CA.property "stroke-width" "1"
                    , CA.transform [ scale 0.1 ]
                    , CA.property "stroke" "#aaaaaa"
                    ]
                  )
                , ( 33
                  , [ CA.property "stroke-width" "3"
                    , CA.transform [ rotate (deg 90), scale 1 ]
                    , CA.property "stroke" "#555555"
                    ]
                  )
                , ( 66
                  , [ CA.property "stroke-width" "6"
                    , CA.transform [ rotate (deg 180), scale 1.2 ]
                    ]
                  )
                , ( 100
                  , [ CA.property "stroke-width" "1"
                    , CA.property "stroke" "#111111"
                    , CA.transform [ rotate (deg 270), scale 0.5 ]
                    ]
                  )
                ]
            )
        , transform (translateZ (px 0))
        , property "animation-iteration-count" "infinite"
        , property "transform-origin" "50% 50%"
        ]


mybgStyle =
    batch
        [ position absolute
        , zIndex (int 0)
        , right (px 10)
        , bottom (px 10)
        , opacity (num 0.5)
        ]


homeContentStyle =
    batch
        [ verticalFlex
        , mediaHome
        , centerItemsFlex
        , zIndex (int 2)
        ]


contentContainer =
    batch
        [ width (px 480)
        , padding (rem 2)
        ]


textLeft =
    batch [ textAlign left ]


noVisible =
    batch [ display none ]


noneCss =
    batch []


centerContentContainer listEl =
    div [ css [ centerContentFlex, color (hex "fff") ] ]
        listEl


titleSection =
    styled h1
        [ margin (px 0)
        , padding2 (rem 2) (rem 0)
        , fontFamilies [ "Nova Square", "sans-serif" ]
        , display inlineBlock
        , fontWeight normal
        ]


titleWrapper =
    styled div
        [ displayFlex
        , justifyContent spaceBetween
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
