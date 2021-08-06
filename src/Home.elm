module Home exposing (view)

import Common.Styles
    exposing
        ( bgBlack
        , centerContentFlex
        , centerItemsFlex
        , fullSize
        , myFontFamily
        , verticalFlex
        )
import Common.SvgElements exposing (trianglesAnimationSvg)
import Css exposing (..)
import Css.Media as CM exposing (maxWidth, only, screen, withMedia)
import Html.Styled exposing (Html, a, div, i, img, styled, text)
import Html.Styled.Attributes as HA exposing (alt, class, css, href, src, target)



-- LINKS


anchor =
    styled a
        [ color (hex "ffffff")
        , textDecoration none
        , myFontFamily.novaSquare
        , fontSize (rem 1.5)
        , borderColor (hex "333")
        , borderWidth (px 2)
        , borderBottomStyle solid
        , paddingBottom (px 4)
        , hover
            [ borderColor (hex "fff")
            ]
        ]


linksData : List ( String, String )
linksData =
    [ ( "Sobre", "#about" )
    , ( "Projetos", "#projects" )
    ]


linkWrapper : ( String, String ) -> Html msg
linkWrapper ( label, ref ) =
    div
        [ css
            [ margin2 (rem 0.75) (px 0)
            , padding2 (rem 0.25) (rem 0)
            ]
        ]
        [ anchor
            [ href ref ]
            [ text label ]
        ]


linksContainer =
    div [ css [ textAlign center ] ]
        (List.map linkWrapper linksData)



-- CONTACTS


contactsData =
    [ ( "fab fa-telegram", "https://t.me/jeovazero" )
    , ( "fab fa-github", "https://github.com/jeovazero" )
    ]


contactIcon ( className, ref ) =
    a
        [ href ref
        , HA.target "_blank"
        , css
            [ color (hex "ffffff")
            , fontSize (rem 2)
            , margin2 (px 0) (px 10)
            , hover
                [ color (hex "00BBA4")
                ]
            ]
        ]
        [ i [ class className ] []
        ]


contactsContainer =
    div [ css [ margin2 (rem 2) (px 0) ] ]
        (List.map contactIcon contactsData)



-- MY LOGO


myLogo =
    div
        [ css
            [ withMedia
                [ only screen [ CM.maxWidth (px 400) ] ]
                [ width (px 200) ]
            , width (px 320)
            ]
        ]
        [ img
            [ alt "jeovazero"
            , src "/assets/logo.png"
            , css [ width (pct 100) ]
            ]
            []
        ]


backgroundLogo =
    div
        [ css
            [ position absolute
            , zIndex (int 0)
            , right (px 10)
            , bottom (px 10)
            , opacity (num 0.5)
            ]
        ]
        [ img [ src "/assets/Vector.svg" ] [] ]



-- HOME CONTAINERS


homeContainer =
    div
        [ css
            [ centerContentFlex
            , centerItemsFlex
            , bgBlack
            , fullSize
            ]
        ]


mediaHome =
    batch
        [ withMedia [ only screen [ CM.maxWidth (px 400) ] ]
            [ width (pct 100) ]
        ]


homeContentContainer =
    div
        [ css
            [ verticalFlex
            , mediaHome
            , centerItemsFlex
            , zIndex (int 2)
            ]
        ]



-- VIEW


view : Html msg
view =
    homeContainer
        [ homeContentContainer
            [ myLogo
            , contactsContainer
            , linksContainer
            ]
        , trianglesAnimationSvg
        , backgroundLogo
        ]
