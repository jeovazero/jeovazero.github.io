module NotFound exposing (view)

import Common.Styles
    exposing
        ( bgBlack
        , centerContentFlex
        , centerItemsFlex
        , myFontFamily
        , verticalFlex
        , fullSize
        )
import Common.Elements exposing (contentContainer)
import Common.SvgElements exposing (svgNotFoundEye)
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, id, src, style)



-- VIEW


view =
    div
        [  css
            [ bgBlack
            , centerContentFlex
            , centerItemsFlex
            , fullSize
            ]
       ]
        [ div
            [ css [ verticalFlex, centerItemsFlex ] ]
            [ h1 
                [ css 
                    [ myFontFamily.novaSquare
                    , padding2 (rem 2) (rem 0)
                    ]
                ]
                [ text "NOT FOUND" ]
            , svgNotFoundEye
            ]
        ]
