module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url



-- MAIN


main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }



-- MODEL


type alias Model =
  { key : Nav.Key
  , url : Url.Url
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  ( Model key url, Cmd.none )



-- UPDATE


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | url = url }
      , Cmd.none
      )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
  { title = "URL Interceptor"
  , body =
      [ sideNav
      ]
  }


sideNav : Html msg
sideNav =
  div [ class "wrapper" ]
    [ nav [ id "sidebar" 
          , style "width" "240px"
          , style "position" "fixed"
          , style "top" "0"
          , style "left" "0"
          , style "height" "100vh"
          , style "z-index" "999"
          , style "background" "#1B1D29"
          , style "color" "#D1D2D4"
          , style "transition" "all 0.3s"
          ]
        [ ul [ class "list-unstyled components" ]
            [ p [] 
                [ text "Dummy Heading" 
                , li [] [ a [ href "#" ] [ text "Dashboard" ] ]
                , li [] [ a [ href "#" ] [ text "Merchants" ] ]
                , li [] [ a [ href "#" ] [ text "Invoices" ] ]
                ]
            ]
        ]
    ]