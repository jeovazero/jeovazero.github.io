module Common.Styles exposing (absoluteContainer, bgBlack, centerContentContainer, centerContentFlex, centerItemsFlex, contentContainer, eyeAnim, fullContainer, noVisible, noneCss, polygonAnim,  svgStyle, textLeft, theme, titleSection, underlineEl, verticalFlex, myFontFamily)

import Css exposing (..)
import Css.Animations as CA
import Css.Media exposing (maxWidth, only, screen, withMedia)
import Html.Styled exposing (Html, a, div, h1, i, img, styled, text)
import Html.Styled.Attributes exposing (alt, class, css, href, src, id)
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
        , minHeight (vh 100)
        , minWidth (pct 100)
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


novaSquareFont =
    batch [ fontWeight normal, fontFamilies [ "Nova Square", "sans-serif" ] ]


ropaSansFont =
    batch [ fontWeight normal, fontFamilies [ "Ropa Sans", "sans-serif" ] ]


patuaOneFont = 
    batch [ fontWeight normal, fontFamilies [ "Patua One", "sans-serif" ] ]


myFontFamily =
    { novaSquare = novaSquareFont
    , ropaSans = ropaSansFont
    , patuaOne = patuaOneFont
    }


centerContentFlex =
    batch
        [ displayFlex
        , justifyContent center
        ]


centerItemsFlex =
    batch
        [ alignItems center
        , displayFlex
        ]


verticalFlex =
    batch
        [ displayFlex
        , flexDirection column
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


eyeAnim =
    batch
        [ animationName
            (CA.keyframes
                [ ( 0
                  , [ CA.transform [ translateX (px 18) ]
                    ]
                  )
                , ( 22
                  , [ CA.transform [ translateX (px -5) ]
                    ]
                  )
                , ( 33
                  , [ CA.transform [ translateX (px 10), translateY (px 5) ]
                    ]
                  )
                , ( 66
                  , [ CA.transform [ translateX (px -10), translateY (px 10) ]
                    ]
                  )
                , ( 77
                  , [ CA.transform [ translateX (px 0), translateY (px -4) ]
                    ]
                  )
                , ( 100
                  , [ CA.transform [ translateX (px 18), translateY (px 0) ]
                    ]
                  )
                ]
            )
        , transform (translateZ (px 0))
        , property "animation-iteration-count" "infinite"
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
