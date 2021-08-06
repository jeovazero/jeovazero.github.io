module About exposing (view)

import Common.Elements
    exposing
        ( centerContentContainer
        , contentContainer
        , titleSection
        )
import Common.Styles
    exposing
        ( bgBlack
        , myFontFamily
        , textLeft
        )
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, id, src, style)



-- ABOUT


aboutTextData =
    [ """
      Meu nome é Jeova "ZERO", gosto de matemática, programação competitiva e programação funcional.
      """
    ]


textWrapper t =
    p
        [ css
            [ myFontFamily.ropaSans
            , fontSize (rem 1.2)
            , lineHeight (rem 1.8)
            , letterSpacing (px 1)
            , textAlign left
            ]
        ]
        [ text t ]


aboutTextContainer =
    div []
        (List.map textWrapper aboutTextData)



-- VIEW


view : Html msg
view =
    div [ css [ bgBlack, textLeft ] ]
        [ centerContentContainer []
            [ contentContainer []
                [ titleSection { id_ = "about", text_ = "Sobre" }
                , aboutTextContainer
                ]
            ]
        ]
