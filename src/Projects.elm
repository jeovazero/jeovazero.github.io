module Projects exposing (projectsView)
import Html exposing (..)
import Html.Attributes exposing (..)


-- PROJECTS


type Link = NoLink | Link String


type alias ProjectInfo =
  { name: String
  , tags: List String
  , description: String
  , projectLink: Link
  , githubLink: Link
  }


projectsView =
    div [ class "projects", id "projects" ]
        [ div [ class "projects-title" ] [ span [] [ text "#" ] , text " Projetos" ]
        , projectsListView
        ]


projectsListView =
    ul  [ class "projects-list" ]
        (List.map (\x -> projectItem x ) projectData)


projectItem
    { name
    , tags
    , description
    , projectLink
    , githubLink} =
        div [ class "project-item" ]
        [ div [ class "project-item-title" ]
              [ div []
                    [ linkView projectLink name ] ]
        , div [ class "project-item-description" ]
              [ text description ]
        , div [ class "project-item-tags" ]
              (List.map (\x -> tagView x) tags)
        , div [ class "project-item-link" ]
              [ linkView projectLink "Projeto"
              , linkView githubLink "Github" ]
        ]

linkView link label =
    case link of
        NoLink -> text ""
        Link lnk -> a [ href lnk, target "_blank" ] [ text label ]

tagView tag =
    div [ class "project-item-tag" ]
        [ text tag ]


projectData =
    [ ProjectInfo
        "8 Puzzle React"
        ["react", "A*", "busca", "react-spring", "redux"]
        "O jogo dos 8 feito com React e Redux"
        (Link "https://8-puzzle-react.jeova.ninja/")
        (Link "https://github.com/jeovazero/8-puzzle-react")
    , ProjectInfo
        "Opacity Project Front-end"
        ["storybook", "react", "emotionjs", "flow", "webpack"]
        "Uma coleção de componentes para Opacity-Project"
        (Link "http://opacity-storybook.surge.sh")
        (Link "https://github.com/AkatsukiJS/opacity-project-front-end")
    , ProjectInfo
        "VUTTR Front-end"
        ["storybook", "react", "emotionjs", "flow", "webpack"]
        "Uma coleção de componentes para a aplicação VUTTR"
        (Link "http://vuttr-ds.surge.sh/")
        (Link "https://github.com/jeovazero/vuttr-frontend")
    , ProjectInfo
        "Adviceme"
        ["vuejs", "sass", "webpack4", "postcss"]
        "Um site fictício para auxiliar advogados iniciantes com ênfase no Piauí"
        (Link "http://app.jeova.ninja/")
        NoLink
    ]
