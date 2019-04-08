import Browser
import Browser.Events exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time
import Task
import Basics exposing (..)
import Home
import Projects
import About


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
    [ Home.homeView model
    , About.aboutView
    , Projects.projectsView
    , footerView
    ]


footerView =
    footer  []
            [ span  []
                    [ text "Copyright (c) 2019 jeovazero" ]
            ]


-- ANIMATION


rAF = Browser.Events.onAnimationFrame

-- constants
widthFrame = 240.0
animTotal = 2500

qtFrame = Home.statusListLength
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
