

Declare Layer_FreeAll()
Declare Layer_Add(x=0,y=0,text$="") 
Declare Layer_Clear(i,onlyAlpha=0) 
Declare Layer_UpdateList(u=-1) 
Declare Layer_Update(i)
Declare Layer_convertToBm(i) 
Declare Layer_bm2(i)  
Declare Layer_importImage(update=1)  
Declare Layer_GetBm(id)  
Declare Layer_DrawAll()
Declare Layer_ValidChange(Action,i=-1)  
Declare Layer_Rotate(i,angle)
Declare IE_UpdateLayerUi() 
Declare Layer_updateUi(i)


Declare UpdateBrushPreview()  
Declare BrushUpdateImage(load=0,color=0) 
Declare OpenPresetBank() 
Declare BrushChangeColor(change=0,color=-1)

; image processing
Declare UpdateColorFG()
Declare ScreenUpdate(updateLayer=0)
Declare.l ColorBlending(Couleur1.l, Couleur2.l, Echelle.f) 
Declare.l RotateImageEx2(ImageID, Angle.f, Mode.a=2)

; paper
Declare PaperInit(load=1) 
Declare PaperDraw() 
Declare IE_StatusBarUpdate() ; statusbar 
Declare IE_UpdatePaperList()

; brush color
Declare GetColor(x,y) 
Declare BrushUpdateColor()
Declare BrushResetColor()


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 3
; FirstLine = 12
; EnableXP
; EnableUnicode