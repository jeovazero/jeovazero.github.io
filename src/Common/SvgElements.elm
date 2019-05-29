module Common.SvgElements exposing (..)
import Css exposing (..)
import Svg.Styled.Attributes as SS
import Svg.Styled exposing (rect, svg, polygon, animateTransform)
import Common.Styles exposing (polygonAnim, svgStyle)

triangle =
    svg [ SS.width "20"
        , SS.height "20"
        , SS.viewBox "0 0 16 16"
        ]
        [
         polygon
          [ SS.fill "#ffffff"
          , SS.points "3,3 13,8 3,13"
          ]
          []
        ]

myTriangle points strokeWidth delay =
    polygon
      [ SS.fill "none"
      , SS.stroke "#222222"
      , SS.strokeWidth strokeWidth
      , SS.points points
      , SS.css [ polygonAnim, animationDuration delay ]
      ]
      [ animateTransform
            [ SS.attributeName "transform"
            , SS.attributeType "skewX"
            , SS.dur "2s"
            , SS.from "0"
            , SS.to "10"
            , SS.repeatCount "indefinite"
            ]
            []
      ]


svgBackgroundAnimation =
    svg [ SS.css [ svgStyle ]
        , SS.width "300"
        , SS.height "480"
        , SS.viewBox "0 0 300 480"
        ]
        [ myTriangle "220,20 280,14 260,44" "4" (sec 11)
        , myTriangle "30,336 60,300 80,340" "4" (sec 5)
        , myTriangle "60,410 150,400 90,450" "4" (sec 7)
        , myTriangle "170,440 280,410 250,470" "4" (sec 6)
        ]

