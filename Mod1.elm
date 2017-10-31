module Mod1 exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Notifications exposing (Notification, newNotification)


type alias Model =
    String


type Msg
    = ShowNotification
    | DoNotificationAction


type Action action
    = NoAction
    | OpenNotification (Notification action)
    | CloseNotification String


init =
    ( "", Cmd.none )


view model =
    div []
        [ h2 [] [ text "Mod1" ]
        , button [ onClick ShowNotification ] [ text "Notification" ]
        , text model
        ]


notificationId =
    "mod1Not"


update : Msg -> Model -> ( Model, Cmd Msg, Action Msg )
update msg model =
    case msg of
        DoNotificationAction ->
            -- Dismiss notification here
            ( "Action done", Cmd.none, CloseNotification notificationId )

        ShowNotification ->
            let
                action =
                    DoNotificationAction

                notification =
                    newNotification notificationId "Hello from 1" action
            in
                ( "Notification pending", Cmd.none, OpenNotification notification )
