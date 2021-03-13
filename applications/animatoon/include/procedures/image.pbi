
; image

Macro IE_SetImageOutput(Image,a1=0)
  
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
      
      For i = a1 To W-(1+a1) ;Pour chaque ligne
        
        For j = a1 To H-(1+a1) ; Pour chaque colonne (donc pour chaque pixel) :
  
EndMacro

Macro IE_SetImageOutput1(mode=0)
  
        Next j
      
      Next i
    
    EndIf
    
    StopDrawing()
  EndIf
  
EndIf

If mode =0
  ScreenUpdate()
EndIf


EndMacro




Macro IE_GetImagePixelColor(img)
  
  w = ImageWidth(img)
  h = ImageHeight(img) 
  Dim pixel.i(w, h)
  Dim alph.a(w, h)
  
  ; on chope la couleur
  If StartDrawing(ImageOutput(img))
    DrawingMode(#PB_2DDrawing_AllChannels)
    
    For y = 0 To h - 1
      For x = 0 To w - 1
        
        color = Point(x, y)
        alpha = Alpha(color)
        pixel(x, y) = color
        Alph(x, y) = alpha
        
      Next
    Next
    
    StopDrawing()
  EndIf

EndMacro


;{ Image reglages
Procedure IE_InvertColor(img, al = 0, col = 1)
  
  IE_GetImagePixelColor(img)
  
  ; et on effectue l'operation
  If StartDrawing(ImageOutput(img))
    ; DrawingMode(#PB_2DDrawing_AlphaChannel)
    ; Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
    
    DrawingMode(#PB_2DDrawing_AllChannels)

    For y = 0 To h - 1
      For x = 0 To w - 1
        
        If col = 1
          
          r = 255 - Red(pixel(x, y))
          g = 255 - Green(pixel(x, y))
          b = 255 - Blue(pixel(x, y))
          
        Else
          
          r =  Red(pixel(x, y))
          g =  Green(pixel(x, y))
          b =  Blue(pixel(x, y))
          
        EndIf
      
        If al = 0
          a = alph(x,y) 
          color = RGBA(r,g,b,a)
                   
        Else
          
          a = 255 - alph(x,y)          
          color = RGBA(r,g,b,a)
          
        EndIf
        Plot(x, y, color)
        
      Next
    Next
    
    StopDrawing()
    
  EndIf
  
  
  ; SaveImage(img, "save.png", #PB_ImagePlugin_PNG)
  NewPainting = 1
  ScreenUpdate(1)
  
  ProcedureReturn img
EndProcedure

Procedure IE_ColorBalance1(img, r1, g1, b1, mode= 0)
  
  r2.d = r1/126
  g2.d = g1/126
  b2.d = b1/126
  
  IE_SetImageOutput(img,0)
  
  ; On lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength);Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  ; on effectue l'opération 
    ;Rouge = Rouge * Echelle + Rouge2 * (1-Echelle)
    r = r * r2 + r1 *(1-r2) 
    Check0(r)
    
    
    g = g * g2 + g1 *(1-g2)
    Check0(g)
    
    b = b * b2 + b1 *(1-b2)     
    Check0(b)
    
  
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  
   IE_SetImageOutput1(1)
  
  If mode = 0
    
    ScreenUpdate()
    
  EndIf
    
  ProcedureReturn img  
EndProcedure

Procedure IE_ColorBalance(img, r1, g1, b1, mode= 0)
  
  
  IE_SetImageOutput(img)
  
  ; On lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength);Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  ; on effectue l'opération 
  
  If (r+g+b)/3 < 240
    
    r = r + r1
    Check(r,255)
    
    g = g + g1
    Check(g,255)
    
    b = b + b1
    Check(b,255)
    
  Else
    
    If (r+g)/2 <250
      
      r = r + r1
      Check(r,255)
      
      g = g + g1
      Check(g,255)
      
      ;                     b = b + b1
      ;                     If b > 255
      ;                       b = 255
      ;                     EndIf
      
    ElseIf (r+b)/2 < 250
      
      r = r + r1
    Check(r,255)
      
      ;                     g = g + g1
      ;                     If g >255
      ;                       g = 255
      ;                     EndIf                  
      
      b = b + b1
    Check(rb,255)
      
    ElseIf (g+b)/2 < 250
      
      ;                     r = r + r1
      ;                     If r > 255
      ;                       r = 255
      ;                     EndIf                  
      
      g = g + g1
    Check(g,255)
      
      b = b + b1
    Check(b,255)
      
      
    EndIf
    
  EndIf
  
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  
  IE_SetImageOutput1(1)
  
  ;{ old
  
;   IE_GetImagePixelColor(img)
;   
;   ; et on effectue l'operation
;   If StartDrawing(ImageOutput(img))
;     
;     For y = 0 To h - 1
;       
;       For x = 0 To w - 1
;         
;         
;         r1 = Red(pixel(x, y)) 
;         g1 = Green(pixel(x, y))
;         b1 = Blue(pixel(x, y))
;         
;         ;If (r+g+b)/3 < 240 
;         if (r1+g1+b1)/3 < 240
;           r1 + r   
;           If r1 > 255
;             r1 = 255
;           EndIf
;           
;           g1  + g
;           If g1 > 255
;             g1 = 255
;           EndIf
;           
;           g1 + b
;           If b1 > 255
;             b1 = 255
;           EndIf
;         EndIf
;         
;         color = RGB(r1,g1,b1)
;         Plot(x, y, color)
;         
;       Next
;       
;     Next
;     
;     StopDrawing()
;     
;   EndIf
;}

  If mode = 0
    
    ScreenUpdate()
    
  EndIf
    
  ProcedureReturn img  
EndProcedure

Procedure IE_Desaturation(img)
    
  IE_GetImagePixelColor(img)
  
  ; et on effectue l'operation
  If StartDrawing(ImageOutput(img))
    
    For y = 0 To h - 1
      For x = 0 To w - 1
        
        r = Red(pixel(x, y))
        g = Green(pixel(x, y))
        b = Blue(pixel(x, y))
        a = (r + g + b)/3
        color = RGB(a,a,a)
        
        Plot(x, y, color)
        
      Next
    Next
    StopDrawing()
  EndIf
  
  NewPainting = 1
  ScreenUpdate(1)
  
  
EndProcedure


ProcedureDLL.i IE_Contrast(img, contrast, brightness, mode=0) ; Constrater la couleur, échelle négative pour diminuer et positive pour augmenter.
   
   IE_SetImageOutput(img)
   
   Echelle.d  = contrast/100
   EchelleB.d = brightness/100
   
   ; on lit le pixels
   b = PeekA(Buffer + 4 * i + j * lineLength)    ;Bleu
   g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
   r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
   
   ;    Rouge = Couleur & $FF
   ;    Vert = Couleur >> 8 & $FF
   ;    Bleu = Couleur >> 16 & $FF
   ;    Alpha = Couleur >> 24
   
   r = (r * Echelle  + 127 * (1 - Echelle)) * EchelleB
   g = (g * Echelle  + 127 * (1 - Echelle)) * EchelleB
   b = (b * Echelle  + 127 * (1 - Echelle)) * EchelleB
   
   Check0(r)
   Check0(g)
   Check0(b)
   
   ; (r | g <<8 | b << 16 | Alpha << 24)
   
   ; on poke le pixel
   PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
   PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
   PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
   
   
   IE_SetImageOutput1(1)
   
   If mode = 0
     
     ScreenUpdate()
     
   EndIf
   
   ProcedureReturn img  
EndProcedure

Procedure IE_Contrast2(img, contrast, brightness, mode=0)
  
  IE_SetImageOutput(img)
  
  ; on lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength)    ;Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  ; on trasnforme
  
  If r + contrast > 126
    
    r = r + contrast
    
  Else
    
    r = r - contrast
    
  EndIf
  
  If g + contrast > 126
    
    g = g + contrast
    
  Else
    
    g = g - contrast
    
  EndIf
  
  If b + contrast > 126
    
    b = b + contrast
    
  Else
    
    b = b - contrast
    
  EndIf
       
    
  Check(r,255)
  Check2(r,0)
  
  Check(b,255)
  Check2(b,0)
  
  Check(g,255)
  Check2(g,0)
  
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  
  IE_SetImageOutput1(1)
  If mode = 0
    
    ScreenUpdate()
    
  EndIf

  ProcedureReturn img  
EndProcedure

Procedure IE_Contrast1(img, contrast, brightness, mode=0)
  
  IE_SetImageOutput(img)
  
  ; on lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength)    ;Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  ; on trasnforme
  
  If (r+g+b)/3 > 127
    
    r = r +contrast
    Check(r,255)
    g = g +contrast
    Check(g,255)
    b = b +contrast
    Check(b,255)
    
  Else
    r = r - contrast
    Check2(r,0)
    g = g - contrast
    Check2(g,0)
    b = b - contrast
    Check2(b,0)
  EndIf
  
  
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  
  IE_SetImageOutput1(1)
  If mode = 0
    
    ScreenUpdate()
    
  EndIf

  ProcedureReturn img  
EndProcedure

Procedure IE_posterize(img,level)
  
  n1 = 255/level
  
  If n1 <= 0
    n1 = 1
  EndIf
  
  IE_SetImageOutput(img)
  
  ; on lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength)    ;Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
    
  ;r=Round(r/n1,#PB_Round_Down)
  r=r/n1
  r=r*n1
  ;g=Round(g/n1,#PB_Round_Down)
  g=g/n1
  g=g*n1
  ;b=Round(b/n1,#PB_Round_Down)
  b=b/n1
  b=b*n1 
  
  Check0(r)
  Check0(g)
  Check0(b)
   
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  
  IE_SetImageOutput1(1)
  
  
  ProcedureReturn img 
EndProcedure

Procedure IE_posterize2(img,n)
  
  
  n1 = 255/n 

  If n1 <= 0
    n1 = 1
  EndIf
  
  w = ImageWidth(img)
  h = ImageHeight(img)
  
  If w > 0 And h > 0
    
  Dim OriginalImage(w,h)
    
  If StartDrawing(ImageOutput(img))
    
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    
    ; on stocke dans un tableau les pixels    
    For i = 0 To w-1
      
      For j = 0 To h-1
        
        ; on stocke la couleur du pixel
        color = Point(i,j) 
        a = Alpha(color)
        
        r = Red(color)
        g = Green(color)
        b = Blue(color)
        
        r/n1
        r*n1 
        g/n1
        g*n1
        b/n1
        b*n1
        
        OriginalImage(i,j) = RGBA(r,g,b,a)
        
      Next j
      
    Next i
    
    StopDrawing()
    
  EndIf
  
  
  ; update l'image 
  If StartDrawing(ImageOutput(img))  
    
    Box(0,0,w,h, RGB(255,255,255))
    
    DrawingMode(#PB_2DDrawing_AlphaChannel)
    Box(0,0,w,h, RGBA(0,0,0,0))
    
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    ; on dessine les pixels sur la nouvelle image
    For i = 0 To w-1
      For j = 0 To h-1
        Plot(i,j,OriginalImage(i,j))                  
      Next j
    Next i              
    StopDrawing()
   EndIf
 EndIf
 
  
  
EndProcedure

Procedure IE_Level(img,Minimum,maximum)
  
  If Maximum - Minimum <= 0
    m = 1
  Else
    m = Maximum - Minimum
  EndIf
  a.f = 255 / m
  c.f = -a * Minimum
  
  IE_SetImageOutput(img)
  
  ; on lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength)    ;Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  r * a + c
  g * a + c 
  b * a + c
  Check0(r)
  Check0(g)
  Check0(b)
  
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  
  IE_SetImageOutput1(1)
  
  ProcedureReturn img 
EndProcedure



; Procedure par LSI
ProcedureDLL.i Contraste(Couleur.i, Echelle.f) ; Constrater la couleur, échelle négative pour diminuer et positive pour augmenter.
   Protected Rouge.i, Vert.i, Bleu.i, Alpha.i
   
   Rouge = Couleur & $FF
   Vert = Couleur >> 8 & $FF
   Bleu = Couleur >> 16 & $FF
   Alpha = Couleur >> 24
   Rouge * Echelle + 127 * (1 - Echelle)
   Vert * Echelle + 127 * (1 - Echelle)
   Bleu * Echelle + 127 * (1 - Echelle)
   
   If Rouge > 255 : Rouge = 255
      ElseIf Rouge < 0 : Rouge = 0 : EndIf
   If Vert > 255 : Vert = 255
      ElseIf Vert < 0 : Vert = 0 : EndIf
   If Bleu > 255 : Bleu = 255
      ElseIf Bleu < 0 : Bleu = 0 : EndIf
   
   ProcedureReturn (Rouge | Vert <<8 | Bleu << 16 | Alpha << 24)
 EndProcedure
 
ProcedureDLL.i Lumiere(Couleur.i, Echelle.f) ; Eclaicir ou foncer une couleur
   Protected Rouge.i, Vert.i, Bleu.i, Alpha.i
   
   Rouge = Couleur & $FF
   Vert = Couleur >> 8 & $FF
   Bleu = Couleur >> 16 & $FF
   Alpha = Couleur >> 24
   Rouge * Echelle
   Vert * Echelle
   Bleu * Echelle
   
   If Rouge > 255 : Rouge = 255 : EndIf
   If Vert > 255 : Vert = 255 : EndIf
   If Bleu > 255 : Bleu = 255 : EndIf
   
   ProcedureReturn (Rouge | Vert <<8 | Bleu << 16 | Alpha << 24)
EndProcedure

ProcedureDLL.i Niveau(Couleur.i, Minimum.i, Maximum.i) ; Changer les niveaux de blanc et de noir de la couleur
   Protected Rouge.i, Vert.i, Bleu.i, Alpha.i, a.f, b.f
   
   If Maximum - Minimum < 0
     m = 1
   Else
     m = Maximum - Minimum
   EndIf
   a = 255 / m
   b = -a * Minimum
   
   Rouge = Couleur & $FF
   Vert = Couleur >> 8 & $FF
   Bleu = Couleur >> 16 & $FF
   Alpha = Couleur >> 24
   Rouge * a + b
   Vert * a + b
   Bleu * a + b
   
   If Rouge > 255 : Rouge = 255
      ElseIf Rouge < 0 : Rouge = 0 : EndIf
   If Vert > 255 : Vert = 255
      ElseIf Vert < 0 : Vert = 0 : EndIf
   If Bleu > 255 : Bleu = 255
      ElseIf Bleu < 0 : Bleu = 0 : EndIf
   
   ProcedureReturn (Rouge | Vert <<8 | Bleu << 16 | Alpha << 24)
EndProcedure

ProcedureDLL TSL(Teinte.i, Saturation.i, Luminosite.i) ; TSL (Teinte, Saturation, Luminosité) ; renvoye la couleur au format RGB
   Protected fTeinte.f, Minimum.i, Maximum.i, Difference.i, i.i, Rouge.i, Vert.i, Bleu.i
   fTeinte = 6*Teinte/240
   If Luminosite =< 120
      Maximum = Round((255*Luminosite*(1+Saturation/240)/240), #PB_Round_Nearest)
      Minimum = Round((255*Luminosite*(1-Saturation/240)/240), #PB_Round_Nearest)
   Else
      Maximum = Round((255*(Luminosite*(1-Saturation/240)/240+Saturation/240)), #PB_Round_Nearest)
      Minimum = Round((255*(Luminosite*(1+Saturation/240)/240-Saturation/240)), #PB_Round_Nearest)
   EndIf
   Difference = Maximum-Minimum
   i = Round(fTeinte, #PB_Round_Nearest)
   If i = 0
      Rouge = Maximum : Vert = Minimum+fTeinte*Difference : Bleu = Minimum
   ElseIf i = 1
      Rouge = Minimum + (2-fTeinte)*Difference : Vert = Maximum : Bleu = Minimum
   ElseIf i = 2
      Rouge = Minimum : Vert = Maximum : Bleu = Minimum+(fTeinte-2)*Difference
   ElseIf i = 3
      Rouge = Minimum : Vert = Minimum+(4-fTeinte)*Difference : Bleu = Maximum
   ElseIf i = 4
      Rouge = Minimum + (fTeinte-4)*Difference : Vert = Minimum : Bleu = Maximum
   Else
      Rouge = Maximum : Vert = Minimum : Bleu = Minimum+(6-fTeinte)*Difference
   EndIf
   ProcedureReturn RGB(Rouge,Vert,Bleu)
EndProcedure

Procedure GreyLevel(r,g,b)
  
  yyy.c = Int(0.299*r + 0.587*g + 0.114*b)
  
  ProcedureReturn yyy
EndProcedure





; IMAGE
Macro IE_CloseWin()
  
  If IsWindow(#Win_BalCol)
    CloseWindow(#Win_BalCol)
  EndIf
  If IsWindow(#Win_Contrast)
    CloseWindow(#Win_Contrast)
  EndIf
  
EndMacro
Procedure IE_WinBalCol()
  
  W1 = 300
  IE_CloseWin()
  
  If OpenWindow(#Win_BalCol,0, 0, W1*2 + 30, 220, Lang("Balance Color"), #PB_Window_SystemMenu|#PB_Window_ScreenCentered, WindowID(#WinMain))
    
    yy = 10
    
    H1 = (W1 * Layer(layerid)\H)/Layer(layerid)\W
    
    
    ImageTransf = CopyImage(Layer(LayerID)\Image, #PB_Any)
    ResizeImage(ImageTransf, W1, H1)
    
    ImageGadget(#IE_BalColNormal, 10,       yy, W1, H1, ImageID(ImageTransf), #PB_Image_Border)
    ImageGadget(#IE_BalColNew,    w1 + 20,  yy, W1, H1, ImageID(ImageTransf), #PB_Image_Border)
                
   
    
    yy + H1 + 10
    
    x = 10 + WindowWidth(#Win_BalCol)/2 - 255/2
    TrackBarGadget(#IE_BalColRed,   x, yy, 255, 20,0,255)
    TrackBarGadget(#IE_BalColGreen, x, yy+30, 255, 20,0,255)
    TrackBarGadget(#IE_BalColBlue,  x, yy+60, 255, 20,0,255)
    ButtonGadget(#IE_BalColOk,      WindowWidth(#Win_BalCol)/2 - 30, yy+90,  60, 20, lang("Ok"))
    
    YY + 90 +30
    
    ResizeWindow(#Win_BalCol, #PB_Ignore, #PB_Ignore, #PB_Ignore, YY)
    
    
    Repeat
      
       event = WaitWindowEvent(10)
      
      
       Select event
           
         Case #PB_Event_Gadget
           
           Select EventGadget()
               
             Case #IE_BalColRed, #IE_BalColGreen, #IE_BalColBlue
               r1 = GetGadgetState(#IE_BalColRed)
               g1 = GetGadgetState(#IE_BalColGreen)
               b1 = GetGadgetState(#IE_BalColBlue)                            
               temp = CopyImage(ImageTransf, #PB_Any)               
               IE_ColorBalance(temp, r1, g1, b1)               
               SetGadgetState(#IE_BalColNew, ImageID(temp))
               If temp > #Img_Max
                 FreeImage2(temp)
               EndIf
                              
             Case #IE_BalColOk                
               IE_ColorBalance(Layer(LayerID)\Image, r1, g1, b1)
               If ImageTransf > #Img_Max
                 FreeImage2(ImageTransf)
               EndIf
               NewPainting = 1
               ScreenUpdate()
               quit = 1
               
           EndSelect
           
         Case #PB_Event_CloseWindow
           quit = 1
          
      EndSelect
      
      
    Until quit = 1
       
    CloseWindow(#Win_Contrast)
    
  EndIf
  
EndProcedure

Procedure IE_WinPosterize()
  
  W1 = 400
  If OpenWindow(#Win_Contrast,0, 0, W1*2 + 30, 220, Lang("Posterize"), #PB_Window_SystemMenu|#PB_Window_ScreenCentered, WindowID(#WinMain))
    
    yy = 10
    
    H1 = (W1 * layer(layerid)\H)/layer(layerid)\W
    WindowBounds(#Win_Contrast,W1*2 + 30,220,#PB_Ignore,#PB_Ignore)
    
    ImageTransf = CopyImage(Layer(LayerID)\Image, #PB_Any)
    MessageRequester("",Str(ImageDepth(ImageTransf)))
    
    ResizeImage(ImageTransf, W1, H1)
    
    ImageGadget(#IE_BalColNormal, 10,       yy, W1, H1, ImageID(ImageTransf), #PB_Image_Border)
    ImageGadget(#IE_BalColNew,    w1 + 20,  yy, W1, H1, ImageID(ImageTransf), #PB_Image_Border)
    
    yy + H1 + 10
    
    x = 10 + WindowWidth(#Win_Contrast)/2 - 255/2
    TG_Post = TextGadget(#PB_Any, x, yy, 50,20,lang("Level"))
    StringGadget(#IE_BrightnessSG, x+200, yy, 40, 20, "0", #PB_String_Numeric)
    yy+20
    TrackBarGadget(#IE_BrightnessTB, x, yy, 255, 20,1,255)
    SetGadgetState(#IE_BrightnessTB, 100)
    yy+20
    ButtonGadget(#IE_ContrastOk, WindowWidth(#Win_Contrast)/2 - 30, yy,  60, 20, lang("Ok"))
    YY + 30    
    ResizeWindow(#Win_Contrast, #PB_Ignore, #PB_Ignore, #PB_Ignore, YY)
    
    Repeat
      
      event = WaitWindowEvent(10)
            
      Select event
          
        Case #PB_Event_Gadget
          
          Select EventGadget()
              
            Case #IE_BrightnessSG, #IE_BrightnessTB           
              If EventGadget = #IE_BrightnessSG
                Level = Val(GetGadgetText(#IE_BrightnessSG))
              Else
                Level = GetGadgetState(#IE_BrightnessTB) 
              EndIf
              SetGadgetState(#IE_BrightnessTB,Level) 
              SetGadgetText(#IE_BrightnessSG,Str(Level))
              
              temp = CopyImage(ImageTransf, #PB_Any)
              IE_posterize(temp,Level)                
              SetGadgetState(#IE_BalColNew, ImageID(temp))
              If temp > #Img_Max
                FreeImage2(temp)
              EndIf
              
            Case #IE_ContrastOk
              IE_Posterize(Layer(LayerID)\Image, Level)
              If ImageTransf > #Img_Max
                FreeImage2(ImageTransf)
              EndIf
              NewPainting = 1
              ScreenUpdate()
              quit = 1
              
          EndSelect
          
        Case #PB_Event_SizeWindow
          ;{
          w1 = (WindowWidth(#Win_Contrast)-30)/2
          H1 = (W1 * layer(layerid)\H)/layer(layerid)\W  
          h = (WindowWidth(#Win_Contrast)* layer(layerid)\H)/layer(layerid)\W 
          ResizeWindow(#Win_Contrast,#PB_Ignore,#PB_Ignore,#PB_Ignore,h)
          ResizeImage(ImageTransf, W1, H1)
          ResizeGadget(#IE_BalColNormal,#PB_Ignore,#PB_Ignore,W1,h1)
          ResizeGadget(#IE_BalColNew, w1 + 20,#PB_Ignore,W1,h1)
          ResizeGadget(TG_Post,#PB_Ignore,GadgetHeight(#IE_BalColNew)+20,#PB_Ignore,#PB_Ignore)
          ResizeGadget(#IE_BrightnessSG,#PB_Ignore,GadgetHeight(#IE_BalColNew)+20,#PB_Ignore,#PB_Ignore)
          ResizeGadget(#IE_BrightnessTB,#PB_Ignore,GadgetHeight(#IE_BalColNew)+40,#PB_Ignore,#PB_Ignore)
          ResizeGadget(#IE_ContrastOk,#PB_Ignore,WindowHeight(#Win_Contrast)-30,#PB_Ignore,#PB_Ignore)
          ;}
          
        Case #PB_Event_CloseWindow
          quit = 1
          
      EndSelect
      
      
    Until quit =1
        
    
    CloseWindow(#Win_Contrast)
    
  EndIf
  
EndProcedure

Procedure IE_WinContrast()
  
  IE_CloseWin()
  W1 = 300
  
  If OpenWindow(#Win_Contrast,0, 0, W1*2 + 30, 220, Lang("Brightness/constrast"), #PB_Window_SystemMenu|#PB_Window_ScreenCentered, WindowID(#WinMain))
    
    yy = 10
    
    H1 = (W1 * layer(layerid)\H)/layer(layerid)\W
    
    
    ImageTransf = CopyImage(Layer(LayerID)\Image, #PB_Any)
    ResizeImage(ImageTransf, W1, H1)
    
    ImageGadget(#IE_BalColNormal, 10,       yy, W1, H1, ImageID(ImageTransf), #PB_Image_Border)
    ImageGadget(#IE_BalColNew,    w1 + 20,  yy, W1, H1, ImageID(ImageTransf), #PB_Image_Border)
                
   
    
    yy + H1 + 10
    
    x = 10 + WindowWidth(#Win_Contrast)/2 - 255/2
    TextGadget(#PB_Any, x, yy, 50,20,lang("Brightness"))
    StringGadget(#IE_BrightnessSG, x+200, yy, 40, 20, "0", #PB_String_Numeric)
    yy+30
    TrackBarGadget(#IE_BrightnessTB, x, yy, 255, 20,0,200)
    SetGadgetState(#IE_BrightnessTB, 100)
    
    yy+30
    TextGadget(#PB_Any, x, yy, 50,20,lang("Contrast"))
    StringGadget(#IE_ContrastSG, x+200, yy, 40, 20, "0", #PB_String_Numeric)
    yy+30    
    TrackBarGadget(#IE_ContrastTB,   x, yy, 255, 20,0,200)
    SetGadgetState(#IE_ContrastTB, 100)
    
    
    ButtonGadget(#IE_ContrastOk,      WindowWidth(#Win_Contrast)/2 - 30, yy+90,  60, 20, lang("Ok"))
    
    YY + 90 +30
    
    ResizeWindow(#Win_Contrast, #PB_Ignore, #PB_Ignore, #PB_Ignore, YY)
    
    
    Repeat
      
      event = WaitWindowEvent(10)
      
      
      Select event
          
        Case #PB_Event_Gadget
          
          Select EventGadget()
              
                Case #IE_ContrastSG, #IE_ContrastTB, #IE_BrightnessSG, #IE_BrightnessTB                
                              
                  If EventGadget = #IE_ContrastSG
                    contrast = Val(GetGadgetText(#IE_ContrastSG))
                  Else
                    contrast = GetGadgetState(#IE_ContrastTB) 
                  EndIf
                  If contrast> 200
                    contrast = 200
                  EndIf
                  If contrast < 0
                    contrast = 0
                  EndIf                  
                  SetGadgetText(#IE_ContrastSG, Str(contrast))
                  SetGadgetState(#IE_ContrastTB, contrast)
                                  
                  If EventGadget = #IE_BrightnessSG
                    brightness = Val(GetGadgetText(#IE_ContrastSG))
                  Else
                    brightness = GetGadgetState(#IE_BrightnessTB) 
                  EndIf
                   If brightness> 200
                    brightness = 200
                  EndIf
                  If brightness < 0
                    brightness = 0
                  EndIf 
                  SetGadgetText(#IE_BrightnessSG, Str(brightness))
                  SetGadgetState(#IE_BrightnessTB, brightness)
                
                
                
                temp = CopyImage(ImageTransf, #PB_Any)
                temp = IE_Contrast(temp, contrast, brightness,1)
                
                SetGadgetState(#IE_BalColNew, ImageID(temp))
                If temp > #Img_Max
                  FreeImage2(temp)
                EndIf
               
                
              Case #IE_ContrastOk  
                IE_Contrast(Layer(LayerID)\Image, contrast, brightness)
                If ImageTransf > #Img_Max
                  FreeImage2(ImageTransf)
                EndIf
                NewPainting = 1
                ScreenUpdate()
                quit = 1
                
          
          EndSelect
          
        Case #PB_Event_CloseWindow
          quit = 1
      EndSelect
      
      
    Until quit =1
    
   
    
    CloseWindow(#Win_Contrast)
    
   
    
    
    
  EndIf
  
  
EndProcedure

Procedure IE_WinLevel()
  
  IE_CloseWin()
  W1 = 300
  OptionsIE\Shape=1  
  If OpenWindow(#Win_Level,0, 0, W1, 150, Lang("Level"), #PB_Window_SystemMenu|#PB_Window_ScreenCentered, WindowID(#WinMain))
    yy = 10
    H1 = (W1 * layer(layerid)\H)/layer(layerid)\W
    
    ;ImageTransf = CopyImage(Layer(LayerID)\Image, #PB_Any)
    ; ResizeImage(ImageTransf, W1, H1)
    
    x = 10
    TrackBarGadget(#IE_BrightnessTB,x,yy,255,20,0,255)
    SetGadgetState(#IE_BrightnessTB,255)
    yy+30
    TrackBarGadget(#IE_ContrastTB,x,yy,255,20,0,255)
    SetGadgetState(#IE_ContrastTB,0)
    
    ButtonGadget(#IE_ContrastOk,WindowWidth(#Win_Level)/2-30,WindowHeight(#Win_Level)-30,60,20,lang("Ok"))

;     Repeat
;       
;       event = WaitWindowEvent(10)
;       
;       Select event
;           
;         Case #PB_Event_Gadget
;           
;           Select EventGadget()
;               
;            
;               
;           EndSelect
;           
;         Case #PB_Event_CloseWindow
;           quit = 1
;           
;       EndSelect
;       
;     Until quit = 1
;     
;     
;     CloseWindow(#Win_Contrast)
;     OptionsIE\Shape=0
    
  EndIf
  
  
  
EndProcedure

;}


;{ image transformations
; miror
Procedure MirorImage(Img,mirorH=1)
  
  
  Width = ImageWidth(Img)
  Height = ImageHeight(Img)
  
  NewImg = CreateImage(#PB_Any, Width, Height, 32, #PB_Image_Transparent)

  If mirorH = 1 ; miroir horizontal
    
    If NewImg
      
      If StartDrawing(ImageOutput(NewImg))
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        For x = Width - 1 To 0 Step -1
          StripeImg = GrabImage(Img, #PB_Any, x, 0, 1, Height)
          If StripeImg
            DrawAlphaImage(ImageID(StripeImg), Width - x - 1, 0) 
            FreeImage(StripeImg)
          EndIf
        Next x
        
        StopDrawing()
        ; SaveImage(NewImg, Filename$ + ".mirrored.jpg", #PB_ImagePlugin_JPEG)
        
      EndIf
      
      
    EndIf
    
  Else ; miroir vertical
    
     If NewImg
      
      If StartDrawing(ImageOutput(NewImg))
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        For y = Height - 1 To 0 Step -1
          StripeImg = GrabImage(Img, #PB_Any, 0, y, Width, 1)
          If StripeImg
            DrawAlphaImage(ImageID(StripeImg), 0, Height - y - 1) 
            FreeImage(StripeImg)
          EndIf
        Next y
        
        StopDrawing()
        
      EndIf
      
    EndIf
    
  EndIf
  
  If NewImg
    FreeImage2(layer(layerid)\Image)
    Layer(layerid)\Image = CopyImage(NewImg,#PB_Any)
    FreeImage2(NewImg)
    Newpainting = 1
    ScreenUpdate(0)
  EndIf

EndProcedure
  
; Rotation
Procedure.l RotateImageEx2(ImageID, Angle.f, Mode.a=2) ; Rotation d'une image d'un angle en ° - rotation of an image, in degres.
  
  Shared ImageBrushW.w,ImageBrushH.w
  ; Procedure par Le Soldat inconnu - Merci 
  
  Protected bmi.BITMAPINFO, bmi2.BITMAPINFO, hdc.l, NewImageID, Mem, n, nn, bm.BITMAP
  
;   If IsImage(NewImageID)
;     FreeImage(NewImageID)
;   EndIf
  
  
  Angle = Angle * #PI / 180 ; On convertit en radian
  
  Cos.f = Cos(Angle)
  Sin.f = Sin(Angle)
  
  CouleurFond = Brush(action)\ColorQ ; 0
  
  GetObject_(ImageID, SizeOf(BITMAP), @bm.BITMAP) ; windows only; is there a version for linux, mac os ?
  
  bmi\bmiHeader\biSize = SizeOf(BITMAPINFOHEADER)
  bmi\bmiHeader\biWidth = bm\bmWidth
  bmi\bmiHeader\biHeight = bm\bmHeight
  bmi\bmiHeader\biPlanes = 1
  bmi\bmiHeader\biBitCount = 32
  
  bmi2\bmiHeader\biSize = SizeOf(BITMAPINFOHEADER)
;   Select Mode
;     Case 1
;       bmi2\bmiHeader\biWidth = bm\bmWidth
;       bmi2\bmiHeader\biHeight = bm\bmHeight
;     Case 2
      bmi2\bmiHeader\biWidth = Round(Sqr(bm\bmWidth * bm\bmWidth + bm\bmHeight * bm\bmHeight), 1)
      bmi2\bmiHeader\biHeight = bmi2\bmiHeader\biWidth
;     Default
;       bmi2\bmiHeader\biWidth = Round(bm\bmWidth * Abs(Cos) + bm\bmHeight * Abs(Sin), 1)
;       bmi2\bmiHeader\biHeight = Round(bm\bmHeight * Abs(Cos) + bm\bmWidth * Abs(Sin), 1)
;   EndSelect
  bmi2\bmiHeader\biPlanes = 1
  bmi2\bmiHeader\biBitCount = 32
  
  Mem = AllocateMemory(bm\bmWidth * bm\bmHeight * 4)
  If Mem
    Mem2 = AllocateMemory(bmi2\bmiHeader\biWidth * bmi2\bmiHeader\biHeight * 4)
    If Mem2
      hdc = CreateCompatibleDC_(GetDC_(ImageID)) ; windows only
      If hdc
        GetDIBits_(hdc, ImageID, 0, bm\bmHeight, Mem, @bmi, #DIB_RGB_COLORS) ; on envoie la liste dans l'image / windows only
        DeleteDC_(hdc) ; windows only
      EndIf
      
      CX1 = bm\bmWidth - 1
      CY1 = bm\bmHeight - 1
      CX2 = bmi2\bmiHeader\biWidth - 1
      CY2 = bmi2\bmiHeader\biHeight - 1
      
      Mem01 = Mem + bm\bmWidth * 4
      Mem10 = Mem + 4
      Mem11 = Mem01 + 4
      
      Mem2Temp = Mem2
      
      For nn = 0 To CY2
        y1b.l = nn * 2 - CY2
        Temp1.f = CX1 - y1b * Sin
        Temp2.f = CY1 + y1b * Cos
        For n = 0 To CX2
          x1b.l = n * 2 - CX2
          
          x1.f = (Temp1 + x1b * Cos) / 2
          y1.f = (Temp2 + x1b * Sin) / 2
          
          x2.l = x1
          y2.l = y1
          
          If x1 < x2
            x2 - 1
          EndIf
          If y1 < y2
            y2 - 1
          EndIf
          
          x2b = x2 + 1
          y2b = y2 + 1
          
          If x2b >= 0 And x2 <= CX1 And y2b >= 0 And y2 <= CY1 ; On filtre si on est completement en dehors de l'image
            
            fx.f = x1 - x2
            fy.f = y1 - y2
            f00.f = (1 - fx) * (1 - fy)
            f01.f = (1 - fx) * fy
            f10.f = fx * (1 - fy)
            f11.f = fx * fy
            
            MemTemp = (x2 + y2 * bm\bmWidth) * 4
            
            If x2 >= 0 And x2 <= CX1
              If y2 >= 0 And y2 <= CY1
                c00 = PeekL(Mem + MemTemp)
              Else
                c00 = 0
              EndIf
              If y2b >= 0 And y2b <= CY1
                c01 = PeekL(Mem01 + MemTemp)
              Else
                c01 = 0
              EndIf
            Else
              c00 = 0
              c01 = 0
            EndIf
            If x2b >= 0 And x2b <= CX1
              If y2 >= 0 And y2 <= CY1
                c10 = PeekL(Mem10 + MemTemp)
              Else
                c10 = 0
              EndIf
              If y2b >= 0 And y2b <= CY1
                c11 = PeekL(Mem11 + MemTemp)
              Else
                c11 = 0
              EndIf
            Else
              c10 = 0
              c11 = 0
            EndIf
            
            Channel00 = c00 >> 24 & $FF
            Channel01 = c01 >> 24 & $FF
            Channel10 = c10 >> 24 & $FF
            Channel11 = c11 >> 24 & $FF
            Alpha = Channel00 * f00 + Channel01 * f01 + Channel10 * f10 + Channel11 * f11
            
            Channel00 = c00 >> 16 & $FF
            Channel01 = c01 >> 16 & $FF
            Channel10 = c10 >> 16 & $FF
            Channel11 = c11 >> 16 & $FF
            Bleu = Channel00 * f00 + Channel01 * f01 + Channel10 * f10 + Channel11 * f11
            
            Channel00 = c00 >> 8 & $FF
            Channel01 = c01 >> 8 & $FF
            Channel10 = c10 >> 8 & $FF
            Channel11 = c11 >> 8 & $FF
            Vert = Channel00 * f00 + Channel01 * f01 + Channel10 * f10 + Channel11 * f11
            
            Channel00 = c00 & $FF
            Channel01 = c01 & $FF
            Channel10 = c10 & $FF
            Channel11 = c11 & $FF
            Rouge  = Channel00 * f00 + Channel01 * f01 + Channel10 * f10 + Channel11 * f11
            
            PokeL(Mem2Temp, Rouge | Vert << 8 | Bleu  << 16 | Alpha << 24)
            
          Else
            PokeL(Mem2Temp, 0)
          EndIf
          
          Mem2Temp + 4
          
        Next
      Next
      
      ; On crée la nouvelle image
      NewImageID = CreateImage(#PB_Any, bmi2\bmiHeader\biWidth, bmi2\bmiHeader\biHeight, 32)
      ImageBrushW = bmi2\bmiHeader\biWidth
      ImageBrushH = bmi2\bmiHeader\biHeight
      
      hdc = CreateCompatibleDC_(GetDC_(ImageID(NewImageID)))
      If hdc
        SetDIBits_(hdc, ImageID(NewImageID), 0, bmi2\bmiHeader\biHeight, Mem2, @bmi2, #DIB_RGB_COLORS) ; on envoie la liste dans l'image
        DeleteDC_(hdc)
      EndIf
      
      FreeMemory(Mem2)
    EndIf
    FreeMemory(Mem)
  EndIf
  
  ProcedureReturn NewImageID
EndProcedure

Procedure RotateImage_Menu(mode=0)
  
  If mode = 0 ; 90
    
    For i =0 To ArraySize(layer())-1
      Layer_Rotate(i,90)
      Newpainting = 1
      ScreenUpdate(1)
    Next i 
    
  ElseIf mode = 1 ; 180
    
    For i =0 To ArraySize(layer())-1
      Layer_Rotate(i,180)
      Newpainting = 1
      ScreenUpdate(1)
    Next i
    
  ElseIf mode = 2 ; 270
    
    For i =0 To ArraySize(layer())-1
      Layer_Rotate(i,270)
      Newpainting = 1
      ScreenUpdate(1)
    Next i
    
  ElseIf mode = 3 ; free
    
    angle = Val(InputRequester(Lang("Define angle"),Lang("Define angle"),""))
    If angle <> 0
      
      For i =0 To ArraySize(layer())-1
        Layer_Rotate(i,angle)
        Newpainting = 1
        ScreenUpdate(1)
      Next i
      
    EndIf
    
  EndIf
  
  
  
EndProcedure


;}




;{ Blendmode, drawingmode brush


;{ Drawingmode brush

; Checker
Procedure cb4(x,y,top,bottom)
  Protected x1 = ((x + 1) / #thickness)
  Protected y1 = ((y + 1) / #thickness)
  If((x1+y1)%3)
    ProcedureReturn top
  EndIf
 
  ProcedureReturn bottom
EndProcedure
Procedure cb3(x,y,top,bottom)
  If (x+y) & 4; & 8 for 8 pixel thickness
    ProcedureReturn top
  Else 
    ProcedureReturn bottom
  EndIf
EndProcedure
Procedure cb(x,y,top,bottom)
  If (x!y) & 8; checkerboard pattern
    ProcedureReturn top
  Else 
    ProcedureReturn bottom
  EndIf
EndProcedure
Procedure cb_isometric(x,y,top,bottom)
  If (x/2+y)!(x/2-y) & 32; diagonal checkerboard pattern
    ProcedureReturn top
  Else 
    ProcedureReturn bottom
  EndIf
EndProcedure
Procedure cb2(x,y,top,bottom)
 
  If((x+y)%(#thickness*2)>=#thickness)
    ProcedureReturn top
  EndIf
 
  ProcedureReturn bottom
EndProcedure






;{ filtre, mask...
Procedure Filtre_MaskAlpha(x, y, CouleurSource, CouleurDestination)
   ProcedureReturn (CouleurSource & $00FFFFFF) | (Alpha(CouleurSource)*Alpha(CouleurDestination)/255)<<24
 EndProcedure
 
Procedure Filtre_AlphaSel(x, y, CouleurSource, CouleurDestination)
   ProcedureReturn (CouleurSource & $00FFFFFF) | (Alpha(CouleurSource)*Alpha(CouleurDestination)/255)<<24
EndProcedure

Procedure Filtre_MelangeAlpha2(x, y, CouleurSource, CouleurDestination) ;; filter To mix alpha for the eraser tool
   ; By Le Soldat inconnu
   ; modif by blendman
  If Alpha(CouleurDestination)-Alpha(CouleurSource)>=0    
    ProcedureReturn RGBA(Red(CouleurDestination), Green(CouleurDestination), Blue(CouleurDestination), Alpha(CouleurDestination)-Alpha(CouleurSource))
  Else
    ProcedureReturn RGBA(Red(CouleurDestination), Green(CouleurDestination), Blue(CouleurDestination), 0)
  EndIf
EndProcedure

Procedure FiltreMelangeAlpha2(x, y, SourceColor, TargetColor) ; filter To mix alpha for the eraser tool
  ; By Le Soldat inconnu
  ; modif by blendman
  If Alpha(TargetColor) - Alpha(SourceColor) >= 0    
    ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor), Alpha(TargetColor)-Alpha(SourceColor))
  Else
    ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor), 0)
  EndIf
EndProcedure

Procedure FiltreMelangeAlphaPat(x, y, SourceColor, TargetColor) ; filter To mix alpha for the pattern tool
  If Alpha(TargetColor) + Alpha(SourceColor) <= 255    
    ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor), Alpha(SourceColor)+Alpha(TargetColor))
  Else
    ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor), 255)
  EndIf
EndProcedure

Procedure FiltreWater(x, y, SourceColor, TargetColor)
  ; By Le Soldat inconnu
  ; modif by blendman
  If Alpha(TargetColor)-Alpha(SourceColor) >= 0    
    ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor), Alpha(TargetColor)-Alpha(SourceColor))
  Else
    ; ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor), Alpha(SourceColor))
    ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor), Alpha(SourceColor) - Alpha(TargetColor))
  EndIf
EndProcedure

Procedure FilterLight(x, y, SourceColor, TargetColor)
  
  r = Red(TargetColor)
  g = Green(TargetColor)
  b = Blue(TargetColor)
  u.d = 1+ Brush(action)\filter*0.001
  
  If R*u<=255
    R*u
  EndIf  
  If G*u<=255
    G*u
  EndIf  
  If B*u<=255
    B*u
  EndIf  
  
  A = Alpha(SourceColor) * Alpha(TargetColor) 
  If A > 255
    A= 255
  ElseIf A = 0
     A = Alpha(TargetColor) 
  EndIf
   ;A = Alpha(TargetColor) 
  ProcedureReturn RGBA(R,G,B,A)
EndProcedure

Procedure FilterColor(x, y, SourceColor, TargetColor)
  
  r = Red(TargetColor)
  g = Green(TargetColor)
  b = Blue(TargetColor)
  R1 = Brush(action)\ColorBG\R
  G1 = Brush(action)\ColorBG\G
  B1 = Brush(action)\ColorBG\B
  u.d = 0.01
  If (R+R1*u)<=255
    R = (R+R1)
  EndIf  
  If (G+G1)<=255
    G = (G+G1)
  EndIf  
  If (B+B1)<=255
    B = (B+B1)
  EndIf  
  
;   A = Alpha(SourceColor) * Alpha(TargetColor) 
;   If A > 255
;     A= 255
;   ElseIf A = 0
;      A = Alpha(TargetColor) 
;   EndIf
  A = Alpha(TargetColor) 
  ProcedureReturn RGBA(R,G,B,A)
EndProcedure

Procedure FilterMagicWitch(x, y, SourceColor, TargetColor)
  ; c'est un test  = une erreur, mais ça fait comme un filtre de sélection :)
  r = Red(TargetColor)
  g = Green(TargetColor)
  b = Blue(TargetColor)
  R1 = Brush(action)\ColorBG\R
  G1 = Brush(action)\ColorBG\G
  B1 = Brush(action)\ColorBG\B
  If R+R1/2<=255
    R+R1/2
  EndIf  
  If G+G1/2<=255
    G+G1/2
  EndIf  
  If B+B1/2<=255
    B+B1/2
  EndIf  
  
;   A = Alpha(SourceColor) * Alpha(TargetColor) 
;   If A > 255
;     A= 255
;   ElseIf A = 0
;      A = Alpha(TargetColor) 
;   EndIf
  A = Alpha(TargetColor) 
  ProcedureReturn RGBA(R,G,B,A)
EndProcedure

Procedure FilterDark(x, y, SourceColor, TargetColor)
  
  r = Red(TargetColor)
  g = Green(TargetColor)
  b = Blue(TargetColor)
  u.d = 0.999 - Brush(action)\filter*0.001
  
  If R*u>0
    R*u
  EndIf  
  If G*u>0
    G*u
  EndIf  
  If B*u>0
    B*u
  EndIf  
  A = Alpha(TargetColor)
  
  ProcedureReturn RGBA(R,G,B,A)  
EndProcedure
  
Procedure FilterRed(x, y, SourceColor, TargetColor)
    ; Ne modifie que la composante rouge de la Source
    ProcedureReturn RGBA(Red(SourceColor), Green(TargetColor), Blue(TargetColor), Alpha(TargetColor))
  EndProcedure
 
  
  
Procedure FiltreSmudge(x, y, SourceColor, TargetColor) 
  
  If Alpha(TargetColor) - Alpha(SourceColor) >= 0  
    ;If Alpha(SourceColor)*Alpha(TargetColor)/255>= 0  
    ProcedureReturn RGBA((Red(SourceColor)*Red(TargetColor))/255,(Green(SourceColor)*Green(TargetColor))/255,(Blue(SourceColor)*Blue(TargetColor))/255, Alpha(TargetColor) - Alpha(SourceColor))
    ; ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor),Alpha(TargetColor))
  Else
    ProcedureReturn RGBA(Red(TargetColor), Green(TargetColor), Blue(TargetColor), Alpha(SourceColor))
  EndIf
EndProcedure

Procedure FilterGlass(x, y, SourceColor, TargetColor)
  
  If (x+y)%5=0
    ProcedureReturn TargetColor
  EndIf
  xn=x-1+Random(2)
  yn=y-1+Random(2)
  If xn<0 Or xn>=OutputWidth() Or yn<0 Or yn>=OutputHeight()
    ProcedureReturn TargetColor
  EndIf
  
  ProcedureReturn Point(xn,yn)
EndProcedure

Procedure FilterNoise(x, y, SourceColor, TargetColor)
  
  If (x+y)%3=0
    ProcedureReturn TargetColor
  EndIf
  xn=x-1+Random(3)
  yn=y-1+Random(3)
  If xn<0 Or xn>=OutputWidth() Or yn<0 Or yn>=OutputHeight()
    ProcedureReturn TargetColor
  EndIf
  
  ProcedureReturn Point(xn,yn)
EndProcedure

Procedure FilterLine(x, y, SourceColor, TargetColor)
  
  ; If Alpha(SourceColor)>0
    u.a = 15
    v = Brush(action)\Filter
    If (x+y)%u<=6
      ProcedureReturn TargetColor
    EndIf
    xn=x+v; Random(u)-Random(u)
    yn=y+v; Random(u)-Random(u)
    If xn<0 Or xn>=OutputWidth() Or yn<0 Or yn>=OutputHeight()
      ProcedureReturn TargetColor
    EndIf    
    ProcedureReturn Point(xn,yn)
  ; EndIf
  
EndProcedure

Procedure PixelFilterCallback(x, y, SourceColor, TargetColor)
   #pixelSize=5
   xn=#pixelSize*(x/#pixelSize)
   yn=#pixelSize*(y/#pixelSize)
   ProcedureReturn Point(xn,yn)
EndProcedure

Procedure SetBlurRadius(radius)
  
  Global BlurRadius=radius
  Global BlurFactor.f=1 / ((radius * 2 + 1) * (radius * 2 + 1))
  
  Global Dim BlurLayer.l(OutputWidth() - 1, OutputHeight() - 1)
  
EndProcedure
Procedure BlurFilter(x, y, SourceColor, TargetColor)
  
  Global BlurRadius
  Global BlurFactor.f
  Shared BlurLayer()
  
  Protected.w r, g, b
   For yn=y - BlurRadius To y + BlurRadius
      For xn=x - BlurRadius To x + BlurRadius
         If xn<0 Or xn>=OutputWidth() Or yn<0 Or yn>=OutputHeight() ;Or (xn=x And yn=y)
            Continue
         EndIf
         
         If Not BlurLayer(xn, yn)
            BlurLayer(xn, yn)=Point(xn, yn)
         EndIf
         cn=BlurLayer(xn, yn)
         d=Sqr((xn-x)*(xn-x)+(yn-y)*(yn-y))
         k.f=BlurFactor;Cos((d/(1+BlurRadius))*0.5*#PI)
         ak.f=Alpha(cn)/ 255         
         r + Red(cn) * BlurFactor * ak
         g + Green(cn) * BlurFactor * ak
         b + Blue(cn) * BlurFactor * ak
      Next
   Next
   
;    
   If Alpha(TargetColor) - Alpha(SourceColor) < 0  
     res=RGBA(r, g, b, Alpha(TargetColor)-Alpha(SourceColor))
   Else
    res=RGBA(r, g, b, Alpha(TargetColor))
  EndIf
   res=RGBA(r, g, b, Alpha(TargetColor))
   
   ProcedureReturn res
EndProcedure

Procedure BlurFilterSpace(x, y, SourceColor, TargetColor)
   Global BlurRadius
   Global BlurFactor.f
   Shared BlurLayer()
   
   Protected.w r, g, b
   For yn=y - BlurRadius To y + BlurRadius
      For xn=x - BlurRadius To x + BlurRadius
         If xn<0 Or xn>=OutputWidth() Or yn<0 Or yn>=OutputHeight() ;Or (xn=x And yn=y)
            Continue
         EndIf
         
         If Not BlurLayer(xn, yn)
            BlurLayer(xn, yn)=Point(xn, yn)
         EndIf
         cn=BlurLayer(xn, yn)
         ;d=Sqr((xn-x)*(xn-x)+(yn-y)*(yn-y))
         ;k.f=BlurFactor;Cos((d/(1+BlurRadius))*0.5*#PI)
         ak.f=Alpha(cn) / 255         
         r + Red(cn) * BlurFactor * ak
         g + Green(cn) * BlurFactor * ak
         b + Blue(cn) * BlurFactor * ak
      Next
   Next
   
   
  If Alpha(TargetColor) - Alpha(SourceColor) >= 0  
     res=RGBA(r, g, b, Alpha(TargetColor)-Alpha(SourceColor))
     res=RGBA(r, g, b, Alpha(SourceColor))
     res=RGBA(r, g, b, ak)
   Else
    res=RGBA(r, g, b, 0)
  EndIf
   
   
   ProcedureReturn res
EndProcedure

Procedure solEffect(x,y,sourceColor,targetColor)
  Protected xn.l,yn.l
  If (x+y)%5=0
    ProcedureReturn targetColor
  EndIf
  xn=x-1+Random(2)
  yn=y-1+Random(2)
  If xn<0 Or xn>=OutputWidth() Or yn<0 Or yn>=OutputHeight()
    ProcedureReturn targetColor
  EndIf
  ProcedureReturn Point(xn,yn)
EndProcedure


;}

;}


;{ blendmode

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
    Red= 255
  Else
    result= 255 - Red(SourceColor)
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
      Green = min(Green(TargetColor) * 255 / (result), 255)
    ElseIf result =0
      green = min(Green(TargetColor) * 255, 255)
    EndIf   
  EndIf
  
  ProcedureReturn RGBA(red, green, blue, Alpha(TargetColor))
EndProcedure

Procedure bm_multiply(x, y, SourceColor, TargetColor)
  ;ProcedureReturn RGBA((Red(SourceColor)*Red(TargetColor))/255,(Green(SourceColor)*Green(TargetColor))/255,(Blue(SourceColor)*Blue(TargetColor))/255, Alpha(SourceColor)*Alpha(TargetColor)/255)
  ProcedureReturn RGBA((Red(SourceColor)*Red(TargetColor))/255,(Green(SourceColor)*Green(TargetColor))/255,(Blue(SourceColor)*Blue(TargetColor))/255, Alpha(TargetColor))
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

Procedure bm_ColorBurn(x,y,SourceColor,TargetColor)
  ; color = top <= 0? 0 :  max(255 - ((255 - bottom) * 255 / top), 0)
  top = Red(SourceColor)
  bottom = Red(TargetColor)
  
  If  top <=0
    Red = 0
  Else       
    Red = max(255 - ((255 - bottom) * 255 / top), 0)
  EndIf
  
  top = Blue(SourceColor)
  bottom = Blue(TargetColor)
  If  top <=0
    blue = 0
  Else
    blue = max(255 - ((255 - bottom) * 255 / top), 0)
  EndIf
  
  top = Green(SourceColor)
  bottom = Green(TargetColor)
  If  top <= 0
    Green = 0
  Else    
    Green = max(255 - ((255 - bottom) * 255 / top), 0)
  EndIf
  
  ProcedureReturn RGBA(red, green, blue, Alpha(TargetColor))
EndProcedure

Procedure bm_ColorLight(x,y,SourceColor,TargetColor)
  top = Red(TargetColor)
  bottom = Red(SourceColor)
  
  If  top <=0
    Red = 0
  Else       
    Red = max(255 - ((255 - bottom) * 255 / top), 0)
  EndIf
  
  top = Blue(TargetColor)
  bottom = Blue(SourceColor)
  If  top <=0
    blue = 0
  Else
    blue = max(255 - ((255 - bottom) * 255 / top), 0)
  EndIf
  
  top = Green(TargetColor)
  bottom = Green(SourceColor)
  If  top <= 0
    Green = 0
  Else    
    Green = max(255 - ((255 - bottom) * 255 / top), 0)
  EndIf
  
  ProcedureReturn RGBA(red, green, blue, Alpha(TargetColor))
EndProcedure

Procedure bm_Dissolve(x, y, SourceColor, TargetColor)

EndProcedure

Procedure bm_difference(x, y, SourceColor, TargetColor)
  ;  color = dif( bottom, top )
  ProcedureReturn RGBA(Red(TargetColor)-Red(SourceColor),Green(TargetColor)-Green(SourceColor),Blue(TargetColor)-Blue(SourceColor),Alpha(TargetColor))
EndProcedure

Procedure bm_Exclusion(x, y, SourceColor, TargetColor)
  ; color = 255 - ( ( ( 255 - bottom ) * ( 255 - top ) / 255 ) + ( bottom * top / 255 ) )
  
  ProcedureReturn RGBA(red,green,blue,Alpha(TargetColor))
EndProcedure

Procedure bm_lighten(x, y, SourceColor, TargetColor)
  ; color = min( bottom, top )
  red = min(Red(TargetColor),Red(SourceColor))
  blue = min(Blue(TargetColor),Blue(SourceColor))
  green = min(Green(TargetColor),Green(SourceColor))
  ProcedureReturn RGBA(red,green,blue, Alpha(TargetColor))
EndProcedure

Procedure bm_darken(x, y, SourceColor, TargetColor)
  ;  color = max( bottom, top )
  red = max(Red(TargetColor),Red(SourceColor))
  blue = max(Blue(TargetColor),Blue(SourceColor))
  green = max(Green(TargetColor),Green(SourceColor))
  ProcedureReturn RGBA(red,green,blue, Alpha(TargetColor))
EndProcedure


Macro hardlight(col)
  If top < 128
    col = ( 2 * bottom * top ) / 255
  Else
    col = 255 - ( ( 2 * ( 255 - bottom ) * ( 255 - top ) ) / 255 )
  EndIf
  ; other
;   If top < 128 
;   col = (bottom*top) /128
; Else
;   col = 255 - ((255-bottom) * (255-top) /128);
; EndIf
EndMacro

Procedure bm_hardlight(x, y, SourceColor, TargetColor)
  ;color = top < 128 ? ( 2 * bottom * top ) / 255 : 255 - ( ( 2 * ( 255 - bottom ) * ( 255 - top ) ) / 255 )
  top = Red(SourceColor)
  bottom = Red(TargetColor)
  hardlight(red)
  top = Green(SourceColor)
  bottom = Green(TargetColor)
  hardlight(green)
  top = Blue(SourceColor)
  bottom = Blue(TargetColor)
  hardlight(blue)
  ProcedureReturn RGBA(red,green,blue, Alpha(TargetColor))
EndProcedure

Procedure bm_Clearlight(x, y, SourceColor, TargetColor)
  ;color = top < 128 ? ( 2 * bottom * top ) / 255 : 255 - ( ( 2 * ( 255 - bottom ) * ( 255 - top ) ) / 255 )
  top = Red(TargetColor)
  bottom = Red(SourceColor)
  hardlight(red)
  top = Green(TargetColor)
  bottom = Green(SourceColor)
  hardlight(green)
  top = Blue(TargetColor)
  bottom = Blue(SourceColor)
  hardlight(blue)
  ProcedureReturn RGBA(red,green,blue, Alpha(TargetColor))
EndProcedure

;}


;}



Procedure SetBm(i,sprite=1)
  
  DrawingMode(#PB_2DDrawing_AlphaBlend)  

  ; bm sprite
  If Sprite = 1
    
    Select layer(i)\bm
        
      Case #Bm_Normal
        Box(0,0,doc\w,doc\w,RGBA(0,0,0,0))
        
      Case #Bm_Lighten,#Bm_Add, #bm_screen,#Bm_ColorBurn 
        Box(0,0,doc\w,doc\h,RGBA(0,0,0,255))
        
      Case #Bm_Multiply, #bm_darken
        Box(0,0,doc\w,doc\h,RGBA(255,255,255,255))
        
      Case #bm_Overlay, #Bm_LinearBurn, #Bm_Inverse, #Bm_LinearLight
        Box(0,0,doc\w,doc\h,RGBA(127,127,127,255))
        
    EndSelect
  
  Else
    ; bm image
    Select layer(i)\bm
        
      Case #bm_custom
        Box(0,0,doc\w,doc\h, RGBA(Brush(action)\ColorBG\R,Brush(action)\ColorBG\G,Brush(action)\ColorBG\B,Brush(action)\alpha))
        
      Case #Bm_Normal
        Box(0,0,doc\w,doc\h, RGBA(0,0,0,0))
        
      Case #Bm_Add, #Bm_Screen, #Bm_Darken
        Box(0, 0, doc\w, doc\h, RGBA(0,0,0,255))                
        ;
      Case #Bm_Multiply, #Bm_ColorBurn, #bm_lighten, #Bm_Colorlight
        Box(0, 0, doc\w, doc\h, RGBA(255,255,255,255))   
        
      Case #Bm_Overlay, #Bm_LinearBurn, #Bm_Inverse, #Bm_Exclusion, #bm_Difference, #Bm_Hardlight, #Bm_Clearlight,#Bm_LinearLight
        Box(0, 0, doc\w, doc\h, RGBA(127,127,127,255)) 
        
    EndSelect   
    
  EndIf
  
  
EndProcedure




; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 2049
; FirstLine = 69
; Folding = AAAAAAgDMAAAAAAAAAQgCQVBAAQAAIAAAA+
; EnableXP
; EnableUnicode