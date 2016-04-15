;{ infos
; test blendmode by blendman 07/2011
; pb : 4.60
; ok for 5.22 & 5.31
;  june 2015
; for animatoon, my 2D painting and animation free software
;}

;{ variables & globales
Enumeration
  #fond
  #layer1
  #alpha_layer1
  #tempo
  #result
  #imagefinal 
EndEnumeration

Global mode.b = 1
;}

;{ init
If UseJPEGImageDecoder() =0 Or UsePNGImageDecoder() =0
  End
EndIf
;}

;{ declare
Declare affiche_img()
Declare bm_add(x, y, SourceColor, TargetColor)
Declare bm_multiply(x, y, SourceColor, TargetColor)
Declare bm_overlay(x, y, SourceColor, TargetColor)
Declare bm_screen(x, y, SourceColor, TargetColor)
Declare Changemode()
;}

;{ open window & create image
  file$ = OpenFileRequester("Image","","Image|*.jpg;*.png|*.bmp",0)
  If file$ = ""
      End
  EndIf
    
  LoadImage(#fond, file$) 
  Global w,h
  w = ImageWidth(#fond)
  h = ImageHeight(#fond)
  
    
If OpenWindow(0, 0, 0, w, h, "Blendmode test", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)

  ;{ menu
  If CreateMenu(0,WindowID(0))
    MenuTitle("BlendMode")
    MenuItem(1,"BlendMode suivant"+Chr(9)+"+")
    MenuItem(2,"BlendMode précédent"+Chr(9)+"-")
  EndIf
  ;}

  ;{ images
  
  ; image (layer1 :  simple red circle 
  CreateImage(#layer1,w,h,32)
  StartDrawing(ImageOutput(#layer1))
  DrawingMode(#PB_2DDrawing_AlphaChannel)   
  Box(0,0,w,h,RGBA(0,0,0,0))
  DrawingMode(#PB_2DDrawing_AlphaBlend)   
  Circle(300, 100, 100,RGBA(255,0,0,255))
  StopDrawing()
 
  CopyImage(#layer1,#alpha_layer1)
 
  ; copy for  the image temporary for alpha chanel //  copie pour le canal alpha
  CreateImage(#tempo,w,h,32)
  StartDrawing(ImageOutput(#tempo))
  DrawingMode(#PB_2DDrawing_AlphaChannel)   
  Box(0,0,w,h,RGBA(0,0,0,0))
  StopDrawing()
   
  If CreateImage(#imagefinal, w, h,32)     
    affiche_Img()   
  EndIf
  ;}

  ;{ shortcut
  AddKeyboardShortcut(0,#PB_Shortcut_Add,1)
  AddKeyboardShortcut(0,#PB_Shortcut_Subtract,2)
  ;}
  
Else
  
  MessageRequester("Erreur", "impossible d'ouvrir une fenêtre")
  End
  
EndIf
;}

Repeat   
  Changemode()
Until Event = #PB_Event_CloseWindow

;{ procedure
Procedure  affiche_img()
  ; on calcule le blendmode, uniquement sur l'alpha opaque lié au layer1
  If StartDrawing(ImageOutput(#tempo))   
    ; image de fond, on peut utiliser une image avec transparence
    DrawingMode(#PB_2DDrawing_AlphaBlend)     
    DrawImage(ImageID(#fond), 0, 0, w, h)
    ; puis on affiche l'image du dessus en fonction du mode de fusion choisi
    If mode =0 ; normal
      DrawingMode(#PB_2DDrawing_Default)
    ElseIf mode <>0     
      DrawingMode(#PB_2DDrawing_CustomFilter)
      If mode = 1 ; add
        CustomFilterCallback(@bm_add())
      ElseIf mode = 2 ; multiply
        CustomFilterCallback(@bm_multiply())
      ElseIf mode = 3 ; overlay
        CustomFilterCallback(@bm_overlay())
      ElseIf mode = 4 ; screen
        CustomFilterCallback(@bm_screen())       
      EndIf
    EndIf   
    DrawAlphaImage(ImageID(#layer1),0,0) 
    DrawingMode(#PB_2DDrawing_AlphaChannel)   
    DrawAlphaImage(ImageID(#alpha_layer1),0,0)
    StopDrawing()
  EndIf
 
  ; on calcule le resultat, l'image finale
  If StartDrawing(ImageOutput(#imagefinal))   
    DrawImage(ImageID(#fond), 0, 0, w, h) ; image de fond, on peut utiliser une image avec transparence   
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawAlphaImage(ImageID(#tempo),0,0)
    StopDrawing()
  EndIf
  ImageGadget(0, 0, 0, w, h, ImageID(#imagefinal))
     
  Select mode
    Case 0
      SetWindowTitle(0,"Mode : Normal - cercle rouge")
    Case 1
      SetWindowTitle(0,"Mode : Add - cercle blanc")
    Case 2
      SetWindowTitle(0,"Mode : Multiply - cercle rouge")
    Case 3
      SetWindowTitle(0,"Mode : Overlay - cercle rouge")
    Case 4
      SetWindowTitle(0,"Mode : Screen - cercle blanc")
  EndSelect   
  
EndProcedure

Procedure.l min(a.l,b.l)
  If a>b
    ProcedureReturn b
  EndIf
  ProcedureReturn a
EndProcedure

Procedure bm_screen(x, y, SourceColor, TargetColor)
  ; color = 255 - ( ( 255 - bottom ) * ( 255 - top ) ) / 255
  red = 255 -((255-Red(SourceColor))*(255-Red(TargetColor)))/255
  green = 255 -((255-Green(SourceColor))*(255-Green(TargetColor)))/255
  blue = 255 -((255-Blue(SourceColor))*(255-Blue(TargetColor)))/255   
  ProcedureReturn RGBA(red,green,blue, Alpha(TargetColor))
EndProcedure

Procedure bm_add(x, y, SourceColor, TargetColor)
  ; color = top >= 255? 255 : min(bottom * 255 / (255 - top), 255)
  If  Red(TargetColor) >= 255
    Red.l= 255
  Else
    result.l= 255 - Red(SourceColor)
    If result >0     
      Red =min(Red(TargetColor) * 255 / (result), 255)
    ElseIf result =0
      red=min(Red(TargetColor) * 255, 255)
    EndIf   
  EndIf

  If  Blue(TargetColor) >= 255
    blue = 255
  Else
    result= 255 - Blue(SourceColor)
    If result >0
      blue=min(Blue(TargetColor) * 255 / (result), 255)
    ElseIf result =0
      blue = min(Blue(TargetColor) * 255, 255)     
    EndIf   
  EndIf

  If  Green(TargetColor) >= 255
    Green = 255
  Else
    result= 255 - Green(SourceColor)
    If result >0
      Green =min(Green(TargetColor) * 255 / (result), 255)
    ElseIf result =0
      green =min(Green(TargetColor) * 255, 255)
    EndIf   
  EndIf
   
  ProcedureReturn RGBA(red, green, blue, Alpha(TargetColor))
EndProcedure

Procedure bm_multiply(x, y, SourceColor, TargetColor)
  ProcedureReturn RGBA((Red(SourceColor)*Red(TargetColor))/255,(Green(SourceColor)*Green(TargetColor))/255,(Blue(SourceColor)*Blue(TargetColor))/255, Alpha(TargetColor)*Alpha(TargetColor)/255)
EndProcedure

Macro overlay(color_source,color_targ, colo)
  If  color_source <128
    colo = ( 2 * color_source*color_targ ) / 255
  Else
    colo =255 - ( 2 * ( 255 - color_source ) * ( 255 - color_targ  ) / 255 )
  EndIf
EndMacro

Procedure bm_overlay(x, y, SourceColor, TargetColor)
  ; color = bottom < 128 ? ( 2 * bottom * top ) / 255 : 255 - ( 2 * ( 255 - bottom ) * ( 255 - top ) / 255 )
  overlay(Red(TargetColor),Red(SourceColor), red)
  overlay(Blue(TargetColor),Blue(SourceColor), blue)
  overlay(Green(TargetColor),Green(SourceColor), green)

  ProcedureReturn RGBA(red, green, blue, Alpha(TargetColor))
EndProcedure

Procedure Changemode()
  Event = WaitWindowEvent()
  Select event
    Case #PB_Event_CloseWindow
      End
    Case #PB_Event_Menu
      Select EventMenu()
        Case 1
          If mode<4
            mode +1
          Else
            mode = 0
          EndIf
          affiche_img()
         
        Case 2
          If mode>0
            mode -1
          Else
            mode = 4
          EndIf
          affiche_img()         
      EndSelect     
  EndSelect
EndProcedure
;}
