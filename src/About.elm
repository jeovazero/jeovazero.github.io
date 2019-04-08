module About exposing (aboutView)
import Html exposing (..)
import Html.Attributes exposing (..)


-- ABOUT


type alias AboutmeInfo =
    { content: String
    , imgPath: String
    }


aboutView =
    div [ class "about", id "about" ]
        [ div [ class "about-title" ] [ span [] [ text "#" ], text "Sobre" ]
        , aboutmeListView
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
        "Sou formado em Ciência da Computação pela UFPI"
        "./assets/cs.png"
    ]

