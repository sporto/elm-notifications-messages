module Main exposing (..)

import Html exposing (..)
import Mod1
import Mod2
import Notifications


-- MODELS


type alias Model =
    { mod1 : Mod1.Model
    , mod2 : Mod2.Model
    , notifications : Notifications.Model Msg
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
        [ Html.map Mod1Msg (Mod1.view model.mod1)
        , Html.map Mod2Msg (Mod2.view model.mod2)
        , Notifications.view model.notifications
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mod1Msg sub ->
            let
                ( mod, cmd, action ) =
                    Mod1.update sub model.mod1

                notifications =
                    case action of
                        Mod1.OpenNotification notification ->
                            notification
                                |> Notifications.mapMsg Mod1Msg
                                |> Notifications.add model.notifications

                        Mod1.CloseNotification id ->
                            Notifications.dismiss model.notifications id

                        _ ->
                            model.notifications

                updatedModel =
                    { model
                        | mod1 = mod
                        , notifications = notifications
                    }
            in
                ( updatedModel, Cmd.map Mod1Msg cmd )

        Mod2Msg sub ->
            let
                ( mod, cmd ) =
                    Mod2.update sub model.mod2
            in
                ( { model | mod2 = mod }, Cmd.map Mod2Msg cmd )

        NotificationMsg sub ->
            let
                -- actionsMapper =
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
