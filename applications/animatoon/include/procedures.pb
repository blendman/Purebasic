
; procedure animation v6 - 06/2015 - pb 5.30LTS

; declare
XIncludeFile "procedures\declare.pbi"


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
  Else
    ProcedureReturn Result
  EndIf

EndProcedure
Procedure CreateImage2(img,w,h,img$,d=24,t=0)
  
  Result = CreateImage(img,w,h,d,t)
  
  If Result = 0
    MessageRequester("Error","Unable to create image : "+img$)
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
Procedure DrawTextEx(x.f,y.f,text$, couleur.l=0, lineHeight.w=19)  
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

XIncludeFile "procedures\roughboard.pbi"

XIncludeFile "procedures\gadgets.pbi" ; + paper

XIncludeFile "procedures\brush.pbi"

XIncludeFile "procedures\image.pbi"

XIncludeFile "procedures\imgfilters.pbi"

XIncludeFile "procedures\paint.pbi"

XIncludeFile "procedures\layer.pbi"

XIncludeFile "procedures\selection.pbi"


;{ Screen & sprites


Procedure FPS()
  Shared s, fps
  ss=Second(Date())
  fps+1
  If s<>ss
    s=ss
    SetWindowTitle(0,"Animatoon "+#ProgramVersion+" - "+doc\name$+" - FPS: "+Str(FPS)+
                     " /stroke :"+Str(strokeId)+"/"+Str(ArraySize(Stroke(strokeID)\dot())))
    fps=0
  EndIf
  
EndProcedure


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
Macro DrawUtil()
  
  If OptionsIE\Selection = 2
    ZoomSprite(#Sp_Select, OptionsIE\SelectionW*z,OptionsIE\SelectionH*z)
    ;SpriteBlendingMode(#PB_Sprite_BlendSourceAlpha, #PB_Sprite_BlendInvertSourceAlpha)
    ;DisplayTransparentSprite(#Sp_Select,canvasX+OptionsIE\SelectionX*z,canvasY+OptionsIE\SelectionY*z)
    SpriteBlendingMode(#PB_Sprite_BlendInvertDestinationColor, #PB_Sprite_BlendInvertSourceColor)
    DisplayTransparentSprite(#Sp_Select,canvasX+OptionsIE\SelectionX*z,canvasY+OptionsIE\SelectionY*z)
  EndIf
  
  ;{ grid 
  
  If OptionsIE\grid
    SpriteQuality(1)
    ZoomSprite(#Sp_grid, Doc\W*z,Doc\H*z)
    SpriteBlendingMode(#PB_Sprite_BlendSourceAlpha, #PB_Sprite_BlendInvertSourceAlpha) 
    DisplayTransparentSprite(#Sp_grid, canvasX,canvasY)
    SpriteQuality(OptionsIE\SpriteQuality)
  EndIf 
  ;}
  
EndMacro

Procedure ScreenDraw()
  
  z.d = OptionsIE\zoom * 0.01

    ; on update le screen
  ClearScreen(RGB(120,120,120))

  ; the paper
  PaperDraw() ; in 
  
  ; les calques
  Layer_DrawAll() ; in layer.pb
  
  ; les utilitaires
  
  ; sélection, cadre (quand transform par exemple)
  Layer_DrawBorder(LayerId) 
  DrawUtil()
  
 

EndProcedure
Procedure SetAlphaMask()
  
  If OptionsIE\SelectAlpha = 1 
    
    If layer(layerid)\Bm = #Bm_Normal
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      DrawAlphaImage(ImageID(#Img_AlphaSel),0,0)  
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@Filtre_MaskAlpha())
      ;DrawingMode(#PB_2DDrawing_AlphaClip)
    Else
      DrawingMode(#PB_2DDrawing_AllChannels)
      DrawAlphaImage(ImageID(#Img_AlphaSel),0,0)  
      DrawingMode(#PB_2DDrawing_AlphaClip)
    EndIf
  
    If (layer(layerid)\MaskAlpha >= 1 And layer(layerid)\MaskAlpha < 3)
      ; DrawingMode(#PB_2DDrawing_AlphaChannel)
      DrawAlphaImage(ImageID(Layer(i)\ImageAlpha),0,0)    
      
      ;DrawingMode(#PB_2DDrawing_CustomFilter)
      ;CustomFilterCallback(@Filtre_MaskAlpha())
      
    ;Else
      ;DrawingMode(#PB_2DDrawing_AlphaBlend)
    EndIf
    
  Else  
    
    If (layer(layerid)\MaskAlpha >= 1 And layer(layerid)\MaskAlpha < 3)
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      DrawAlphaImage(ImageID(Layer(i)\ImageAlpha),0,0)    
      
      If layer(layerid)\Bm = #Bm_Normal
        DrawingMode(#PB_2DDrawing_CustomFilter)
       CustomFilterCallback(@Filtre_MaskAlpha())
      Else
        DrawingMode(#PB_2DDrawing_AlphaClip)
      EndIf
      
    Else
      DrawingMode(#PB_2DDrawing_AlphaBlend)
    EndIf
  EndIf
  
EndProcedure
  
Procedure ScreenUpdate(updateLayer=0)
  
  z.d = OptionsIE\zoom * 0.01
  
  If NewPainting = 1
    
    If layer(layerId)\Typ <> #Layer_TypText
      
      w = Layer(Layerid)\w
      h = Layer(Layerid)\h
      
      NewPainting = 0
      
      If updateLayer=1 ; si on a besoin d'updater le layer (on change de blendmode)
        
        If StartDrawing(ImageOutput(layer(LayerId)\ImageBM))
          ; d'abord on efface l'image
          DrawingMode(#PB_2DDrawing_AlphaChannel)
          Box(0,0,w,h,RGBA(0,0,0,0))
          
          SetBm(LayerId,0) ; dans inclue\procedures\image.pbi
          
          StopDrawing()
          
        EndIf
        
      EndIf
      
      If layer(layerId)\bm = #Bm_Normal
        alpha= 255
      Else
        alpha = layer(layerId)\Alpha 
      EndIf
      
      
      
      If StartDrawing(SpriteOutput(layer(LayerId)\Sprite))
        ; on l'efface
        DrawingMode(#PB_2DDrawing_AlphaChannel)
        Box(0,0,w,h,RGBA(0,0,0,0))
        ; puis on redessine tout
        
        ;DrawingMode(#PB_2DDrawing_AlphaBlend)
        SetAlphaMask()
        
        Select layer(LayerId)\bm 
          Case #Bm_Normal          
            ; SetAlphaMask()
            Layer_DrawImg(LayerId, alpha)
            
          Case #Bm_Add, #Bm_Clearlight, #Bm_Screen, #Bm_Colorlight, #Bm_Lighten
            Box(0,0,w,h,RGBA(0,0,0,255))
            ; DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0)
            ;SetAlphaMask()
            Layer_DrawImg(LayerId, alpha)
            
          Case #Bm_Darken,#Bm_Multiply,#Bm_LinearBurn
            Box(0,0,w,h,RGBA(255,255,255,255))
            ;SetAlphaMask()
            Layer_DrawImg(LayerId, alpha)
            
          Case #bm_overlay;, #Bm_LinearBurn
            ;Box(0,0,w,h,RGBA(0,0,0,255))
            Box(0,0,w,h,RGBA(60,60,60,255))
            ;DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
            ; SetAlphaMask()
            Layer_DrawImg(LayerId, layer(layerid)\alpha)
            
          Default 
            Box(0,0,w,h,RGBA(255,255,255,255-layer(LayerId)\alpha))
            DrawAlphaImage(ImageID(Layer(LayerId)\ImageBM),0,0,layer(layerid)\alpha)
            ;SetAlphaMask()
            Layer_DrawImg(LayerId, layer(layerid)\alpha)
            
        EndSelect
        
        
        StopDrawing()
      EndIf
      
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
  
  For i = 0 To ArraySize(layer())
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
  
  For i = 0 To ArraySize(layer())
    layer(i)\Sprite = CreateSprite(#PB_Any, doc\w,doc\h,#PB_Sprite_AlphaBlending)
  Next i
  
  ; puis, j'update chaque layer
  For i = 0 To ArraySize(layer())
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





XIncludeFile "procedures\window.pbi"


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 105
; FirstLine = 22
; Folding = wgDA0Z35
; EnableXP
; Executable = ..\_old\animatoon_screen0.22.exe
; SubSystem = openGL
; DisableDebugger
; EnableUnicode