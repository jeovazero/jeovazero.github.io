module Projects exposing (view, Msg(..))
import Css exposing (..)
import Html.Styled exposing (div, styled, text, img, a, i, Html, h4, h1, h2, h3, p, span)
import Html.Styled.Attributes exposing (css, alt, src, class, href, target)
import Html.Styled.Events exposing (onClick)
import Common.SvgElements exposing (triangle)
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
    , projectItemWrapper
    , projectItemTitle
    , projectItemDesc
    , contentContainer
    , absoluteContainer
    , textLeft
    , bgBlack
    )


projectsContainer listEl =
    div [ css [ centerContentFlex, color (hex "fff") ] ]
        listEl


itemsData =
    [
    { title = "8 Puzzle React"
    , tags = ["react", "A*", "busca", "react-spring", "redux"]
    , desc = "O jogo dos 8 feito com React e Redux"
    , link = "https://8-puzzle-react.jeova.ninja/"
    , github = "https://github.com/jeovazero/8-puzzle-react"
    },
    { title = "Opacity Project"
    , tags = ["react", "emotionjs", "flow", "webpack"]
    , desc = "Um mini-portal que usa dados do \"Portal da Transparência\""
    , link = "http://opacity-project.netlify.com"
    , github = "https://github.com/AkatsukiJS/opacity-project-front-end"
    }
    ]



tagWrapper t =
    div [ css [ padding2 (rem 0.25) (rem 0.5)
              , fontFamilies ["Patua One", "sans-serif"]
              , color (hex "#cccccc")
              , borderRadius (px 24)
              , backgroundColor (rgba 255 255 255 0.17)
              , display inlineBlock
              , marginRight (rem 0.33)
              , marginBottom (rem 0.33)
              , fontSize (rem 0.85)
              ]
        ] [ text t ]


tagsContainer tags =
    div []
        (List.map (\t -> tagWrapper t) tags)


liveDemoButton link =
    a   [ css [ display inlineFlex
              , padding2 (rem 0.25) (rem 1)
              , textDecoration none
              -- , backgroundColor (hex "0C8872")
              , backgroundImage (linearGradient2 toLeft (stop <| hex "#0054B6") (stop <| hex "00BBA4") [])
              , color theme.secondary
              , fontFamilies ["Patua One", "sans-serif"]
              , borderRadius (px 16)
              , marginRight (rem 0.5)
              , lineHeight (rem 1.2)
              ]
        , href link
        , target "_blank"
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
          , target "_blank"
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
        , fontWeight normal
        ]

titleWrapper =
    styled div
        [ displayFlex
        , justifyContent spaceBetween
        ]


underline =
    div [ css [ width (pct 100)
              , borderColor (rgb 50 50 50)
              , borderWidth (px 2)
              , borderBottomStyle solid
              , marginTop (rem 0.5)
              ]
        ] []


type Msg = Toggle


linkElem : String -> String -> Bool -> Html Msg
linkElem label ref active =
    div [ css [ sectionLinkWrapperStyle ], onClick Toggle]
        [
          a  [ css [ sectionLink ], href ref, target "_blank" ]
             [ text label ]
        ]

view =
    div [ css [ bgBlack, textLeft ]]
        [ projectsContainer
            [  div [ css [ contentContainer ] ]
               [ titleWrapper
                    []
                    [ titleSection [] [ text "Projetos", underline ]
                    ]
               , items
               ]
            ]
        ]
