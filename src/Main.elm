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
import AnchorSmoothScroll as SmoothScroll 




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
    -- SmoothScroll Model
    , smoothScroll : SmoothScroll.Model
    }




-- MSG


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | InternalAnchor (Result Browser.Dom.Error Browser.Dom.Element)
    -- SmoothScroll Msg
    | UpdateScroll SmoothScroll.Msg




-- INIT


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , url = url
      , route = urlToRoute url
      -- SmoothScroll INIT
      , smoothScroll = SmoothScroll.resetModel
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
            , onInternalAnchor route
            )

        -- When a internal anchor is clicked
        InternalAnchor arg ->
            case arg of
                -- info is (Browser.Dom.Element)
                -- the information about the element and viewport
                Result.Ok info ->
                    ( model
                    , -- Triggering the UpdateScroll
                      Cmd.map UpdateScroll (
                        SmoothScroll.init info.element.y info.viewport.y
                      )
                    )

                Result.Err el ->
                    ( model, Cmd.none )

        -- SmoothScroll UPDATE
        UpdateScroll msgScroll ->
            let
                (smoothScroll, cmdModel) =
                    SmoothScroll.update model.smoothScroll msgScroll
            in
            ({ model
             | smoothScroll = smoothScroll
             }, Cmd.map UpdateScroll cmdModel
            )
        

onInternalAnchor : Route.Route -> Cmd Msg
onInternalAnchor route =
    case route of
        Route.Init anchorId ->
            let
                id_ =
                    Maybe.withDefault "" anchorId
            in
            Task.attempt InternalAnchor
                (Browser.Dom.getElement id_)

        Route.NotFound ->
            Cmd.none

        Route.Blog ->
            Cmd.none




-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map UpdateScroll (SmoothScroll.subscription model.smoothScroll)




-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Route.Blog ->
            page [ ComingSoon.view ]

        Route.Init arg ->
            page defaultView

        Route.NotFound ->
            page [ NotFoundPage.view ]


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            ]
        ]


page : List (Html.Styled.Html Msg) -> Browser.Document Msg
page htmlList =
    { title = "jeovazero"
    , body = List.map toUnstyled (globalCss :: htmlList)
    }


defaultView : List (Html.Styled.Html Msg)
defaultView =
    [ Home.view
    , About.view
    , Projects.view
    , Footer.view
    ]
