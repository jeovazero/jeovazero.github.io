module Main exposing (Model, globalCss, init, main, update, view)

import About
import Browser
import Browser.Dom
import Browser.Navigation as Nav
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
import Url


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            ]
        ]



-- MAIN


main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route.Route
    }



-- MSG


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | Anchor (Result Browser.Dom.Error ())



-- INIT


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url (urlToRoute url), Cmd.none )



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

        Anchor _ ->
            ( model, Cmd.none )


anchorScroll : Route.Route -> Cmd Msg
anchorScroll route =
    case route of
        Route.Init arg ->
            let
                tag =
                    Maybe.withDefault "" arg
            in
            Task.attempt Anchor
                (Browser.Dom.getElement tag
                    |> Task.andThen (
                         \info -> Browser.Dom.setViewport 0 info.element.y
                       )
                )

        Route.NotFound ->
            Cmd.none

        Route.Blog ->
            Cmd.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Route.Blog ->
            { defaultDocument
            | body = [ div [] [ text "blog em breve" ] ] 
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
