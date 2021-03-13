
; procedure animation v6 - 06/2015 - pb 5.30LTS

;{ declare
Declare Layer_FreeAll() : Declare Layer_Add(x=0,y=0,text$="") : Declare Layer_Clear(i,onlyAlpha=0) : Declare Layer_UpdateList(u=-1) : Declare Layer_Update(i)
Declare Layer_convertToBm(i) : Declare Layer_bm2(i) : Declare Layer_importImage(update=1) : Declare Layer_GetBm(id) : Declare Layer_DrawAll()
Declare Layer_ValidChange(Action) : Declare Layer_Rotate(i,angle)

Declare UpdateBrushPreview() : Declare BrushUpdateImage(load=0,color=0) : Declare OpenPresetBank() :

Declare UpdateColorFG()
Declare ScreenUpdate(updateLayer=0)
Declare.l ColorBlending(Couleur1.l, Couleur2.l, Echelle.f) : Declare.l RotateImageEx2(ImageID, Angle.f, Mode.a=2)

Declare PaperInit(load=1) : Declare PaperDraw() : Declare IE_StatusBarUpdate() : 
Declare IE_UpdatePaperList()

Declare GetColor(x,y) : Declare BrushUpdateColor() : Declare BrushResetColor()
Declare SpriteToImage(Sprite)
;}


;{ util

;sprite
Procedure FreeSprite2(sprite)
  
  If IsSprite(sprite)
    FreeSprite(sprite)
  EndIf
  
EndProcedure

; images
Procedure ImageLoad2(nb,file$,w=25,h=25)
  
  Result = LoadImage(nb,file$)
  
  If Result = 0
    MessageRequester("Error", "Impossible d'ouvrir l'image "+file$)
    If CreateImage(nb,w,h,32)   = 0
      MessageRequester("Error", "Unable to create an image !")
      End
    EndIf
  EndIf

EndProcedure
Procedure CreateImage2(img,w,h,error$,d=24,t=0)
  
  Result = CreateImage(img,w,h,d,t)
  
  If Result = 0
    MessageRequester("Error","Unable to create image : ")
    End  
  EndIf
  
  ProcedureReturn Result
EndProcedure
Procedure FreeImage2(img)
  
  If IsImage(img)
    FreeImage(img)
  EndIf
  
EndProcedure

; text
Procedure DrawTextEx(x.f,y.f,text$, couleur.l=0,lineHeight.w=19)  
  Protected nbLine.i=1 ; il y a au moins une ligne
  newtxt${#MaxTxt} = text$
  nbLine + CountString(newtxt$,Chr(13)) ; Nombre de "saut" , au moins 1 
   For i = 1 To nbLine
    Line$ = StringField(newtxt$,i,Chr(13)) ; on découpe entre les chr(10)
    DrawText(x, y + ( (i-1)*lineHeight), Line$, couleur);,$0,$FFFFFF) ; On affiche , et on ajuste suivant l'itérateur 'i' et la hauteur de ligne
  Next
EndProcedure

;}



XIncludeFile "procedures\menu.pbi" ; menu, file, edition..

XIncludeFile "procedures\history.pbi" ; script, history

XIncludeFile "procedures\swatch.pbi"

XIncludeFile "procedures\gadgets.pbi"

XIncludeFile "procedures\brush.pbi"

XIncludeFile "procedures\image.pbi"

XIncludeFile "procedures\imgfilters.pbi"

XIncludeFile "procedures\paint.pbi"

XIncludeFile "procedures\layer.pbi"


;{ Screen & sprites

Procedure MyWindowCallback(WindowID, Message, wParam, lParam)
  
  
  Result = #PB_ProcessPureBasicEvents
  
  If Message = #WT_PACKET
    If WTPacket(lParam,wParam, @pkt.PACKET)
      ;WTPacket(lParam,wParam, 0)
      
      If (pkt\pkX = pkX_old) And (pkt\pkY = pkY_old) And (pkt\pkNormalPressure = pkNormalPressure_old)
        ProcedureReturn 0
      EndIf
      
      ;SetGadgetText(#textinfo,"pkButtons: "       + RSet(Hex(pkt\pkButtons),8,"0") )
      ;SetGadgetText(#textinfo+1,"pkX: "               + Str(pkt\pkX               ))
      ;SetGadgetText(#textinfo+2,"pkY: "               + Str(pkt\pkY               ))
      ;SetGadgetText(#textinfo+3,"pkZ: "               + Str(pkt\pkZ               ))
      ;SetGadgetText(#textinfo+4,"pkNormalPressure: "  + Str(pkt\pkNormalPressure  ))
      ;SetGadgetText(#textinfo+5,"pkTangentPressure: " + Str(pkt\pkTangentPressure ))
      
      If pkt\pkNormalPressure
        LastElement( Pakets() )
        AddElement ( Pakets() )
        Pakets() = pkt                 
      EndIf
      
      pkX_old              = pkt\pkX
      pkY_old              = pkt\pkY
      pkNormalPressure_old = pkt\pkNormalPressure
    EndIf
    ProcedureReturn 0
  EndIf
  
  ProcedureReturn Result
EndProcedure


; utile sprite
Procedure SpriteToImage(Sprite)
  
  W =SpriteWidth(Sprite)  
  H =SpriteHeight(Sprite)
  
  If StartDrawing(SpriteOutput(Sprite))
 
  buffer=DrawingBuffer()
  Bytes=DrawingBufferPitch()
  
  For i = 0 To w-1
    For j = 0 To h-1
      
    Next 
  Next 
  
  
  StopDrawing()
  EndIf
 
EndProcedure
Procedure SpriteToImage2(Sprite)
  hDC=StartDrawing(SpriteOutput(Sprite))
  bmp.BITMAP\bmWidth=SpriteWidth(Sprite)
  bmp\bmHeight=SpriteHeight(Sprite)
  bmp\bmPlanes=1
  bmp\bmBitsPixel=GetDeviceCaps_(hDC,#BITSPIXEL)
  bmp\bmBits=DrawingBuffer()
  bmp\bmWidthBytes=DrawingBufferPitch()
  hBmp=CreateBitmapIndirect_(bmp)
  StopDrawing()
  ;Debug hBmp
  ProcedureReturn hBmp
EndProcedure
Procedure CreateSelection()
  
  FreeSprite2(#Sp_Select)
  
  If CreateSprite(#Sp_Select, OptionsIE\SelectionW,  OptionsIE\SelectionH,#PB_Sprite_AlphaBlending)
    
    If StartDrawing(SpriteOutput(#Sp_Select))
      DrawingMode(#PB_2DDrawing_AllChannels)
      Box(0,0,OptionsIE\SelectionW,OptionsIE\SelectionH,RGBA(0,0,0,0))
      
      DrawingMode(#PB_2DDrawing_Outlined)
      ; la sélection
      ;If OptionsIE\Selection = 1
         Box(0,0,OptionsIE\SelectionW,OptionsIE\SelectionH,RGBA(255,0,0,255))
      ;EndIf
      StopDrawing()
    EndIf
    
  EndIf
  
EndProcedure

; screen
Macro Drawselection()
  
  If OptionsIE\Selection = 2
    ZoomSprite(#Sp_Select, OptionsIE\SelectionW*z,OptionsIE\SelectionH*z)
    ;SpriteBlendingMode(#PB_Sprite_BlendSourceAlpha, #PB_Sprite_BlendInvertSourceAlpha)
    ;DisplayTransparentSprite(#Sp_Select,canvasX+OptionsIE\SelectionX*z,canvasY+OptionsIE\SelectionY*z)
    SpriteBlendingMode(#PB_Sprite_BlendInvertDestinationColor, #PB_Sprite_BlendInvertSourceColor)
    DisplayTransparentSprite(#Sp_Select,canvasX+OptionsIE\SelectionX*z,canvasY+OptionsIE\SelectionY*z)
  EndIf
  
EndMacro
Procedure ScreenDraw()
  
  z.d = OptionsIE\zoom * 0.01

    ; on update le screen
  ClearScreen(RGB(120,120,120))
  ; the paper
  PaperDraw()
  
  ; les calques
  Layer_DrawAll()
  
  ; les utilitaires
  
  ; sélection, cadre (quand transform par exemple)
  Layer_DrawBorder(LayerId) 
  DrawSelection()
 

EndProcedure

Procedure ScreenUpdate(updateLayer=0)
 z.d = OptionsIE\zoom * 0.01
  w = Layer(Layerid)\w
  h = Layer(Layerid)\h
  
  If updateLayer=1 ; si on a besoin d'updater le layer (on change de blendmode)
    
    If StartDrawing(ImageOutput(layer(LayerId)\ImageBM))
      ; d'abord on efface l'image
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      Box(0,0,w,h,RGBA(0,0,0,0))
      
      SetBm(LayerId,0)
      
      StopDrawing()
      
    EndIf
    
  EndIf
    
  If NewPainting = 1
    NewPainting = 0
    
     If layer(layerId)\bm = #Bm_Normal
      alpha= 255
    Else
      alpha = layer(layerId)\Alpha 
    EndIf
        If StartDrawing(SpriteOutput(layer(LayerId)\Sprite))
       ; on l'efface 
      DrawingMode(#PB_2DDrawing_AlphaChannel)    
      Box(0,0,w,h,RGBA(0,0,0,0))
      
      DrawingMode(#PB_2DDrawing_AllChannels)
      ; puis on redessine tout
      Select layer(LayerId)\bm 
          
        Case #Bm_Custom,  #Bm_Add, #Bm_Clearlight, #Bm_Screen, #Bm_Colorlight, #Bm_Lighten, #Bm_LinearLight
          Box(0,0,w,h,RGBA(0,0,0,255))
          DrawingMode(#PB_2DDrawing_AlphaChannel)    
          Box(0,0,w,h,RGBA(0,0,0,0))

          ; DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0)
          ; DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0, Alpha)
          
        Case #Bm_Multiply,#Bm_ColorBurn, #Bm_Darken
          Box(0,0,w,h,RGBA(255,255,255,255))
          DrawingMode(#PB_2DDrawing_AlphaChannel)    
          Box(0,0,w,h,RGBA(255,255,255,0))
           
        Case #bm_overlay
          Box(0,0,w,h,RGBA(0,0,0,255))
          ;DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
          ;DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0,layer(layerid)\alpha)
          
        Default 
          Box(0,0,w,h,RGBA(255,255,255,255-layer(LayerId)\alpha))
;           DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
;           ;DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0,layer(layerid)\alpha)
          
      EndSelect
      
      ; on l'efface 
      ; DrawingMode(#PB_2DDrawing_AlphaChannel)    
      ; Box(0,0,w,h,RGBA(0,0,0,0))
      
      
      If layer(layerid)\MaskAlpha =1
        DrawingMode(#PB_2DDrawing_AlphaChannel)
        DrawAlphaImage(ImageID(Layer(i)\ImageAlpha),0,0)   
        DrawingMode(#PB_2DDrawing_CustomFilter)
        CustomFilterCallback(@Filtre_MaskAlpha())
      Else
        DrawingMode(#PB_2DDrawing_AlphaBlend)
      EndIf
      
      Select layer(LayerId)\bm 
          
        Case #Bm_Custom,  #Bm_Add, #Bm_Clearlight, #Bm_Screen, #Bm_Colorlight, #Bm_Lighten, #Bm_LinearLight
           DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0)
          ; DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0, Alpha)
          
        Case #Bm_Multiply
          DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
          
        Case #bm_overlay
          Box(0,0,w,h,RGBA(0,0,0,255))
          DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
          ;DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0,layer(layerid)\alpha)
          
        Default 
          Box(0,0,w,h,RGBA(255,255,255,255-layer(LayerId)\alpha))
           DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
;           ;DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0,layer(layerid)\alpha)
          
      EndSelect
      
      DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0, Alpha)


      StopDrawing()
    EndIf
    
  EndIf
  
  ScreenDraw()  
  
  ; on affiche l'ecran
  FlipBuffers()
  
EndProcedure
    
Procedure ScreenUpdate2(updateLayer=0)
  
  
  z.d = OptionsIE\zoom * 0.01
  w = Layer(Layerid)\w
  h = Layer(Layerid)\h
  
  If updateLayer=1 ; si on a besoin d'updater le layer (on change de blendmode)
    
    If StartDrawing(ImageOutput(layer(LayerId)\ImageBM))
      ; d'abord on efface l'image
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      Box(0,0,w,h,RGBA(0,0,0,0))
      
      SetBm(LayerId,0)
      
      StopDrawing()
      
    EndIf
    
  EndIf
    
  If NewPainting = 1
    NewPainting = 0
    
    Layer_UpdateImg()
    
    If layer(layerId)\bm = #Bm_Normal
      alpha= 255
    Else
      alpha = layer(layerId)\Alpha 
    EndIf
    
    ;FreeImage2(Layer(LayerId)\Image)
    ;Layer(LayerId)\Image = SpriteToImage(layer(LayerId)\Sprite) ; CopyImage(@layer(LayerId)\Sprite,#PB_Any)
;     sp = layer(LayerId)\Sprite
;     If StartDrawing(SpriteOutput(sp))
;       Layer(LayerId)\Image = GrabDrawingImage(#PB_Any,0,0,SpriteWidth(sp),SpriteHeight(sp))
;       StopDrawing()
;     EndIf
    
    
    If StartDrawing(SpriteOutput(layer(LayerId)\Sprite))
       ; on l'efface 
      DrawingMode(#PB_2DDrawing_AlphaChannel)    
      Box(0,0,w,h,RGBA(0,0,0,0))
      
      DrawingMode(#PB_2DDrawing_AllChannels)
      ; puis on redessine tout
      Select layer(LayerId)\bm 
          
        Case #Bm_Custom,  #Bm_Add, #Bm_Clearlight, #Bm_Screen, #Bm_Colorlight, #Bm_Lighten, #Bm_LinearLight
          Box(0,0,w,h,RGBA(0,0,0,255))
          DrawingMode(#PB_2DDrawing_AlphaChannel)    
          Box(0,0,w,h,RGBA(0,0,0,0))

          ; DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0)
          ; DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0, Alpha)
          
        Case #Bm_Multiply,#Bm_ColorBurn, #Bm_Darken
          Box(0,0,w,h,RGBA(255,255,255,255))
          DrawingMode(#PB_2DDrawing_AlphaChannel)    
          Box(0,0,w,h,RGBA(255,255,255,0))
           
        Case #bm_overlay
          Box(0,0,w,h,RGBA(0,0,0,255))
          ;DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
          ;DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0,layer(layerid)\alpha)
          
        Default 
          Box(0,0,w,h,RGBA(255,255,255,255-layer(LayerId)\alpha))
;           DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
;           ;DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0,layer(layerid)\alpha)
          
      EndSelect
      
      ; on l'efface 
      ; DrawingMode(#PB_2DDrawing_AlphaChannel)    
      ; Box(0,0,w,h,RGBA(0,0,0,0))
      
      
      If layer(layerid)\MaskAlpha =1
        DrawingMode(#PB_2DDrawing_AlphaChannel)
        DrawAlphaImage(ImageID(Layer(i)\ImageAlpha),0,0)   
        DrawingMode(#PB_2DDrawing_CustomFilter)
        CustomFilterCallback(@Filtre_MaskAlpha())
      Else
        DrawingMode(#PB_2DDrawing_AlphaBlend)
      EndIf
      
      Select layer(LayerId)\bm 
          
        Case #Bm_Custom,  #Bm_Add, #Bm_Clearlight, #Bm_Screen, #Bm_Colorlight, #Bm_Lighten, #Bm_LinearLight
           DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0)
          ; DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0, Alpha)
          
        Case #Bm_Multiply
          DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
          
        Case #bm_overlay
          Box(0,0,w,h,RGBA(0,0,0,255))
          DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
          ;DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0,layer(layerid)\alpha)
          
        Default 
          Box(0,0,w,h,RGBA(255,255,255,255-layer(LayerId)\alpha))
           DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
;           ;DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0,layer(layerid)\alpha)
          
      EndSelect
      
      DrawAlphaImage(ImageID(Layer(LayerId)\Image),0,0, Alpha)


      StopDrawing()
    EndIf
    
  EndIf
  
  ScreenDraw()  
  
  ; on affiche l'ecran
  FlipBuffers()
  
EndProcedure
Procedure ScreenZoom()
  
  IE_StatusBarUpdate()

  BrushUpdateImage(0,1)
  BrushUpdateColor()
  
  If NewPainting= 1    
    NewPainting = 0
    If StartDrawing(SpriteOutput(layer(LayerId)\Sprite))
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      Box(0,0,doc\w,doc\w,RGBA(0,0,0,0))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      DrawAlphaImage(ImageID(Layer(LayerId)\image),0,0)
      StopDrawing()
    EndIf
    
  EndIf
  
  ScreenDraw()
  
  FlipBuffers():; affiche l'ecran

EndProcedure
Procedure ResizeScreen(w,h)
  
  ScreenResized = 0
  
  CanvasW = w
  CanvasH = h
  
  For i = 0 To ArraySize(layer())-1
      FreeSprite2(layer(i)\Sprite)
  Next i
  
  FreeSprite2(#Sp_Paper)
    
  ; on ferme l'écran
  CloseScreen()
  
  If OpenWindowedScreen(WindowID(#WinMain),ScreenX,ScreenY,CanvasW,CanvasH)=0
    MessageRequester("Error","unable to open a new screen ! (Please report this bug with your OS and graphic card.)")
    End
  EndIf
  
  PaperInit(0)
  ResetAllSprites()
  
  For i = 0 To ArraySize(layer())-1
    layer(i)\Sprite = CreateSprite(#PB_Any, doc\w,doc\h,#PB_Sprite_AlphaBlending)
  Next i
  
  ; puis, j'update chaque layer
  For i = 0 To ArraySize(layer())-1
    NewPainting = 1
    LayerId = i
    ScreenUpdate(1)
  Next i
  
  
EndProcedure



;}


;{ linux
CompilerIf #PB_Compiler_OS = #PB_OS_Linux
  
  ; for the screen in a gadget
  Procedure XDisplayFromWindowID(*Window.GtkWidget) 
    *gdkwindowobj._GdkWindowObject = *Window\window
    *impl.GdkDrawableImplX11 = *gdkwindowobj\impl
    *screen.GdkScreenX11 = *impl\screen
    ProcedureReturn *screen\xdisplay       
  EndProcedure  
  
CompilerEndIf
;}


;{ Thread

Procedure AutoSave(Parameter)
  
  Repeat
    
    
    If OptionsIE\ImageHasChanged >= 1
      OptionsIE\ImageHasChanged = 0
      For i= 0 To ArraySize(layer())-1
        If layer(i)\Haschanged >= 1
          layer(i)\Haschanged = 0 
          Date$ = FormatDate("%yyyy_%mm_%dd", Date()) 
          ;Debug "save\AutoSave_"+Date$+"_"+layer(i)\Name$+"_"+Str(i)+".png"
          If SaveImage(layer(i)\Image, GetCurrentDirectory() + "save\AutoSave_"+Date$+"_"+layer(i)\Name$+"_"+Str(i)+".png",#PB_ImagePlugin_PNG)
          EndIf
        EndIf      
      Next i
      Delay(40000); toutes les minutes, on sauvegarde l'image, uniquement si elle a changée
    EndIf
    
    ; si elle n'a pas changé, on revérifie toutes les 10 s
    Delay(10000) ; mettre un délai ici pour éviter de bouffer le tps processeur
    ;Debug "autosave"
    
  ForEver

EndProcedure


;}

XIncludeFile "procedures\window.pbi"



; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 339
; Folding = AACAAAAAAAg
; EnableUnicode
; EnableXP
; Executable = ..\_old\animatoon_screen0.22.exe
; SubSystem = openGL
; DisableDebugger