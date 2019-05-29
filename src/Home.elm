module Home exposing (view)
import Css exposing (..)
import Css.Animations as CA
import Css.Media exposing (withMedia, only, screen, maxWidth)
import Html.Styled exposing (div, styled, text, img, a, i, Html)
import Html.Styled.Attributes exposing (css, alt, src, class, href)
import Svg.Styled.Attributes as SS
import Common.SvgElements exposing (myTriangle, svgBackgroundAnimation)
import Common.Styles exposing
    ( theme
    , fullContainer
    , sectionLink
    , contactLink
    , centerContentFlex
    , centerItemsFlex
    , verticalFlex
    , mediaHome
    , sectionLinkWrapperStyle
    , myLogoStyle
    , svgStyle
    , polygonAnim
    , mybgStyle
    , homeContentStyle
    , bgBlack
    , noVisible
    , noneCss
    )


link : String -> String ->  Html msg
link label ref =
    div [ css [ sectionLinkWrapperStyle ]]
        [
          a  [ css [ sectionLink ], href ref ]
             [ text label ]
        ]


linkGroup =
    div [ css [ textAlign center ] ]
        [ link "Projetos" "#"
        , link "Sobre" "#"
        , link "Blog" "/blog"
        ]


myLogo =
    div [ css [ myLogoStyle ]]
        [ img [ alt "jeovazero", src "/assets/logo.png", css [ width (pct 100)] ]
              []
        ]


contact ref className =
    a [ href ref, css [ contactLink ] ]
      [ i [ class className ] []
      ]


contactLinks =
    [ ("fab fa-telegram", "https://t.me/jeotario")
    , ("fab fa-github", "https://github.com/jeovazero")
    , ("fab fa-twitter", "https://twitter.com/jeovazero")
    , ("fab fa-linkedin", "https://linkedin.com/in/jeovazero")
    ]


contacts =
    div [ css [ margin2 (rem 2) (px 0) ] ]
        (List.map (\(x,y) -> contact y x) contactLinks)


homeContainer listEl =
    div [ css [ centerContentFlex, fullContainer, centerItemsFlex, bgBlack ] ]
        listEl


backgroundLogo = div [ css [ mybgStyle ] ] [ img [ src "/assets/Vector.svg" ] [] ]


view =
    homeContainer
      [
        div [ css [ homeContentStyle ] ]
            [ myLogo
            , contacts
            , linkGroup
            ]
      , svgBackgroundAnimation
      , backgroundLogo
      ]
