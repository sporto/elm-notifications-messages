module Mod1 exposing (..)

import Html exposing (..)


type alias Model =
    String


type Msg
    = NoOp


init =
    ( "Two", Cmd.none )


view model =
    div []
        [ text model
        ]


update msg model =
    ( model, Cmd.none )
