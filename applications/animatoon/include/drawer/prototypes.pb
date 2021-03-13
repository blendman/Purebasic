

; prototypes
Prototype.l WTInfo_(wCategory, nIndex, *lpOutput)
Prototype.l WTOpen_(hWnd, *lpLogCtx, fEnable)
Prototype.l WTPacket_(hCtx, wSerial, *lpPkt)
Prototype.l WTClose_(hCtx)
Prototype.l WTQueueSizeSet_(hCtx, size.l)

; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 1
; EnableUnicode
; EnableXP