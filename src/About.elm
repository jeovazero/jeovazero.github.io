module About exposing (aboutView)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src, class, style, id)


-- ABOUT


type alias AboutmeInfo =
    { content: String
    , imgPath: String
    }


aboutmeText =
    List.map (\x -> p [] [ text x ] )
    [ """
        Na minha stack front-end, geralmente uso: React, Emotion JS, Flow e Jest.
      """
    , """
        Para a stack backend, gosto de usar: KoaJS 2, MongoDB, Redis, Joi e Jest.
      """
    , """
        Também desenvolvo backend em Python com a stack: Flask, SQLAlchemy, Graphene e Pytest
      """
    ]



aboutmeTextView =
    div [ class "about-text" ]
        aboutmeText


aboutView =
    div [ class "about", id "about" ]
        [ div [ class "about-title" ] [ span [] [ text "#" ], text "Sobre" ]
        , aboutmeListView
        , aboutmeTextView
        ]


aboutmeListView =
    ul  [ class "about-list" ]
        (List.map (\x -> aboutmeItem x ) aboutmeData)


aboutmeItem {content, imgPath} =
    div [ class "about-item" ]
        [ div [ class "about-item-left" ]
              [ div [] []
              , img [ src imgPath ] []
              , div [] [ ]
              ]
        , div [ class "about-item-right" ]
              [ text content ]
        ]


aboutmeData =
    [ AboutmeInfo
        "Ex-participante da Maratona de Programação - SBC. Na final brasileira 3 vezes."
        "./assets/cp.png"
    , AboutmeInfo
        "Gosto do paradigma funcional. Haskell e Elm lang."
        "./assets/lambda.png"
    , AboutmeInfo
        "Desenvolvedor Javascript Back-end/Front-end"
        "./assets/js.png"
    , AboutmeInfo
        "Bacharelado em Ciência da Computação pela UFPI"
        "./assets/cs.png"
    ]

