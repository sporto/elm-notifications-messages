module Mod1 exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Notifications exposing (newNotification)


type alias Model =
    String


type Msg
    = ShowNotification


init =
    ( "", Cmd.none )


view model =
    div []
        [ button [ onClick ShowNotification ] [ text "Notification" ]
        , text model
        ]


update msg model =
    case msg of
        ShowNotification ->
            let
                notification =
                    newNotification "Hello from 1"
            in
                ( "With Notification", Cmd.none, OpenNotification notification )
