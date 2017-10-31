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
        [ h2 [] [ text "Mod2" ]
        ]


update msg model =
    ( model, Cmd.none )
