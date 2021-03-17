
If UsePNGImageDecoder()=0 Or UseJPEGImageDecoder()=0 Or UsePNGImageEncoder()=0 Or UseJPEGImageEncoder()=0 Or UseTGAImageDecoder()=0 ; Or UseTIFFImageDecoder()=0
  MessageRequester(Lang("Error"),"image Decoder/encoder error")
  AddLogError(1, info$)
  End
EndIf



If OptionsIE\Theme$ = ""
  OptionsIE\Theme$ = "data\Themes\Animatoon"
EndIf

; !!!! ATTENTION, I have to test all images, and use AddLogError() if I have any error !!! 

LoadImage(#ico_New,   OptionsIE\Theme$ +"\icones\new.png")
LoadImage(#ico_Merge, OptionsIE\Theme$ +"\icones\merge.png")
LoadImage(#ico_Open,  OptionsIE\Theme$ +"\icones\open.png")
LoadImage(#ico_Save,  OptionsIE\Theme$ +"\icones\save.png")
LoadImage(#ico_Export,OptionsIE\Theme$ +"\icones\export.png")
LoadImage(#ico_Ok,    OptionsIE\Theme$ +"\icones\ok.png")
LoadImage(#ico_Prop,  OptionsIE\Theme$ +"\icones\action.png")



If LoadImage(#Img_Checker,  "data/paper/paper0.png") = 0
  MessageRequester(lang("Error"), Lang("Unable to load the paper0.png"))
  If CreateImage(#Img_Checker, 64, 64) = 0
    MessageRequester(lang("Error"), Lang("Unable to create the image checker"))
  EndIf
  
EndIf






;{ toolbar
LoadImage(#ico_IE_Pen,    OptionsIE\Theme$ +"\icones\pen.png")
LoadImage(#ico_IE_Brush,  OptionsIE\Theme$ +"\icones\brush.png")

LoadImage(#ico_IE_Line,   OptionsIE\Theme$ +"\icones\line.png" )
LoadImage(#ico_IE_Box,    OptionsIE\Theme$ +"\icones\box.png")
LoadImage(#ico_IE_Circle, OptionsIE\Theme$ +"\icones\Circle.png")
LoadImage(#ico_IE_Fill,   OptionsIE\Theme$ +"\icones\fill.png" )
LoadImage(#ico_IE_Clear,  OptionsIE\Theme$ +"\icones\clear.png")
LoadImage(#ico_IE_Eraser, OptionsIE\Theme$ +"\icones\eraser.png")



LoadImage(#ico_IE_Pipette, OptionsIE\Theme$ +"\icones\colorpicker.png")
LoadImage(#ico_IE_Spray,   OptionsIE\Theme$ +"\icones\spray.png")
LoadImage(#ico_IE_Move,    OptionsIE\Theme$ +"\icones\move.png")
LoadImage(#ico_IE_Scale,   OptionsIE\Theme$ +"\icones\scale.png")


LoadImage(#ico_IE_Hand,       OptionsIE\Theme$ +"\icones\hand.png")
LoadImage(#ico_IE_Select,     OptionsIE\Theme$ +"\icones\select.png")
LoadImage(#ico_IE_Zoom,       OptionsIE\Theme$ +"\icones\zoom.png")
LoadImage(#ico_IE_Shape,      OptionsIE\Theme$ +"\icones\shape.png")
LoadImage(#ico_IE_Tampon,     OptionsIE\Theme$ +"\icones\pattern.png")
LoadImage(#ico_IE_Particles,  OptionsIE\Theme$ +"\icones\particles.png")
LoadImage(#ico_IE_Gradient,   OptionsIE\Theme$ +"\icones\gradient.png")
LoadImage(#ico_IE_Rotate,     OptionsIE\Theme$ +"\icones\rotate.png")
LoadImage(#ico_IE_Text,       OptionsIE\Theme$ +"\icones\text.png")
;}


; layer icones
LoadImage(#ico_LayerView,     OptionsIE\Theme$ +"\icones\view.png")
LoadImage(#ico_LayerLocked,   OptionsIE\Theme$ +"\icones\locked.png")
LoadImage(#ico_LayerLockAlpha,OptionsIE\Theme$ +"\icones\lockAlpha.png")
LoadImage(#ico_LayerLockMove, OptionsIE\Theme$ +"\icones\lockMove.png")
LoadImage(#ico_LayerLockPaint,OptionsIE\Theme$ +"\icones\lockPaint.png")
LoadImage(#ico_LayerUp,       OptionsIE\Theme$ +"\icones\up.png")
LoadImage(#ico_LayerDown,     OptionsIE\Theme$ +"\icones\down.png")
LoadImage(#ico_LayerMask,     OptionsIE\Theme$ +"\layerbtn3.jpg")

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 28
; Folding = -
; EnableXP
; EnableUnicode