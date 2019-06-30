module About exposing (view)

import Common.Elements
    exposing
        ( centerContentContainer
        , contentContainer
        , titleSection
        )
import Common.Styles
    exposing
        ( bgBlack
        , myFontFamily
        , textLeft
        )
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, id, src, style)



-- ABOUT


aboutTextData =
    [ """
      Meu nome é Jeova "ZERO", gosto de matemática, programação competitiva e programação funcional.
      """
    , "Estou me aventurando em Haskell e Elm Lang e apreciando a pureza destas linguagens."
    , """
      Gosto de fazer uns front-ends e desenvolver web services, minha linguagem primária é JavaScript.
      Em meus projetos front-end gosto de usar: React, EmotionJS, Storybook, Jest e Webpack 4. E nos de
      backend: Koa js, GraphQL, MongoDB + Mongoose.
      """
    , "Também uso Python com a stack: Flask, Graphene, SqlAlchemy e pytest."
    , """
      A cada projeto, sempre tento sair da zona de conforto 👊, adicionando novas tecnologias, utilizando
      outras metodologias ou trocando completamente a stack. Não tenho apego à tecnologias, penso que o
      que vale é resolver o problema de forma satisfatória.
      """
    , "Penso em fazer um blog em breve, falando sobre minhas experiências com as tecnologias e projetos que já lidei."
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
        [ centerContentContainer []
            [ contentContainer []
                [ titleSection { id_ = "about", text_ = "Sobre" }
                , aboutTextContainer
                ]
            ]
        ]
