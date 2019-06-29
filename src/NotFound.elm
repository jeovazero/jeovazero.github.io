module NotFound exposing (view)

import Common.Styles
    exposing
        ( bgBlack
        , centerContentContainer
        , centerContentFlex
        , centerItemsFlex
        , contentContainer
        , fullContainer
        , novaSquareFont
        , sectionLink
        , sectionLinkWrapperStyle
        , textLeft
        , theme
        , titleSection
        , titleWrapper
        , underlineEl
        , verticalFlex
        )
import Common.SvgElements exposing (svgNotFoundEye)
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, id, src, style)



-- VIEW


view =
    div [ css [ bgBlack, fullContainer, centerContentFlex, centerItemsFlex ] ]
        [ div [ css [ verticalFlex, centerItemsFlex ] ]
            [ h1 [ css [ novaSquareFont, padding2 (rem 2) (rem 0) ] ] [ text "NOT FOUND" ]
            , svgNotFoundEye
            ]
        ]
