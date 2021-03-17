
; variables
Global ScreenX.w, ScreenY.w, NewPainting.a, canvasX.w, canvasY.w, ScreenResized
ScreenX = 165
ScreenY = 40

Global MouseX_Old.d, MouseY_Old.d, x, y, mx, my, LayerId.a, CanvasW.w, CanvasH.w

Global blend1,blend2 ; temporary // temporaire
; Global xx,yy,StartX1,StartY1

;{ for tablet (wacom or other)
Global WTInfo.WTInfo_
Global WTOpen.WTOpen_
Global WTPacket.WTPacket_
Global WTClose.WTClose_
Global WTQueueSizeSet.WTQueueSizeSet_
Global pkY_old, pkX_old, pkNormalPressure_old
Global NewList Pakets.PACKET()
;}

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 11
; Folding = -
; EnableXP
; EnableUnicode