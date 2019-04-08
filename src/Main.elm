import Browser
import Browser.Events exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time
import Task
import Basics exposing (..)


-- MAIN


main =
  Browser.document
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- MODEL


type alias Model =
    { translateX: Float
    , animStart: Int
    , curFrame: Int
    , opacity: Float
    }


-- INIT


init : () -> (Model, Cmd Msg)
init _ =
    ( Model -widthCarousel 0 0 0.0, Task.perform NewTime Time.now )


-- SUBCRIPTIONS


subscriptions model =
    rAF Tick


-- ANIMATION


rAF = Browser.Events.onAnimationFrame


-- constants
widthFrame = 240.0
animTotal = 3600

qtFrame = List.length statusList
widthCarousel = (qtFrame |> toFloat) * widthFrame

normalizedProgress : Float -> Float -> Float
normalizedProgress elapsed total = Basics.min (elapsed / total) 1.0

-- easing
easeOutCubic : Float -> Float
easeOutCubic t = let v = t - 1 in v * v * v * v * v + 1

tick : Time.Posix -> Model -> (Model, Cmd Msg)
tick now model =
    let
      elapsed = (Time.posixToMillis now) - model.animStart
      progress = normalizedProgress (elapsed |> toFloat) animTotal
      easing = easeOutCubic progress
      op = Basics.max ((Basics.sin easing) + 0.2) 0
      tX = (1 - easing) * widthFrame + (model.curFrame |> toFloat) * widthFrame
      cmd =
          if progress >= 1
            then (Task.perform NewTime Time.now)
            else (Cmd.none)
      nextFrame =
          if progress >= 1
            then modBy qtFrame (qtFrame + model.curFrame - 1)
            else model.curFrame
    in
    (
      { model
      | translateX = -tX
      , curFrame = nextFrame
      , opacity = op
      }
      , cmd
    )


-- UPDATE


type Msg = Tick Time.Posix
    | NewTime Time.Posix


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick now -> tick now model
        NewTime now -> ({model | animStart = Time.posixToMillis now}, Cmd.none)


-- VIEW

view : Model -> Browser.Document Msg
view model =
  { title = "jeovazero"
  , body = body model
  }


body model =
    [ homeView model
    , aboutView
    ]

aboutView =
    div [ class "about", id "about" ]
        [ div [ class "about-title" ] [ text "# Sobre" ]
        , aboutmeListView
        ]

type alias AboutmeInfo =
    { content: String
    , imgPath: String
    }


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


aboutmeListView =
    ul  [ class "about-list" ]
        (List.map (\x -> aboutmeItem x ) aboutmeData)


homeView model =
    let
        translateX = model.translateX |> toStrTx
        opacity = model.opacity
        current = model.curFrame
    in
    div [ class "wrapper" ]
        [ div [ class "main" ]
              [ img [ src "./assets/logo.png" ] []
              , div [ class "desc"]
                    [ text "Desenvolvedor JavaScript"
                    , br [] []
                    , text "Back-end/Front-end"
                    ]
              , div [ class "bio" ] [ text "Bio" ]
              , contactsView
              , buttonsView
              ]
        , div [ class "status" ]
              [ carousel current translateX opacity ]
        , footer []
                 [ span [] [ text "Copyright (c) 2019 jeovazero" ] ]
        ]


buttonsView =
    div [ class "buttons" ]
        [ a [ class "button", href "#about"] [ text "# Sobre" ]
        , a [ class "button", href "#projects"] [ text "# Projetos" ]
        ]

brandIcon : String -> String -> Html msg
brandIcon name link =
    a [ href link ]
      [ i [ class (String.concat ["fab ", name]) ] []
      ]


contactsView : Html msg
contactsView =
    div [ class "contacts" ]
        [ brandIcon "fa-telegram" "https://t.me/jeotario"
        , brandIcon "fa-github" "https://github.com/jeovazero"
        , brandIcon "fa-twitter" "https://twitter.com/jeovazero"
        , brandIcon "fa-linkedin" "https://linkedin.com/in/jeovazero"
        ]


statusList =
    [ "Try hard \u{1F44A}"
    , "Em construção com ELM \u{1F6A7}"
    , "Será que faço um blog? \u{1F4DD}"
    , "Elm é Haskell-like"
    , "Gosto de Haskell"
    , "Primeiro faço, depois aprimoro"
    , "Se eu não sei, vou pesquisar \u{1F624} "
    , "Ocaml não é funcional pura \u{1F42B}"
    , "Elm é funcional pura \u{1F49C}"
    , "Haskell é funcional pura \u{1F49C}"
    ]


suffixStatusList list = list ++ [ List.head list |> Maybe.withDefault "" ]


statusListHtml current opacity =
    suffixStatusList
        statusList
            |> List.indexedMap
                (\i x -> div [ style "opacity" (if i == current then (String.fromFloat opacity) else "1") ] [ text x ] )


toStrTx : Float -> String
toStrTx i = (i |> String.fromFloat ) ++ "px"


carousel current tx opacity =
    div [ class "carousel"
        , style "transform" ("translate3d(" ++ tx ++ ", 0px, 0px)")
        ]
        (statusListHtml current opacity)
