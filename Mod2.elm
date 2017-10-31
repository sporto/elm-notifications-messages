module Mod2 exposing (..)

import Html exposing (..)


type alias Model =
    String


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( "One", Cmd.none )


view model =
    div []
        [ text model
        ]


update msg model =
    ( model, Cmd.none )
