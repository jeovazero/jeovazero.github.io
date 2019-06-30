module AnchorSmoothScroll exposing (Msg(..), init, resetModel, setScroll, Model, update, subscription)

import Task
import Time
import Browser.Dom
import Browser.Events exposing (onAnimationFrame)
import Debug


type alias Model =
    { isRun : Bool
    , initialOffset : Float
    , offsetDiff : Float
    , initialTime : Int
    }


type Msg = 
    InitScroll Float Float Time.Posix
    | Scrolling Time.Posix
    | NoOp




-- Update


update : Model -> Msg -> (Model, Cmd Msg)
update model msg =
    case msg of
        InitScroll finalOffset initialOffset timePosix ->
            ( { isRun = True
              , initialOffset = initialOffset
              , offsetDiff = finalOffset - initialOffset
              , initialTime = Time.posixToMillis timePosix
              }
            , Cmd.none
            )

        Scrolling timePosix -> 
            let
                { offsetDiff, initialOffset, initialTime } =
                    model

                elapsed =
                    Time.posixToMillis timePosix - initialTime

                progress =
                    min ((elapsed |> toFloat) / 500) 1.0

                easing =
                    cubicOut progress

                nextOffset =
                    offsetDiff * easing + initialOffset
            in
            if progress < 1.0 then
                ( model, setScroll nextOffset )

            else
                ( resetModel, Cmd.none )

        NoOp ->
            ( model, Cmd.none )




init : Float -> Float -> Cmd Msg
init finalOffset initialOffset =
    Task.perform (InitScroll finalOffset initialOffset) Time.now



resetModel : Model
resetModel = Model False 0 0 0




setScroll : Float -> Cmd Msg
setScroll offsetY =
    Task.perform (\_ -> NoOp) (Browser.Dom.setViewport 0 offsetY)



-- Easing function


cubicOut t =
    let
        x =
            t - 1
    in
    x * x * x + 1



-- Subscription


subscription : Model -> Sub Msg
subscription model =
    case model.isRun of
        True ->
            onAnimationFrame Scrolling

        False ->
            Sub.none

