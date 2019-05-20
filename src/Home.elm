module Home exposing (view)
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
        [ backgroundColor theme.primary
        , color theme.secondary
        , fontFamilies ["Patua One", "sans-serif"]
        , height (vh 100)
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


link : String -> String -> Html msg 
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

myLogoStyle =
    batch
      [ withMedia [ only screen [ maxWidth (px 400) ] ]
                  [ width (px 200) ]
      , width (px 320)
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
    div [ css [ centerContentFlex, fullContainer, centerItemsFlex ] ]
        listEl


svgStyle =
    batch
      [ zIndex (int 0)
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
                       , CA.transform [skewX (deg 0), skewY (deg 0)]
                       ]
                  )
                , ( 33, [ CA.property "stroke-width" "3"
                        , CA.transform [skewY (deg 2), skewX (deg -1)]
                        ]
                  )
                , ( 66, [ CA.property "stroke-width" "6"
                        , CA.transform [skewX (deg 1)]
                        ]
                  )
                , ( 100, [ CA.property "stroke-width" "1"
                         , CA.transform [skewY (deg 0), skewX (deg 0)]
                         ]
                  )
                ]
        )
        , animationDuration (sec 10)
        , property "animation-iteration-count" "infinite"
    ]

myTriangle points strokeWidth =
    polygon
      [ SS.fill "none"
      , SS.stroke "#555555"
      , SS.strokeWidth strokeWidth
      , SS.points points
      , SS.css [ polygonAnim ]
      ]
      [ animateTransform
            [ SS.attributeName "transform"
            , SS.attributeType "skewX"
            , SS.dur "5s"
            , SS.from "0"
            , SS.to "10"
            , SS.repeatCount "indefinite"
            ]
            []
      ]


mysvg =
    svg [ SS.css [ svgStyle ]
        , SS.width "300"
        , SS.height "480"
        , SS.viewBox "0 0 300 480"
        ]
        [ myTriangle "220,20 280,14 260,44" "4"
        , myTriangle "30,336 60,300 80,340" "4"
        , myTriangle "60,410 150,400 90,450" "4"
        , myTriangle "170,440 280,410 250,470" "4"
        ]


homeContentStyle =
    batch
      [ verticalFlex
      , mediaHome
      , centerItemsFlex
      , zIndex (int 2)
      ]


view =
    homeContainer
      [
        div [ css [ homeContentStyle ] ]
            [ myLogo
            , contacts
            , linkGroup
            ]
      , mysvg
      ]
