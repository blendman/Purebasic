
; check If there is no error With keyboard And screen.
If InitKeyboard()=0
  MessageRequester(LAng("error"), lang("Keyboard error"))
  AddLogError(1, lang("Error InitKeyboard()"))
  End
EndIf

If InitSprite() = 0
  MessageRequester(LAng("error"), lang("Sprite system error (direct X or OpenGL error)"))
  AddLogError(1, lang("Error InitSprite()"))
  End
EndIf


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 10
; Folding = -
; EnableXP
; Warnings = Display
; EnablePurifier
; EnableUnicode