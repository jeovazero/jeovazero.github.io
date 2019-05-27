module Projects exposing (view)
import Css exposing (..)
import Css.Media exposing (withMedia, only, screen, maxWidth)
import Html.Styled exposing (div, styled, text, img, a, i, Html, h4, h1, h2, h3, p, span)
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
        , minHeight (vh 100)
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


projectsContainer listEl =
    div [ css [ fullContainer, centerContentFlex ] ]
        listEl


itemsData =
    [
    { title = "8 Puzzle React [WEB APP]"
    , tags = ["react", "A*", "busca", "react-spring", "redux"]
    , desc = "O jogo dos 8 feito com React e Redux"
    , link = "https://8-puzzle-react.jeova.ninja/"
    , github = "https://github.com/jeovazero/8-puzzle-react"
    },
    { title = "Opacity Project [WEB APP]"
    , tags = ["react", "emotionjs", "flow", "webpack"]
    , desc = "Um mini-portal que usa dados do \"Portal da Transparências\""
    , link = "http://opacity-project.netlify.com"
    , github = "https://github.com/AkatsukiJS/opacity-project-front-end"
    }
    ]


projectItemWrapper =
    batch
        [ width (pct 100)
        , backgroundColor theme.primary
        , padding2 (rem 1) (rem 0)
        , marginTop (rem 2)
        ]


projectItemTitle =
    batch
        [ marginTop (px 0)
        , marginBottom (rem 1)
        , fontFamilies ["Patua One", "sans-serif"]
        , color theme.secondary
        ]


projectItemDesc =
    batch
        [ fontSize (rem 1)
        , fontFamilies ["Ropa Sans", "sans-serif"]
        , margin2 (rem 1) (rem 0)
        , padding (px 0)
        , color theme.secondary
        ]


tagWrapper t =
    div [ css [ padding2 (rem 0.25) (rem 0.5)
              , backgroundColor (hex "444444")
              , fontFamilies ["Patua One", "sans-serif"]
              , color theme.secondary
              , display inlineBlock
              , marginRight (rem 0.33)
              , marginBottom (rem 0.33)
              , fontSize (rem 0.85)
              ]
        ] [ text t ]


tagsContainer tags =
    div []
        (List.map (\t -> tagWrapper t) tags)

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


liveDemoButton link =
    a   [ css [ display inlineFlex
              , padding2 (rem 0.25) (rem 1)
              , textDecoration none
              , backgroundColor (hex "0C8872")
              , color theme.secondary
              , fontFamilies ["Patua One", "sans-serif"]
              , borderRadius (px 16)
              , marginRight (rem 0.5)
              , lineHeight (rem 1.2)
              ]
        , href link
        ]
        [ triangle, span [] [text "Live demo" ]]


githubButton git =
    a   [ css [ display inlineFlex
              , padding2 (rem 0.25) (rem 1)
              , textDecoration none
              , backgroundColor theme.secondary
              , color theme.primary
              , fontFamilies ["Patua One", "sans-serif"]
              , marginRight (rem 0.5)
              , borderRadius (px 16)
              , lineHeight (rem 1.2)
              ]
          , href git
        ]
        [ text "Github" ]

itemWrapper
    { title
    , tags
    , desc
    , link
    , github
    } =
        div [ css [ projectItemWrapper ] ]
            [ h3 [ css [ projectItemTitle ] ] [ text title ]
            , p [ css [ projectItemDesc ]] [ text desc ]
            , tagsContainer tags
            , div  [ css [ marginTop (rem 0.66), displayFlex]]
                   [ liveDemoButton link
                   ,  githubButton github
                   ]
            ]


items = div [] (List.map (\x -> itemWrapper x) itemsData)

titleSection =
    styled h1
        [ margin (px 0)
        , padding2 (rem 2) (rem 0)
        , fontFamilies ["Nova Square", "sans-serif"]
        , display inlineBlock
        ]


underline =
    div [ css [ width (pct 100)
              , borderColor (hex "ffffff")
              , borderWidth (px 4)
              , borderBottomStyle solid
              , marginTop (rem 0.5)
              ]
        ] []


contentContainer =
    batch
        [ width (px 480)
        , padding (rem 2)
        ]


view =
    projectsContainer
      [
        div [ css [ contentContainer ] ]
            [ titleSection [] [ text "Projetos", underline ]
            , items
            ]
      ]
