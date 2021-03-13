
If UsePNGImageDecoder() And UsePNGImageEncoder() And UseJPEGImageDecoder() And UseJPEGImageEncoder()
EndIf


  CatchImage(#ico_New,  ?ico_new)
  CatchImage(#ico_Open, ?ico_open)
  CatchImage(#ico_Save, ?ico_save)
  CatchImage(#ico_Ok,   ?ico_Ok)
  
  ;{ Image editor
  ;CatchImage(#ico_OpenIE,     ?ico_OpenIE)
  CatchImage(#ico_IE_Pen,     ?ico_IE_Pen)
  CatchImage(#ico_IE_Brush,   ?ico_IE_Brush)
  CatchImage(#ico_IE_Line,    ?ico_IE_Line)
  CatchImage(#ico_IE_Box,     ?ico_IE_Box)
  CatchImage(#ico_IE_Circle,  ?ico_IE_Circle)
  CatchImage(#ico_IE_Fill,    ?ico_IE_Fill)
  CatchImage(#ico_IE_Clear,   ?ico_IE_Clear)
  CatchImage(#ico_IE_Eraser,  ?ico_IE_Eraser)
  CatchImage(#ico_IE_Pipette, ?ico_IE_Pipette)
  CatchImage(#ico_IE_Spray,   ?ico_IE_Spray)
  CatchImage(#ico_IE_Move,    ?ico_IE_Move)
  CatchImage(#ico_IE_Hand,    ?ico_IE_Hand)
  CatchImage(#ico_IE_Select,  ?ico_IE_Select)
  CatchImage(#ico_IE_Zoom,    ?ico_IE_Zoom)
  CatchImage(#ico_IE_Shape,   ?ico_IE_Shape)
  CatchImage(#ico_IE_Tampon,  ?ico_IE_Tampon)
  CatchImage(#ico_IE_Particles,   ?ico_IE_Particles)
  CatchImage(#ico_IE_Gradient,    ?ico_IE_Gradient)
  
  
  
  ; layer icones
  CatchImage(#ico_LayerView,        ?ico_IE_View)
  CatchImage(#ico_LayerLocked,      ?ico_IE_Locked)
  CatchImage(#ico_LayerLockAlpha,   ?ico_IE_LockAlpha)
  CatchImage(#ico_LayerLockMove,    ?ico_IE_LockMove)
  CatchImage(#ico_LayerLockPaint,   ?ico_IE_LockPaint)
  CatchImage(#ico_LayerUp,          ?ico_IE_LayerUp)
  CatchImage(#ico_LayerDown,        ?ico_IE_LayerDown)
  
  
  
  ;}
  
  
; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 46
; Folding = -
; EnableUnicode
; EnableXP