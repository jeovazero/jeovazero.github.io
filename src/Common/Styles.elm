module Common.Styles exposing ( bgBlack, centerContentFlex, centerItemsFlex, textLeft, theme, verticalFlex, myFontFamily, fullSize)

import Css exposing (..)
import Css.Media exposing (maxWidth, only, screen, withMedia)
import Html.Styled exposing (Html, a, div, h1, i, img, styled, text)
import Html.Styled.Attributes exposing (alt, class, css, href, src, id)
import Svg.Styled exposing (animateTransform, polygon, rect, svg)
import Svg.Styled.Attributes as SS


theme =
    { primary = hex "000000"
    , secondary = hex "ffffff"
    }


bgBlack =
    batch
        [ backgroundColor theme.primary ]


fullSize =
    batch
        [ color theme.secondary
        , minHeight (vh 100)
        , minWidth (pct 100)
        ]


-- FLEX


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
 


-- FONTS and TEXT


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


textLeft =
    batch [ textAlign left ]
