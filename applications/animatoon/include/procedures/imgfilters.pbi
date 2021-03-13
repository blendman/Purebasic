
; Animatoon
; july 2015
; by blendman
; pb 5.31
 

Structure MenuPlugin ; Action sur les icones du haut
  MenuId.i
  Name$
  *linkFunction
EndStructure 

Structure Application
 
  winMain.i       ; identifiant de la fenêtre principale
  canvasID.i      ; id du canvas principal
  menuID.i        ; id du menu

  List MenuPlugin.MenuPlugin()
  *funcCreateToolBarButton 

  version_major.c ; version de l'application
  version_minor.c

  event.i         ; evenement de l'application
  
EndStructure


; image vers tableau, tableau vers image
Procedure.i imageToArray(pbImage.i, width.i, height.i)

  *nArray = AllocateMemory( (width * height) * 4 ) ; RGBA
 
  If StartDrawing(ImageOutput(pbImage))
    
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    
    For y = 0 To height -1
      For x = 0 To width -1
        color.l = Point(x,y)
        
        PokeC( (*nArray + (x*4) + ImageWidth(pbImage) * (y*4))+0 , Red(color) )
        PokeC( (*nArray + (x*4) + ImageWidth(pbImage) * (y*4))+1 , Green(color) )
        PokeC( (*nArray + (x*4) + ImageWidth(pbImage) * (y*4))+2 , Blue(color) )
        PokeC( (*nArray + (x*4) + ImageWidth(pbImage) * (y*4))+3 , Alpha(color) )
        
      Next
    Next
    StopDrawing()
  EndIf
 
  ProcedureReturn *nArray
EndProcedure

Procedure ArrayToImage(pbImage, *pixel_data, width.i, height.i)

  StartDrawing(ImageOutput(pbImage))
 
    DrawingMode(#PB_2DDrawing_AlphaChannel)
    Box(0,0,width, height,RGBA(0,0,0,0))
   
    DrawingMode(#PB_2DDrawing_AlphaBlend)
 
    For y = 0 To height -1
      For x = 0 To width -1
       
        red.c   = PeekC( (*pixel_data + (x*4) + width * (y*4))+0 )
        green.c = PeekC( (*pixel_data + (x*4) + width * (y*4))+1 )
        blue.c  = PeekC( (*pixel_data + (x*4) + width * (y*4))+2 )
        alpha.c = PeekC( (*pixel_data + (x*4) + width * (y*4))+3 )
       
        Plot(x,y,RGBA(red,green,blue,alpha))
 
      Next
    Next
  StopDrawing()
 
EndProcedure


; les filtres présents
Procedure ImgFilterNoise()
  
  IE_SetImageOutput(Layer(LayerID)\Image)
  
  ; On lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength);Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  ; on effectue l'operation
  r = Random(255)
  g = Random(255)
  b = Random(255)
  
  a = (r + g + b)/3
  R = a
  g = a
  b = a
  
  
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  
  IE_SetImageOutput1()
  
  ; puis, on update
  NewPainting = 1
  ScreenUpdate(1)
  
EndProcedure
Procedure ImgFilterClouds()
  
  
  
  
  
  
EndProcedure


; blur
Procedure ImgFilterBlur(ratio.d=0.1111)
  
  IE_SetImageOutput(Layer(LayerID)\Image,1)
  
  
  red   = 0
  green = 0
  blue  = 0
  alpha = 0
  
  width = lineLength
  
  For yy = -1 To 1
    For xx = -1 To 1
      
      ; On lit le pixels
      red   + PeekA( (Buffer + ((i+xx)*4) + width * ((j+yy)))+0 )
      green + PeekA( (Buffer + ((i+xx)*4) + width * ((j+yy)))+1 )
      blue  + PeekA( (Buffer + ((i+xx)*4) + width * ((j+yy)))+2 )
      alpha + PeekA( (Buffer + ((i+xx)*4) + width * ((j+yy)))+3 )
      
    Next 
  Next 
   
  red   = red   * ratio
  green = green * ratio
  blue  = blue  * ratio
  alpha = alpha * ratio
  
  
  If red  > 255 : red   = 255 : EndIf  
  If green> 255 : green = 255 : EndIf 
  If blue > 255 : blue  = 255 : EndIf 
  If alpha> 255 : alpha = 255 : EndIf 
  CheckIfInf(Red,0)
  CheckIfInf(green,0)
  CheckIfInf(blue,0)
  CheckIfInf(alpha,0)
  
  x = i
  y = j
  PokeA( (Buffer + (x*4) + width * (y))+0 , red   )
  PokeA( (Buffer + (x*4) + width * (y))+1 , green ) 
  PokeA( (Buffer + (x*4) + width * (y))+2 , blue  )
  PokeA( (Buffer + (x*4) + width * (y))+3 , alpha )
  
  
  
  IE_SetImageOutput1()
  
  ; puis, on update
  NewPainting = 1
  ScreenUpdate(1)
  
  
  
EndProcedure

; Sharpen
Procedure ImgFilterSharpenAlpha()
  
  
  IE_SetImageOutput(Layer(LayerID)\Image,1)
  
  
  red   = 0
  green = 0
  blue  = 0
  alpha = 0
  
  width = lineLength
  
  red   = PeekA( Buffer + i*4 + width * j + 0 )
  green = PeekA( Buffer + i*4 + width * j + 1 )
  blue  = PeekA( Buffer + i*4 + width * j + 2 )
  alpha = PeekA( Buffer + i*4 + width * j + 3 )

  For yy = -1 To 1
    For xx = -1 To 1
      ; alpha + PeekA( (Buffer + ((i+xx)*4) + width * ((j+yy)))+3 )
    Next 
  Next 
  
  
  alpha = alpha*1.5
  If red  > 255 : red   = 255 : EndIf 
  If green> 255 : green = 255 : EndIf 
  If blue > 255 : blue  = 255 : EndIf 
  If alpha> 255 : alpha = 255 : EndIf 
  
  
  x = i
  y = j
  PokeA( (Buffer + (x*4) + width * (y))+0 , red   )
  PokeA( (Buffer + (x*4) + width * (y))+1 , green ) 
  PokeA( (Buffer + (x*4) + width * (y))+2 , blue  )
  PokeA( (Buffer + (x*4) + width * (y))+3 , alpha )
  
  
  
  IE_SetImageOutput1()
  
  ; puis, on update
  NewPainting = 1
  ScreenUpdate(1)
  
  
  
  
EndProcedure

Procedure ImgFilterSharpen(ratio.d=1.5)
  
  IE_SetImageOutput(Layer(LayerID)\Image,1)
  
  
  red   = 0
  green = 0
  blue  = 0
  alpha = 0
  
  width = lineLength
  
  r = PeekA(Buffer + 4 * i + j * lineLength);Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  b = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  For yy = -1 To 1
    For xx = -1 To 1
      alpha + PeekA( (Buffer + ((i+xx)*4) + width * ((j+yy)))+3 )
    Next 
  Next 
  
  If alpha >0
    If r > 100 And r < 200
      r   = r *1.2
    EndIf
    If g > 100 And g < 200
      g   = g*1.2
    EndIf
    If b > 100 And b < 200
      b   = b *1.2
    EndIf    
    alpha = alpha * ratio
  EndIf
  
  
  If r  > 255 : r   = 255 : EndIf  
  If g> 255 : g = 255 : EndIf 
  If b > 255 : b  = 255 : EndIf 
  If alpha> 255 : alpha = 255 : EndIf 
  CheckIfInf(r,0)
  CheckIfInf(g,0)
  CheckIfInf(b,0)
  CheckIfInf(alpha,0)
  
  x = i
  y = j
  
   ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      r);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  b);Rouge  
  
  
  ;PokeA( (Buffer + (x*4) + width * (y))+0 , red   )
  ;PokeA( (Buffer + (x*4) + width * (y))+1 , green ) 
  ;PokeA( (Buffer + (x*4) + width * (y))+2 , blue  )
  PokeA( (Buffer + (x*4) + width * (y))+3 , alpha )
  
  
  
  IE_SetImageOutput1()
  
  ; puis, on update
  NewPainting = 1
  ScreenUpdate(1)
  
  
  
EndProcedure


; misc
Procedure ImgFilterOffset()
  
  
  
  
  
EndProcedure


; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 268
; FirstLine = 57
; Folding = 5O++--+
; EnableUnicode
; EnableXP