module Home exposing (view)

import Common.Styles
    exposing
        ( bgBlack
        , centerContentFlex
        , centerItemsFlex
        , fullContainer
        , homeContentStyle
        , mediaHome
        , myLogoStyle
        , mybgStyle
        , noVisible
        , noneCss
        , polygonAnim
        , sectionLink
        , sectionLinkWrapperStyle
        , svgStyle
        , theme
        , verticalFlex
        )
import Common.SvgElements exposing (myTriangle, svgBackgroundAnimation)
import Css exposing (..)
import Css.Animations as CA
import Css.Media exposing (maxWidth, only, screen, withMedia)
import Html.Styled exposing (Html, a, div, i, img, styled, text)
import Html.Styled.Attributes exposing (alt, class, css, href, src)
import Svg.Styled.Attributes as SS


link : String -> String -> Html msg
link label ref =
    div [ css [ sectionLinkWrapperStyle ] ]
        [ a [ css [ sectionLink ], href ref ]
            [ text label ]
        ]


linkGroup =
    div [ css [ textAlign center ] ]
        [ link "Projetos" "#projects"
        , link "Sobre" "#about"
        , link "Blog" "/#/blog"
        ]


myLogo =
    div [ css [ myLogoStyle ] ]
        [ img [ alt "jeovazero", src "/assets/logo.png", css [ width (pct 100) ] ]
            []
        ]


contactLink =
    batch
        [ color (hex "ffffff")
        , fontSize (rem 2)
        , margin2 (px 0) (px 10)
        , hover
            [ color (hex "00BBA4")
            ]
        ]


contact ref className =
    a [ href ref, css [ contactLink ] ]
        [ i [ class className ] []
        ]


contactLinks =
    [ ( "fab fa-telegram", "https://t.me/jeotario" )
    , ( "fab fa-github", "https://github.com/jeovazero" )
    , ( "fab fa-twitter", "https://twitter.com/jeovazero" )
    , ( "fab fa-linkedin", "https://linkedin.com/in/jeovazero" )
    ]


contacts =
    div [ css [ margin2 (rem 2) (px 0) ] ]
        (List.map (\( x, y ) -> contact y x) contactLinks)


homeContainer listEl =
    div [ css [ centerContentFlex, fullContainer, centerItemsFlex, bgBlack ] ]
        listEl


backgroundLogo =
    div [ css [ mybgStyle ] ] [ img [ src "/assets/Vector.svg" ] [] ]


view =
    homeContainer
        [ div [ css [ homeContentStyle ] ]
            [ myLogo
            , contacts
            , linkGroup
            ]
        , svgBackgroundAnimation
        , backgroundLogo
        ]
