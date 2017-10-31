module Notifications exposing (..)

import Html exposing (..)


type Msg
    = Msg


type alias Notification =
    { id : String
    , message : String
    }


type alias Model =
    { notifications : List Notification
    }


init : ( Model, Cmd msg )
init =
    ( { notifications = []
      }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    div []
        (List.map notification model.notifications)


notification : Notification -> Html Msg
notification notification =
    div []
        [ text notification.message
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
