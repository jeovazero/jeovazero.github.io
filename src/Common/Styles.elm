module Common.Styles exposing (..)
import Css exposing (..)
import Css.Animations as CA
import Css.Media exposing (withMedia, only, screen, maxWidth)
import Html.Styled exposing (div, styled, text, img, a, i, Html)
import Html.Styled.Attributes exposing (css, alt, src, class, href)
import Svg.Styled exposing (rect, svg, polygon, animateTransform)
import Svg.Styled.Attributes as SS


theme =
    { primary = hex "000000"
    , secondary = hex "ffffff"
    }


fullContainer =
    batch
        [ color theme.secondary
        , fontFamilies ["Patua One", "sans-serif"]
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
        , fontFamilies ["Nova Square", "sans-serif"]
        , fontSize (rem 1.5)
        , borderColor (hex "ffffff")
        , borderWidth (px 1)
        , borderBottomStyle solid
        , paddingBottom (px 4)
        ]


contactLink =
    batch
        [ color (hex "ffffff")
        , fontSize (rem 2)
        , margin2 (px 0) (px 10)
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
    batch [
        animationName (
            CA.keyframes
                [ ( 0, [ CA.property "stroke-width" "1"
                       , CA.transform [scale 0.1 ]
                        , CA.property "stroke" "#aaaaaa"
                       ]
                  )
                , ( 33, [ CA.property "stroke-width" "3"
                        , CA.transform [ rotate (deg 90), scale 1 ]
                        , CA.property "stroke" "#555555"
                        ]
                  )
                , ( 66, [ CA.property "stroke-width" "6"
                        , CA.transform [ rotate (deg 180), scale 1.2 ]
                        ]
                  )
                , ( 100, [ CA.property "stroke-width" "1"
                         , CA.property "stroke" "#111111"
                         , CA.transform [rotate (deg 270), scale 0.5]
                         ]
                  )
                ]
        )
        , transform ( translateZ (px 0) )
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


projectItemWrapper =
    batch
        [ width (pct 100)
        , padding2 (rem 1.25) (rem 1.25)
        , marginTop (rem 2)
        , border3 (px 2) solid (rgb 50 50 50)
        , borderRadius (px 10)
        , boxSizing borderBox
        , animationName (
            CA.keyframes
                [ ( 0, [ CA.property "opacity" "0"
                       ]
                  )
                , ( 100, [ CA.property "opacity" "1"
                         ]
                  )
                ]
        )
        , property "animation-iteration-count" "1"
        , animationDuration (sec 1)
        ]


projectItemTitle =
    batch
        [ marginTop (px 0)
        , marginBottom (rem 1)
        , fontFamilies ["Patua One", "sans-serif"]
        , color theme.secondary
        , fontWeight normal
        ]


projectItemDesc =
    batch
        [ fontSize (rem 1)
        , fontFamilies ["Ropa Sans", "sans-serif"]
        , margin2 (rem 1) (rem 0)
        , padding (px 0)
        , color theme.secondary
        ]



contentContainer =
    batch
        [ width (px 480)
        , padding (rem 2)
        ]

textLeft = batch [ textAlign left ]

noVisible = batch [ display none ]

noneCss = batch []
