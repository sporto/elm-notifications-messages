module Notifications exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


type Msg
    = Msg


type alias Notification action =
    { id : String
    , message : String
    , action : action
    }


type alias Model action =
    { notifications : List (Notification action)
    }


init : ( Model action, Cmd msg )
init =
    ( { notifications = []
      }
    , Cmd.none
    )


view : Model action -> Html action
view model =
    div []
        [ h2 [] [ text "Notifications" ]
        , div [] (List.map notification model.notifications)
        ]


notification : Notification action -> Html action
notification notification =
    div []
        [ button [ onClick notification.action ] [ text notification.message ]
        ]


update : Msg -> Model action -> ( Model action, Cmd Msg )
update msg model =
    ( model, Cmd.none )


newNotification : String -> String -> action -> Notification action
newNotification message id action =
    { id = id
    , message = message
    , action = action
    }


mapMsg constructor notification =
    { notification
        | action = constructor notification.action
    }


add : Model action -> Notification action -> Model action
add model notification =
    { model | notifications = notification :: model.notifications }


dismiss : Model action -> String -> Model action
dismiss model id =
    { model | notifications = [] }
