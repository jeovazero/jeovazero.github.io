module About exposing (view)

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
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, id, src, style)



-- ABOUT


dataText =
    [ "Meu nome é Jeova \"ZERO\", gosto de matemática, programação competitiva e programação funcional"
    , "Sou Bacharel em Ciência da Computação pela UFPI e às vezes faço coisas legais, como \"parsers\"."
    , "Estou me aventurando em Haskell e Elm Lang e apreciando a pureza destas linguagens."
    , "Gosto de fazer uns front-ends e desenvolver web services, minha linguagem primária é JavaScript. Em meus projetos front-end gosto de usar: React, Storybook, Jest, Webpack 4 e EmotionJS. E no backend: Koa js, GraphQL, MongoDB + Mongoose."
    , "Também uso Python com Flask, Graphene, SqlAlchemy e pytest."
    , "A cada projeto, sempre tento sair da zona de conforto, adicionando novas tecnologias, utilizando outras metodologias ou trocando completamente a stack. Não tenho apego à tecnologias, penso que o que vale é resolver o problema de forma satisfatória."
    ]


textWrapper t =
    p
        [ css
            [ fontFamilies [ "Ropa Sans", "Verdana", "sans serif" ]
            , fontSize (rem 1.2)
            , lineHeight (rem 1.8)
            , letterSpacing (px 1)
            , textAlign justify
            ]
        ]
        [ text t ]


textContainer =
    div []
        (List.map
            (\x -> textWrapper x)
            dataText
        )


view =
    div [ css [ bgBlack, textLeft ] ]
        [ centerContentContainer
            [ div [ css [ contentContainer ] ]
                [ titleWrapper
                    []
                    [ titleSection [ id "about" ] [ text "Sobre", underlineEl ]
                    ]
                , textContainer
                ]
            ]
        ]
