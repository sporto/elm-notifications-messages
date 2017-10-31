module Main exposing (..)

import Html exposing (..)
import Mod1
import Mod2
import Notifications


-- MODELS


type alias Model =
    { mod1 : Mod1.Model
    , mod2 : Mod2.Model
    , notifications : Notifications.Model
    }



-- MSGs


type Msg
    = Mod1Msg Mod1.Msg
    | Mod2Msg Mod2.Msg
    | NotificationMsg Notifications.Msg



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        ( mod1, cmd1 ) =
            Mod1.init

        ( mod2, cmd2 ) =
            Mod2.init

        ( not, cmdNot ) =
            Notifications.init
    in
        ( { mod1 = mod1
          , mod2 = mod2
          , notifications = not
          }
        , Cmd.none
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEWS


view : Model -> Html Msg
view model =
    div []
        [ Html.map NotificationMsg (Notifications.view model.notifications)
        , Html.map Mod1Msg (Mod1.view model.mod1)
        , Html.map Mod2Msg (Mod2.view model.mod2)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mod1Msg sub ->
            let
                ( mod, cmd ) =
                    Mod1.update sub model.mod1
            in
                ( { model | mod1 = mod }, Cmd.map Mod1Msg cmd )

        Mod2Msg sub ->
            let
                ( mod, cmd ) =
                    Mod2.update sub model.mod2
            in
                ( { model | mod2 = mod }, Cmd.map Mod2Msg cmd )

        NotificationMsg sub ->
            let
                ( notifications, cmd ) =
                    Notifications.update sub model.notifications
            in
                ( { model | notifications = notifications }, Cmd.map NotificationMsg cmd )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
