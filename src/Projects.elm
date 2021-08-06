module Projects exposing (view)

import Common.Styles
    exposing
        ( bgBlack
        , centerContentFlex
        , textLeft
        , theme
        , myFontFamily
        )
import Common.Elements
    exposing
        ( centerContentContainer
        , contentContainer
        , titleSection
        )
import Common.SvgElements exposing (triangleSvg)
import Css exposing (..)
import Css.Media as CM exposing (maxWidth, only, screen, withMedia)
import Html.Styled exposing (Html, a, div, h1, h2, h3, h4, i, img, p, span, styled, text)
import Html.Styled.Attributes as HA exposing (alt, class, css, href, id, src, target)
import Html.Styled.Events exposing (onClick)



-- TAGS


tagWrapper t =
    div
        [ css
            [ padding2 (rem 0.25) (rem 0.5)
            , myFontFamily.patuaOne
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
    div [] (List.map tagWrapper tags)



-- SPECIAL BUTTONS


baseButton =
    styled a
        [ display inlineFlex
        , padding2 (rem 0.25) (rem 1)
        , textDecoration none
        , myFontFamily.patuaOne
        , borderRadius (px 16)
        , marginRight (rem 0.5)
        , lineHeight (rem 1.3)
        , fontSize (rem 1)
        , hover
            [ boxShadow4 (px 0) (px 1) (px 24) (hex "049381")
            ]
        ]


liveDemoButton link =
    baseButton
        [ css
            [ backgroundImage (
                linearGradient2 toLeft (stop <| hex "#0054B6") (stop <| hex "00BBA4") []
              )
            , color theme.secondary
            , fontSize (rem 0.85)
            , hover
                [ boxShadow4 (px 0) (px 1) (px 24) (hex "049381")
                ]
            , withMedia [ only screen [ CM.maxWidth (px 400) ] ]
                [ fontSize (rem 0.75) ]
            ]
        , href link
        , HA.target "_blank"
        ]
        [ triangleSvg
        , span [] [ text "LIVE DEMO" ]
        ]


githubButton git =
    baseButton
        [ css
            [ backgroundColor theme.secondary
            , color theme.primary
            , hover
                [ boxShadow4 (px 0) (px 1) (px 24) (hex "666")
                ]
            ]
        , href git
        , HA.target "_blank"
        ]
        [ text "Github" ]




-- PROJECTS


projectsData =
    [ { title = "8 Puzzle React"
      , tags = [ "react", "A*", "busca", "react-spring" ]
      , desc = "O jogo dos 8 feito com React, utilizando o algoritmo de busca A*."
      , link = Just "https://8-puzzle-react.jeova.ninja/"
      , github = "https://github.com/jeovazero/8-puzzle-react"
      }
    , { title = "Caani"
      , tags = [ "nix", "haskell" ]
      , desc = "Code As AN Image | Beautiful images of your Haskell code"
      , link = Nothing
      , github = "https://github.com/jeovazero/caani"
      }
    ]


projectTitle title =
    h3 [ css
            [ marginTop (px 0)
            , marginBottom (rem 1)
            , myFontFamily.patuaOne
            , color theme.secondary
            , fontWeight normal
            ]
       ]
       [ text title ]


projectDescription desc =
    p [ css
        [ fontSize (rem 1)
        , myFontFamily.ropaSans
        , margin2 (rem 1) (rem 0)
        , padding (px 0)
        , color theme.secondary
        , lineHeight (rem 1.5)
        ]
      ]
      [ text desc ]


renderLink maybeLink =
    case maybeLink of
        Just link -> liveDemoButton link
        _  -> div [] []

projectCard { title, tags, desc, link, github } =
    div [ css
            [ width (pct 100)
            , padding2 (rem 1.25) (rem 1.25)
            , marginTop (rem 2)
            , border3 (px 2) solid (rgb 50 50 50)
            , borderRadius (px 10)
            , boxSizing borderBox
            ]
        ]
        [ projectTitle title
        , projectDescription desc
        , tagsContainer tags
        , div
            [ css
                [ marginTop (rem 1)
                , displayFlex
                ]
            ]
            [ renderLink link
            , githubButton github
            ]
        ]


projectCardsContainer =
    div [] (List.map projectCard projectsData)



-- VIEW


view : Html msg
view =
    div [ css [ bgBlack, textLeft ] ]
        [ centerContentContainer []
            [ contentContainer []
                [ titleSection { id_ = "projects", text_ = "Projetos" }
                , projectCardsContainer
                ]
            ]
        ]
