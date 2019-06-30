module Main exposing (Model, globalCss, init, main, update, view)

import About
import Basics exposing (max, min)
import Browser
import Browser.Dom
import Browser.Events exposing (onAnimationFrame)
import Browser.Navigation as Nav
import ComingSoon
import Css exposing (margin, padding, px)
import Css.Global exposing (body, global)
import Footer
import Home
import Html exposing (Html, div, text)
import Html.Styled exposing (toUnstyled)
import NotFound as NotFoundPage
import Projects
import Route exposing (Route(..), urlToRoute)
import Task
import Time
import Url


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            ]
        ]


rAF =
    onAnimationFrame



-- MAIN


main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route.Route
    , smoothScroll : SmoothScroll
    }



-- MSG


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | Anchor (Result Browser.Dom.Error Browser.Dom.Element)
    | InitScroll Float Float Time.Posix
    | Scrolling Time.Posix
    | NoOp


type alias SmoothScroll =
    { isRun : Bool
    , initialOffset : Float
    , offsetDiff : Float
    , initialTime : Int
    }



-- INIT


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , url = url
      , route = urlToRoute url
      , smoothScroll = SmoothScroll False 0 0 0
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested urlReq ->
            case urlReq of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                route =
                    urlToRoute url
            in
            ( { model | url = url, route = route }
            , anchorScroll route
            )

        Anchor arg ->
            case arg of
                Result.Ok el ->
                    ( model, initScroll el.element.y el.viewport.y )

                Result.Err el ->
                    ( model, Cmd.none )

        InitScroll destiny current timePosix ->
            ( { model | smoothScroll = SmoothScroll True current (destiny - current) (Time.posixToMillis timePosix) }, Cmd.none )

        Scrolling timePosix ->
            let
                { offsetDiff, initialOffset, initialTime } =
                    model.smoothScroll

                elapsed =
                    Time.posixToMillis timePosix - initialTime

                progress =
                    min ((elapsed |> toFloat) / 500) 1.0

                easing =
                    cubicOut progress

                nextScroll =
                    offsetDiff * easing + initialOffset
            in
            if progress < 1.0 then
                ( model, setScroll nextScroll )

            else
                ( { model | smoothScroll = SmoothScroll False 0 0 0 }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


setScroll next =
    Task.perform (\_ -> NoOp) (Browser.Dom.setViewport 0 next)


cubicOut t =
    let
        x =
            t - 1
    in
    x * x * x + 1


initScroll : Float -> Float -> Cmd Msg
initScroll destiny current =
    Task.perform (InitScroll destiny current) Time.now


anchorScroll : Route.Route -> Cmd Msg
anchorScroll route =
    case route of
        Route.Init anchorId ->
            let
                id_ =
                    Maybe.withDefault "" anchorId
            in
            Task.attempt Anchor
                (Browser.Dom.getElement id_)

        --   |> Task.andThen
        --       (\info -> Browser.Dom.setViewport 0 info.element.y)
        -- )
        Route.NotFound ->
            Cmd.none

        Route.Blog ->
            Cmd.none



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        { isRun } =
            model.smoothScroll
    in
    case isRun of
        True ->
            rAF Scrolling

        False ->
            Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Route.Blog ->
            { defaultDocument
                | body = List.map toUnstyled [ globalCss, ComingSoon.view ]
            }

        Route.Init arg ->
            defaultDocument

        Route.NotFound ->
            { defaultDocument
                | body = List.map toUnstyled [ globalCss, NotFoundPage.view ]
            }


defaultDocument : Browser.Document Msg
defaultDocument =
    { title = "jeovazero", body = List.map toUnstyled defaultView }


defaultView : List (Html.Styled.Html Msg)
defaultView =
    [ globalCss
    , Home.view
    , Projects.view
    , About.view
    , Footer.view
    ]
