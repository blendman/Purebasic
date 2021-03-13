
; roughboard.pbi
; pb : 5.31
; by blendman 
; animatoon 0.57


Procedure RBExport()
  
  ; export a roughboard (scratch board to try our colour for example)
  
  file$ = SaveFileRequester(Lang("Save Roughboard Image"),"","JPG|*.jpg|PNG|*.png",0)
  If file$ <> ""
    ext$ = GetExtensionPart(file$)
    If ext$ <> "png" Or ext$ <> "jpg" 
      index = SelectedFilePattern()
      If index = 0
        File$+".jpg"
      Else
        File$+".png"
      EndIf
    EndIf
    OptionsIE\RB_Img$ = File$
    Debug  OptionsIE\RB_Img$
    Format = SelectFormat(file$) 
    Debug format
    If SaveImage(#image_RB, OptionsIE\RB_Img$,format) : EndIf
  EndIf

EndProcedure
                    
; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 3
; Folding = 9
; EnableXP
; EnableUnicode