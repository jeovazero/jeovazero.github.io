module Main exposing (Model, globalCss, init, main, subscriptions, update, view)

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
import Projects exposing (Msg(..))
import Task
import Url
import Url.Parser exposing ((</>), Parser, fragment, map, oneOf, parse, s, string, top)


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
        , subscriptions = subscriptions
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route
    }


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | Anchor (Result Browser.Dom.Error ())


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        route =
            toRoute (Url.toString url)
    in
    ( Model key url route, Cmd.none )


subscriptions _ =
    Sub.none


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
                    toRoute (Url.toString url)
            in
            ( { model | url = url, route = route }
            , anchorScroll route
            )

        Anchor _ ->
            ( model, Cmd.none )


anchorScroll route =
    case route of
        Init arg ->
            let
                tag =
                    Maybe.withDefault "" arg
            in
            Task.attempt Anchor
                (Browser.Dom.getElement tag
                    |> Task.andThen (\info -> Browser.Dom.setViewport 0 info.element.y)
                )

        NotFound ->
            Cmd.none

        Blog ->
            Cmd.none


type Route
    = Blog
    | Init (Maybe String)
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Init (fragment identity)
        , map Blog (s "blog" </> top)
        ]


toRoute : String -> Route
toRoute url =
    case Url.fromString url of
        Nothing ->
            NotFound

        Just urlStr ->
            let
                frag =
                    Maybe.withDefault "" urlStr.fragment

                urlStr2 =
                    { urlStr
                        | path =
                            if String.left 1 frag == "/" then
                                String.dropLeft 1 frag

                            else
                                ""
                    }
            in
            Maybe.withDefault NotFound (parse routeParser urlStr2)


defaultView =
    { title = "jeovazero", body = List.map toUnstyled mainView }


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Blog ->
            { defaultView | body = [ div [] [ text "blog" ] ] }

        Init arg ->
            defaultView

        NotFound ->
            { defaultView | body = List.map toUnstyled [ globalCss, NotFoundPage.view ] }


mainView =
    [ globalCss
    , Home.view
    , Projects.view
    , About.view
    , Footer.view
    ]
