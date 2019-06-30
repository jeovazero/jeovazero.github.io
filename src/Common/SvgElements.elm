module Common.SvgElements exposing (svgNotFoundEye, triangleSvg, trianglesAnimationSvg)

import Css exposing (..)
import Css.Animations as CA
import Svg.Styled exposing (animateTransform, circle, clipPath, defs, ellipse, g, path, polygon, rect, svg, use)
import Svg.Styled.Attributes as SS


svgStyle =
    batch
        [ zIndex (int 1)
        , position absolute
        , top (px 0)
        , left (px 0)
        , height (vh 100)
        , width (pct 100)
        ]



-- TRIANGLES
-- animation


polygonAnimation =
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


triangleSvg =
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


genTriangle points strokeWidth delay =
    polygon
        [ SS.fill "none"
        , SS.stroke "#222222"
        , SS.strokeWidth strokeWidth
        , SS.points points
        , SS.css [ polygonAnimation, animationDuration delay ]
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
        [ genTriangle "220,20 280,14 260,44" "4" (sec 11)
        , genTriangle "30,336 60,300 80,340" "4" (sec 5)
        , genTriangle "60,410 150,400 90,450" "4" (sec 7)
        , genTriangle "170,440 280,410 250,470" "4" (sec 6)
        ]



-- SVG EYE
-- animation


eyeAnimation =
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



-- cornea


cornea =
    path
        [ SS.d
            """
            M175.5 69C164.5 57 156.5 30.5 94.5 21C32.5001 11.5001 1 69 1 69C25
            97 62.7947 106.72 87.5 107.5C112.205 108.28 145.017 103.064 175.5 69Z
            """
        , SS.fill "white"
        , SS.id "cornea"
        ]
        []


corneaDetail =
    path
        [ SS.d
            """
            M153.806 82C136.206 100.8 111.833 102.333 99.5 103C71.5 100.5 99.4999
            99 121.306 92.5C143.465 85.895 175.806 58.5 153.806 82Z
            """
        , SS.fill "#CCCCCC"
        ]
        []


corneaGroup =
    g
        []
        [ cornea
        , corneaDetail
        ]



-- pupil


pupil =
    circle
        [ SS.cx "77"
        , SS.cy "43"
        , SS.r "43"
        , SS.fill "black"
        ]
        []


pupilDetail =
    ellipse
        [ SS.cx "93"
        , SS.cy "33.5"
        , SS.rx "12"
        , SS.ry "9.5"
        , SS.fill "#D8D8D8"
        , SS.fillOpacity "0.12"
        ]
        []


pupilGroup =
    g
        [ SS.clipPath "url(#cornea2)"
        , SS.css
            [ eyeAnimation
            , animationDuration (sec 5)
            ]
        ]
        [ pupil
        , pupilDetail
        ]



-- svg eye group


svgNotFoundEye =
    svg
        [ SS.width "200"
        , SS.height "100"
        , SS.viewBox "0 0 180 120"
        ]
        [ corneaGroup
        , pupilGroup
        ]
