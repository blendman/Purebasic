
; prototypes (for tablette (wacom) ?)

Prototype.l WTInfo_(wCategory, nIndex, *lpOutput)
Prototype.l WTOpen_(hWnd, *lpLogCtx, fEnable)
Prototype.l WTPacket_(hCtx, wSerial, *lpPkt)
Prototype.l WTClose_(hCtx)
Prototype.l WTQueueSizeSet_(hCtx, size.l)

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 1
; EnableXP
; EnableUnicode