

; Dll plug ing for animatoon 1.0
; date : 03/07/2015
; by blendman
; pb 5.31


Structure sDoc
  ; par defaut
  w_def.w
  h_def.w 
  w.w 
  h.w
  name$
  
EndStructure
Global doc.sDoc


Structure sLayer
  image.i
EndStructure
Global Layer

; image vers tableau, tableau vers image
Procedure.i imageToArray(pbImage.i, width.i, height.i)

  *nArray = AllocateMemory( (width * height) * 4 ) ; RGBA
 
  StartDrawing(ImageOutput(pbImage))
 
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

Macro IE_SetImageOutput(Image)
  
  DrawOk = 0
  
  If OptionsIE\Selection = 0
    
    W = ImageWidth(Image)
    H = ImageHeight(Image)
    
    If StartDrawing(ImageOutput(Image))
      DrawOk = 1                     
    EndIf
    
  Else
    
    W = OptionsIE\SelectionW
    H = OptionsIE\SelectionH
    
    If StartDrawing(ImageOutput(ImageSel))
      DrawOk = 1
    EndIf
    
  EndIf
  
  If DrawOk
    
    ;"Buffer" : le pointeur vers l'espace memoire.
    Buffer = DrawingBuffer()
    
    If Buffer <> 0
    
    ;Organisation du buffer :
    pixelFormat = DrawingBufferPixelFormat()
    ; pixelFormat va te donner une constante car sa peut varier ; Voir la documentation
    
    lineLength = DrawingBufferPitch();Longueur d'une ligne
    
    If pixelFormat = #PB_PixelFormat_32Bits_BGR | #PB_PixelFormat_ReversedY
      
      For i = 0 To W - 1 ;Pour chaque ligne
        
        For j = 0 To H - 1 ; Pour chaque colonne (donc pour chaque pixel) :
  
EndMacro

Macro IE_SetImageOutput1()
  
        Next j
      
      Next i
    
    EndIf
    
    StopDrawing()
  EndIf
  
EndIf

EndMacro


ProcedureDLL DoFilter(*pixel_data, width.i, height.i)
  
  ;imageToArray(pbImage.i, width.i, height.i)
  
  *nArray = AllocateMemory( (width * height) * 4 )
  FillMemory(*nArray,MemorySize(*nArray),#Null)

  
    ; On lit le pixels
;   b = PeekA(Buffer + 4 * i + j * lineLength);Bleu
;   g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
;   r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
;   
  For y = 0 To height -1
    For x = 0 To width -1
      ; on effectue l'operation
      r = Random(255)
      g = Random(255)
      b = Random(255)
      
      a = (r + g + b)/3
      R = a
      G = a
      B = a
      
      PokeC( (*nArray + (x*4) + ImageWidth(pbImage) * (y*4))+0 , R)
      PokeC( (*nArray + (x*4) + ImageWidth(pbImage) * (y*4))+1 , G )
      PokeC( (*nArray + (x*4) + ImageWidth(pbImage) * (y*4))+2 , B )
      ;PokeC( (*nArray + (x*4) + ImageWidth(pbImage) * (y*4))+3 , Alpha(color) )
       
      
    Next
  Next
;   
;   ; on poke le pixel
;   PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
;   PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
;   PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  ;ArrayToImage(pbImage, *pixel_data, width.i, height.i)
  ; IE_SetImageOutput1()
  CopyMemory(*nArray, *pixel_data, (width * height) * 4)
  
EndProcedure



; IDE Options = PureBasic 5.31 (Windows - x64)
; ExecutableFormat = Shared Dll
; CursorPosition = 137
; FirstLine = 17
; Folding = Yz-
; EnableUnicode
; EnableXP
; Executable = ..\..\data\Plugins\Filters\noise.dll
; CompileSourceDirectory