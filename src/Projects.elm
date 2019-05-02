module Projects exposing (projectsView)
import Html exposing (..)
import Html.Attributes exposing (..)


-- PROJECTS


type Link = NoLink | Link String


type alias ProjectInfo =
  { name: String
  , tags: List String
  , description: String
  , imgsrc: String
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
    , imgsrc
    , projectLink
    , githubLink} =
        div [ class "project-item" ]
        [ a (linkResolve projectLink ++ [ class "project-item-img", style "background-image" imgsrc ]) []
        , div   [ class "project-item-content" ]
                [ div [ class "project-item-title" ]
                      [ div []
                            [ linkView projectLink name ] ]
                , div   [ class "project-item-description" ]
                        [ text description ]
                , div   [ class "project-item-tags" ]
                        (List.map (\x -> tagView x) tags)
                , div   [ class "project-item-link" ]
                        [ text "Links -> "
                        , linkView projectLink "Projeto"
                        , linkView githubLink "Github" ]
                ]
        ]

linkResolve link =
    case link of
        NoLink -> []
        Link lnk -> [ href lnk, target "_blank" ]


linkView link label =
    case link of
        NoLink -> text ""
        Link lnk -> a [ href lnk, target "_blank" ] [ text label ]

tagView tag =
    div [ class "project-item-tag" ]
        [ text tag ]


projectData =
    [ ProjectInfo
        "8 Puzzle React [WEB APP]"
        ["react", "A*", "busca", "react-spring", "redux"]
        "O jogo dos 8 feito com React e Redux"
        "url(../assets/8puzzle.png)"
        (Link "https://8-puzzle-react.jeova.ninja/")
        (Link "https://github.com/jeovazero/8-puzzle-react")
    , ProjectInfo
        "Opacity Project [WEB APP]"
        ["react", "emotionjs", "flow", "webpack"]
        "Um mini-portal que usa dados do \"Portal da Transparências\""
        "url(../assets/opacity.png)"
        (Link "http://opacity-project.netlify.com")
        (Link "https://github.com/AkatsukiJS/opacity-project-front-end")
    , ProjectInfo
        "Opacity Project [Storybook]"
        ["storybook", "react", "emotionjs", "flow", "webpack"]
        "Uma coleção de componentes para Opacity-Project"
        "url(../assets/opacity-story.png)"
        (Link "http://opacity-storybook.surge.sh")
        (Link "https://github.com/AkatsukiJS/opacity-project-front-end")
    , ProjectInfo
        "VUTTR [Storybook]"
        ["storybook", "react", "emotionjs", "flow", "webpack"]
        "Uma coleção de componentes para a aplicação VUTTR"
        "url(../assets/vuttr-story.png)"
        (Link "http://vuttr-ds.surge.sh/")
        (Link "https://github.com/jeovazero/vuttr-frontend")
    , ProjectInfo
        "Adviceme [WIP]"
        ["vuejs", "sass", "webpack4", "postcss"]
        "Um site fictício para auxiliar advogados iniciantes com ênfase no Piauí"
        "url(../assets/adviceme.png)"
        (Link "http://app.jeova.ninja/")
        NoLink
    ]
