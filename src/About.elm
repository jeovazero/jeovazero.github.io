module About exposing (view)

import Common.Styles
    exposing
        ( bgBlack
        , centerContentContainer
        , contentContainer
        , myFontFamily
        , textLeft
        , titleSection
        )
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, id, src, style)



-- ABOUT


aboutTextData =
    [ "Meu nome é Jeova \"ZERO\", gosto de matemática, programação competitiva e programação funcional"
    , "Sou Bacharel em Ciência da Computação pela UFPI e às vezes faço coisas legais, como \"parsers\"."
    , "Estou me aventurando em Haskell e Elm Lang e apreciando a pureza destas linguagens."
    , "Gosto de fazer uns front-ends e desenvolver web services, minha linguagem primária é JavaScript. Em meus projetos front-end gosto de usar: React, Storybook, Jest, Webpack 4 e EmotionJS. E no backend: Koa js, GraphQL, MongoDB + Mongoose."
    , "Também uso Python com Flask, Graphene, SqlAlchemy e pytest."
    , "A cada projeto, sempre tento sair da zona de conforto 👊, adicionando novas tecnologias, utilizando outras metodologias ou trocando completamente a stack. Não tenho apego à tecnologias, penso que o que vale é resolver o problema de forma satisfatória."
    ]


textWrapper t =
    p
        [ css
            [ myFontFamily.ropaSans
            , fontSize (rem 1.2)
            , lineHeight (rem 1.8)
            , letterSpacing (px 1)
            , textAlign justify
            ]
        ]
        [ text t ]


aboutTextContainer =
    div []
        (List.map textWrapper aboutTextData)




-- VIEW


view : Html msg
view =
    div [ css [ bgBlack, textLeft ] ]
        [ centerContentContainer
            [ div
                [ css [ contentContainer ] ]
                [ titleSection { id_ = "about", text_ = "Sobre" }
                , aboutTextContainer
                ]
            ]
        ]
