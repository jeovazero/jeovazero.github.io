module Common.SvgElements exposing (myTriangle, trianglesAnimationSvg, svgNotFoundEye, triangle)

import Common.Styles exposing (eyeAnim, polygonAnim, svgStyle)
import Css exposing (..)
import Svg.Styled exposing (animateTransform, circle, clipPath, defs, ellipse, g, path, polygon, rect, svg, use)
import Svg.Styled.Attributes as SS


triangle =
    svg
        [ SS.width "20"
        , SS.height "20"
        , SS.viewBox "0 0 16 16"
        ]
        [ polygon
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


trianglesAnimationSvg =
    svg
        [ SS.css [ svgStyle ]
        , SS.width "300"
        , SS.height "480"
        , SS.viewBox "0 0 300 480"
        ]
        [ myTriangle "220,20 280,14 260,44" "4" (sec 11)
        , myTriangle "30,336 60,300 80,340" "4" (sec 5)
        , myTriangle "60,410 150,400 90,450" "4" (sec 7)
        , myTriangle "170,440 280,410 250,470" "4" (sec 6)
        ]


svgCornea =
    path
        [ SS.d "M175.5 69C164.5 57 156.5 30.5 94.5 21C32.5001 11.5001 1 69 1 69C25 97 62.7947 106.72 87.5 107.5C112.205 108.28 145.017 103.064 175.5 69Z"
        , SS.fill "white"
        , SS.id "cornea"
        ]
        []


ball =
    circle
        [ SS.cx "77"
        , SS.cy "43"
        , SS.r "43"
        , SS.fill "black"
        ]
        []


ballSec =
    ellipse
        [ SS.cx "93"
        , SS.cy "33.5"
        , SS.rx "12"
        , SS.ry "9.5"
        , SS.fill "#D8D8D8"
        , SS.fillOpacity "0.12"
        ]
        []


eyeDetail =
    path
        [ SS.d "M153.806 82C136.206 100.8 111.833 102.333 99.5 103C71.5 100.5 99.4999 99 121.306 92.5C143.465 85.895 175.806 58.5 153.806 82Z"
        , SS.fill "#CCCCCC"
        ]
        []


pupil =
    g [ SS.clipPath "url(#cornea2)", SS.css [ eyeAnim, animationDuration (sec 5) ] ]
        [ ball
        , ballSec
        ]


defClip =
    defs []
        [ clipPath
            [ SS.id "cornea2" ]
            [ svgCornea ]
        ]


cornea =
    g
        []
        [ svgCornea
        , eyeDetail
        ]


svgNotFoundEye =
    svg
        [ SS.width "200"
        , SS.height "100"
        , SS.viewBox "0 0 180 120"
        ]
        [ cornea
        , pupil
        ]
