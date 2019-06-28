module Projects exposing (Msg(..), view)

import Common.Styles
    exposing
        ( bgBlack
        , centerContentContainer
        , centerContentFlex
        , contentContainer
        , sectionLink
        , sectionLinkWrapperStyle
        , textLeft
        , theme
        , titleSection
        , titleWrapper
        , underlineEl
        )
import Common.SvgElements exposing (triangle)
import Css exposing (..)
import Css.Media exposing (maxWidth, only, screen, withMedia)
import Html.Styled exposing (Html, a, div, h1, h2, h3, h4, i, img, p, span, styled, text)
import Html.Styled.Attributes exposing (alt, class, css, href, id, src, target)
import Html.Styled.Events exposing (onClick)


itemsData =
    [ { title = "8 Puzzle React"
      , tags = [ "react", "A*", "busca", "react-spring", "redux" ]
      , desc = "O jogo dos 8 feito com React e Redux. Foi utilizado o algoritmo de busca A*, implementado em Vanilla JS."
      , link = "https://8-puzzle-react.jeova.ninja/"
      , github = "https://github.com/jeovazero/8-puzzle-react"
      }
    , { title = "Opacity Project"
      , tags = [ "react", "emotionjs", "flow", "webpack" ]
      , desc = "Um mini-portal que usa dados do \"Portal da Transparência\""
      , link = "http://opacity-project.netlify.com"
      , github = "https://github.com/AkatsukiJS/opacity-project-front-end"
      }
    ]


tagWrapper t =
    div
        [ css
            [ padding2 (rem 0.25) (rem 0.5)
            , fontFamilies [ "Patua One", "sans-serif" ]
            , color (hex "#cccccc")
            , borderRadius (px 24)
            , backgroundColor (rgba 255 255 255 0.17)
            , display inlineBlock
            , marginRight (rem 0.33)
            , marginBottom (rem 0.33)
            , fontSize (rem 0.85)
            ]
        ]
        [ text t ]


tagsContainer tags =
    div []
        (List.map (\t -> tagWrapper t) tags)


liveDemoButton link =
    a
        [ css
            [ display inlineFlex
            , padding2 (rem 0.25) (rem 1)
            , textDecoration none
            , backgroundImage (linearGradient2 toLeft (stop <| hex "#0054B6") (stop <| hex "00BBA4") [])
            , color theme.secondary
            , fontFamilies [ "Patua One", "sans-serif" ]
            , borderRadius (px 16)
            , marginRight (rem 0.5)
            , lineHeight (rem 1.3)
            , fontSize (rem 0.85)
            , hover
                [ boxShadow4 (px 0) (px 1) (px 24) (hex "049381")
                ]
            , withMedia [ only screen [ maxWidth (px 400) ] ]
                [ fontSize (rem 0.75) ]
            ]
        , href link
        , target "_blank"
        ]
        [ triangle, span [] [ text "LIVE DEMO" ] ]


githubButton git =
    a
        [ css
            [ display inlineFlex
            , padding2 (rem 0.25) (rem 1)
            , textDecoration none
            , backgroundColor theme.secondary
            , color theme.primary
            , fontFamilies [ "Patua One", "sans-serif" ]
            , marginRight (rem 0.5)
            , borderRadius (px 16)
            , lineHeight (rem 1.2)
            , hover
                [ boxShadow4 (px 0) (px 1) (px 24) (hex "666")
                ]
            ]
        , href git
        , target "_blank"
        ]
        [ text "Github" ]


projectItemWrapper =
    batch
        [ width (pct 100)
        , padding2 (rem 1.25) (rem 1.25)
        , marginTop (rem 2)
        , border3 (px 2) solid (rgb 50 50 50)
        , borderRadius (px 10)
        , boxSizing borderBox
        ]


projectItemTitle =
    batch
        [ marginTop (px 0)
        , marginBottom (rem 1)
        , fontFamilies [ "Patua One", "sans-serif" ]
        , color theme.secondary
        , fontWeight normal
        ]


projectItemDesc =
    batch
        [ fontSize (rem 1)
        , fontFamilies [ "Ropa Sans", "sans-serif" ]
        , margin2 (rem 1) (rem 0)
        , padding (px 0)
        , color theme.secondary
        , lineHeight (rem 1.5)
        ]


itemWrapper { title, tags, desc, link, github } =
    div [ css [ projectItemWrapper ] ]
        [ h3 [ css [ projectItemTitle ] ] [ text title ]
        , p [ css [ projectItemDesc ] ] [ text desc ]
        , tagsContainer tags
        , div [ css [ marginTop (rem 1), displayFlex ] ]
            [ liveDemoButton link
            , githubButton github
            ]
        ]


items =
    div [] (List.map (\x -> itemWrapper x) itemsData)


type Msg
    = Toggle


view =
    div [ css [ bgBlack, textLeft ] ]
        [ centerContentContainer
            [ div [ css [ contentContainer ] ]
                [ titleWrapper
                    []
                    [ titleSection [ id "projects" ] [ text "Projetos", underlineEl ]
                    ]
                , items
                ]
            ]
        ]
