
; Paint (Dot & Stroke...)


; drawingmode
Procedure IE_TypeDrawing()
  
  Static SetBlur
  
  Select Brush(Action)\Type 
      
    Case #ToolType_Eraser ;1  ; eraser pen      
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@Filtre_MelangeAlpha2())  
      
    Case #ToolType_Water; 3      
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@FiltreWater())  
      
    Case #ToolType_Sol     
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@solEffect()) 
      
      
    Case #ToolType_Smudge      
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@FiltreSmudge())  
      
    ;Case #ToolType_Shape      
      ; DrawingMode(#PB_2DDrawing_AlphaBlend)
      ; Box(0, 0, Doc\W, Doc\H, RGBA(0,0,0,255))   
      
      ; DrawingMode(#PB_2DDrawing_AlphaChannel)
      ; Box(0,0,Doc\W, Doc\H,RGBA(0,0,0,0))      
      ;If layer(LayerID)\LockAlpha
        ;DrawingMode(#PB_2DDrawing_AlphaClip)
      ;Else
      ;DrawingMode(#PB_2DDrawing_AlphaBlend)
      ;EndIf
      
    Case #ToolType_Glass
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@FilterGlass())
      
      
    Case #ToolType_Light
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@FilterLight())
      
    Case #ToolType_Color
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@FilterColor())
      
    Case #ToolType_Dark
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@FilterDark())
       
    Case #ToolType_Line
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@FilterLine())
      
      
    Case #ToolType_Noise
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@FilterNoise())
      
    Case #ToolType_Pixel
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@PixelFilterCallback())

    Case #ToolType_Blur
      If SetBlur = 0
        SetBlurRadius(2)
        SetBlur = 1
      EndIf
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@BlurFilter())

       
    Default
      ;Case #ToolType_Brush, #ToolType_Pen ; 0 : brush
      If layer(LayerID)\LockAlpha ; Or    
        DrawingMode(#PB_2DDrawing_AlphaClip) 
     ; ElseIf OptionsIE\SelectAlpha = 1     
;         If layer(layerid)\Bm = #Bm_Normal
;           DrawingMode(#PB_2DDrawing_AlphaChannel)
;           DrawAlphaImage(ImageID(#Img_AlphaSel),0,0)  
;           DrawingMode(#PB_2DDrawing_CustomFilter)
;           CustomFilterCallback(@Filtre_MaskAlpha())
;         Else
;           DrawingMode(#PB_2DDrawing_AllChannels)
;           DrawAlphaImage(ImageID(#Img_AlphaSel),0,0)  
;           DrawingMode(#PB_2DDrawing_AlphaClip)
;         EndIf    
      Else        
        DrawingMode(#PB_2DDrawing_AlphaBlend)        
      EndIf
      
      
  EndSelect
  
EndProcedure



; macro 
Macro IE_DrawBegin() 
  
  If StartDrawing(ImageOutput(layer(layerid)\Image))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
  
EndMacro
Macro IE_DrawEnd()  
  
    StopDrawing()
  EndIf
  
EndMacro

Macro CheckAlpha()
  ; pour calculer l'apha, avec l'apha pressure
  ;If brush(#Action_Brush)\Water > 0 And action <> #Action_Eraser
  ;EndIf
  alpha1 = Brush(Action)\AlphaRand*Random(Brush(Action)\alpha,Brush(Action)\AlphaMin) + (1-Brush(Action)\AlphaRand)*Brush(Action)\alpha
  ; alpha1 = alpha1 
  alpha = alpha1 * size
  alpha = (Alpha*0.1)*Brush(Action)\alphaPressure + (1-Brush(Action)\alphaPressure)*alpha1
  If alpha > 255
    alpha = 255
  ElseIf alpha < 0
    alpha= 0
  EndIf 
  
EndMacro
Macro StartDrawing2(output)
  StartDrawing(output)
EndMacro




; cercles, ellipses
Procedure MyCircle(x,y,radius,color,width=0,mode=0)
  
  ; by ??
  
   Global MyCircleSmooth=2

   Protected d.d,s.d
   Protected fillcolor
   Protected xxcolor

   width-MyCircleSmooth>>1
   Debug width
   If width
      radius+width>>1
   EndIf

   If radius>0
      s=MyCircleSmooth
      If s<=0
         s=0.0001
      EndIf

      d=1/(radius+s)
      fillcolor=color|$FF000000
      xxcolor=color|$40000000

      DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
      ResetGradientColors()

      GradientColor(0,fillcolor)
      If mode=#PB_2DDrawing_Outlined
         GradientColor(0,color)
         GradientColor(d*(radius-width-s),color)
         GradientColor(d*(radius-width-s/2),xxcolor)
         GradientColor(d*(radius-width),fillcolor)
      EndIf
      GradientColor(d*radius,fillcolor)
      GradientColor(d*(radius+s/2),xxcolor)
      GradientColor(1,color)
      CircularGradient(x,y,radius)
      Circle(x,y,radius)

   EndIf

EndProcedure
Procedure AntialiasedCircle(StartX.d, StartY.d, Radius.d, AntiLength.d, Color.i)
  
  ; by ??
  
  Define.i R,G,B
  Define.d Normal, Value
 
  If Radius <= 0
    Radius = 0.00001
  EndIf
 
  If AntiLength <= 0
    AntiLength = 0.00001
  EndIf
 
  DrawingMode(#PB_2DDrawing_AlphaBlend | #PB_2DDrawing_Gradient)
 
  ResetGradientColors()
 
  R = Red(Color)
  G = Green(Color)
  B = Blue(Color)
 
  Normal = 1 / Radius
  Value  = 1.0 - AntiLength * Normal
  value2 =  Value - AntiLength * 0.5
  
  GradientColor(  0.0, RGBA(R,G,B,255))
  GradientColor(Value, RGBA(R,G,B,20))
  GradientColor(Value2, RGBA(R,G,B,255))
  GradientColor(  1.0, RGBA(R,G,B,0))
 
  CircularGradient(StartX, StartY, Radius)
  Circle(StartX, StartY, Radius)
 
EndProcedure

Procedure EllipseAA(X, Y, RadiusX, RadiusY, Color, Thickness = 1, Mode = #PB_2DDrawing_Default)
  Protected n, nn, Distance.f, Application.f, Couleur_Fond.l, Ellispse_Rayon.f, Ellipse_E.f
  ; Précacul de l'équation de l'ellipse
  If RadiusX > RadiusY
    Ellipse_E = Sqr(RadiusX * RadiusX - RadiusY * RadiusY) / RadiusX
  Else
    Ellipse_E = Sqr(RadiusY * RadiusY - RadiusX * RadiusX) / RadiusY
  EndIf
  Ellipse_E * Ellipse_E
  If Mode & #PB_2DDrawing_Outlined ; ellipse vide
    ; on dessine 1/4 de l'ellipse et on duplique pour le reste
    For n = 0 To RadiusX
      For nn = 0 To RadiusY
        Distance.f = Sqr(n * n + nn * nn)
        If RadiusX > RadiusY
          If n
            Ellipse_CosAngle.f = n / Distance
            Ellispse_Rayon = Sqr(RadiusY * RadiusY / (1 - Ellipse_E * Ellipse_CosAngle * Ellipse_CosAngle))
          Else
            Ellispse_Rayon = RadiusY
          EndIf
        Else
          If nn
            Ellipse_CosAngle.f = nn / Distance
            Ellispse_Rayon = Sqr(RadiusX * RadiusX / (1 - Ellipse_E * Ellipse_CosAngle * Ellipse_CosAngle))
          Else
            Ellispse_Rayon = RadiusX
          EndIf
        EndIf
        x1 = X + n
        x2 = X - n
        y1 = Y + nn
        y2 = Y - nn
        w = OutputWidth()-1
        h = OutputHeight()-1
        If (x1>=0  And x1<w And y1>=0 And y1<h)  Or  (x2<w And x2>=0 And y2>=0 And y2<h)
          If Distance <= Ellispse_Rayon And Distance > Ellispse_Rayon - 1
            Application.f = Abs(Ellispse_Rayon - 1 - Distance)
            Couleur_Fond = Point(X + n, Y + nn)
            Plot(X + n, Y + nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X - n, Y + nn)
            Plot(X - n, Y + nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X + n, Y - nn)
            Plot(X + n, Y - nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X - n, Y - nn)
            Plot(X - n, Y - nn, ColorBlending(Couleur_Fond, Color, Application))
          ElseIf Distance <= Ellispse_Rayon - Thickness And Distance > Ellispse_Rayon - Thickness - 1
            Application.f = Abs(Ellispse_Rayon - Thickness - Distance)
            Couleur_Fond = Point(X + n, Y + nn)
            Plot(X + n, Y + nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X - n, Y + nn)
            Plot(X - n, Y + nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X + n, Y - nn)
            Plot(X + n, Y - nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X - n, Y - nn)
            Plot(X - n, Y - nn, ColorBlending(Couleur_Fond, Color, Application))
          ElseIf Distance <= Ellispse_Rayon - 1 And Distance > Ellispse_Rayon - Thickness
            Plot(X + n, Y + nn, Color)
            Plot(X - n, Y + nn, Color)
            Plot(X + n, Y - nn, Color)
            Plot(X - n, Y - nn, Color)
          EndIf
        EndIf
      Next
    Next
  Else ; ellipse pleine
    ; on dessine 1/4 de l'ellipse et on duplique pour le reste
    For n = 0 To RadiusX
      For nn = 0 To RadiusY
        Distance.f = Sqr(n * n + nn * nn)
        If RadiusX > RadiusY
          If n
            Ellipse_CosAngle.f = n / Distance
            Ellispse_Rayon = Sqr(RadiusY * RadiusY / (1 - Ellipse_E * Ellipse_CosAngle * Ellipse_CosAngle))
          Else
            Ellispse_Rayon = RadiusY
          EndIf
        Else
          If nn
            Ellipse_CosAngle.f = nn / Distance
            Ellispse_Rayon = Sqr(RadiusX * RadiusX / (1 - Ellipse_E * Ellipse_CosAngle * Ellipse_CosAngle))
          Else
            Ellispse_Rayon = RadiusX
          EndIf
        EndIf
        x1 = X + n
        x2 = X - n
        y1 = Y + nn
        y2 = Y - nn
        w = OutputWidth()-1
        h = OutputHeight()-1
        If x1 >=0 And x2>=0 And x1 <w And x2<w And y1>=0 And y2>=0 And y1<h And y2<h
          If Distance <= Ellispse_Rayon And Distance > Ellispse_Rayon - 1
            Application.f = 1 - (Ellispse_Rayon - Distance)
            Couleur_Fond = Point(X + n, Y + nn)
            Plot(X + n, Y + nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X - n, Y + nn)
            Plot(X - n, Y + nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X + n, Y - nn)
            Plot(X + n, Y - nn, ColorBlending(Couleur_Fond, Color, Application))
            Couleur_Fond = Point(X - n, Y - nn)
            Plot(X - n, Y - nn, ColorBlending(Couleur_Fond, Color, Application))
          ElseIf Distance <= Ellispse_Rayon - 1          
            Plot(X + n, Y + nn, Color)
            Plot(X - n, Y + nn, Color)
            Plot(X + n, Y - nn, Color)
            Plot(X - n, Y - nn, Color)
          EndIf
        EndIf
      Next
    Next
  EndIf
EndProcedure


; line
Procedure NormalL_OLd(X,Y, x3, y3, Color, alpha,Thickness = 1)
  
  ; BY LSI
  
  w = OutputWidth()
  h = OutputHeight() 
  
  Width = x3-X
  Hight = y3-Y
  
  Protected SignX, SignY, n, nn, Thick.f, x_2.f, y_2.f, Color_Found.l, Application.f, Hypo.f
 
  If Width >= 0
    SignX = 1
  Else
    SignX = -1
    Width = - Width
  EndIf
  If Hight >= 0
    SignY = 1
  Else
    SignY = -1
    Hight = - Hight
  EndIf 
 
 
  Thick.f = Thickness / 2
 
  Hypo.f = Sqr(Width * Width + Hight * Hight)
  CosPhi.f = Width / Hypo
  SinPhi.f = -Sin(ACos(CosPhi))
 
 
  For n = -Thickness To Width + Thickness
    For nn = -Thickness To Hight + Thickness
     

      x_2 = n * CosPhi - nn * SinPhi
      y_2 = Abs(n * SinPhi + nn * CosPhi)
     
      If y_2 <= Thick + 0.5
        Application =  0.5 + Thick - y_2
        If Application > 1
          Application = 1
        EndIf
        ;If x_2 > -1 And x_2 < Hypo + 1
        If x_2 > -1 And x_2 < Hypo 
          If x_2 < 0
            Application * (1 + x_2)
          ElseIf x_2 > Hypo
            Application * (1 - x_2 + Hypo)
          EndIf
        Else
          Application = 0
        EndIf
        If Application > 0
          xxx = X + n * SignX
          yyy = Y + nn * SignY
          If xxx>=0 And xxx<w And yyy>=0 And yyy<h
            If Application < 1
              ;Color_Found = Point(xxx, yyy)              
              ;Plot(xxx, yyy, ColorBlending(Color, Color_Found, Application))
              Plot(xxx, yyy, RGBA(Red(Color), Green(color),Blue(color),Alpha*0.3))
             ; Circle(xxx,yyy,1,color)
            Else
              Plot(xxx, yyy, RGBA(Red(Color), Green(color),Blue(color),Alpha))
              ;Plot(xxx, yyy, Color)
              ;Circle(xxx,yyy,1,color)
            EndIf
          EndIf
        EndIf
      EndIf     
    Next
  Next
 
EndProcedure
Procedure NormalL(X,Y, x3, y3, Color, Thickness = 1)
  ; By LSI
  
  
  Width = x3-X
  Hight = y3-Y
  
  Protected SignX, SignY, n, nn, Thick.f, x_2.f, y_2.f, Color_Found.l, Application.f, Hypo.f
 
  If Width >= 0
    SignX = 1
  Else
    SignX = -1
    Width = - Width
  EndIf
  If Hight >= 0
    SignY = 1
  Else
    SignY = -1
    Hight = - Hight
  EndIf 
 
 
  Thick.f = Thickness / 2
 
  Hypo.f = Sqr(Width * Width + Hight * Hight)
  CosPhi.f = Width / Hypo
  SinPhi.f = -Sin(ACos(CosPhi))
 
 
  For n = -Thickness To Width + Thickness
    For nn = -Thickness To Hight + Thickness
     

      x_2 = n * CosPhi - nn * SinPhi
      y_2 = Abs(n * SinPhi + nn * CosPhi)
     
      If y_2 <= Thick + 0.5
        If old = 1
        Application =  0.5 + Thick - y_2
        If Application > 1
          Application = 1
        EndIf
        If x_2 > -1 And x_2 < Hypo + 1
          If x_2 < 0
            Application * (1 + x_2)
          ElseIf x_2 > Hypo
            Application * (1 - x_2 + Hypo)
          EndIf
        Else
          Application = 0
        EndIf
        If Application > 0
          xxx = X + n * SignX
          yyy = Y + nn * SignY
          If xxx >=0 And xxx < ScreenWidth()-1 And yyy>=0 And yyy < ScreenHeight()-1
            If Application < 1
              ; Color_Found = Point(X + n * SignX, Y + nn * SignY)              
              ; Plot(xxx, yyy, ColorBlending(Color, Color_Found, Application))
              Plot(xxx, yyy, RGBA(Red(Color), Green(color),Blue(color),Alpha(color)*0.3))
             ; Circle(xxx,yyy,1,color)
            Else
              Plot(xxx, yyy, RGBA(Red(Color), Green(color),Blue(color),Alpha(color)*0.7))
              ;Plot(xxx, yyy, Color)
              ;Circle(xxx,yyy,1,color)
            EndIf
          EndIf
          EndIf
          Circle(x_2,y_2,Thick*2,RGBA(Red(Color), Green(color),Blue(color),Alpha(color)*0.3))
          Circle(x_2,y_2,Thick,RGBA(Red(Color), Green(color),Blue(color),Alpha(color)*0.7))
        EndIf
      EndIf     
    Next
  Next
 
EndProcedure


Procedure LineAA(X, Y, Width, Hight, Color, Thickness = 1)
  Protected SensX, SensY, n, nn, Epaisseur.f, x2.f, y2.f, Couleur_Fond.l, Application.f, Distance.f
  
  ; On mets la droite toujours dans le même sens pour l'analyse
  ; La sauvegarde du sens permettra de dessiner la droite ensuite dans le bon sens
  If Width >= 0
    SensX = 1
  Else
    SensX = -1
    Width = - Width
  EndIf
  If Hight >= 0
    SensY = 1
  Else
    SensY = -1
    Hight = - Hight
  EndIf
 
 
  ; Demi épaisseur de la ligne
  Epaisseur.f = Thickness / 2
 
  ; calcul pour le changement de repère qui permet de connaitre l'épaisseur du trait et de gérer l'AA
  Distance.f = Sqr(Width * Width + Hight * Hight)
  CosAngle.f = Width / Distance
  SinAngle.f = -Sin(ACos(CosAngle))
  ; Angle = GetAngle(Width+x,Hight+y,x,y)
  ; SinAngle.f = -Sin(Angle)
  
  ; Dessin de la ligne
  For n = -Thickness To Width + Thickness
    For nn = -Thickness To Hight + Thickness
     
      ; changement de base
      ; les y représentent l'épaisseur de la ligne
      x2 = n * CosAngle - nn * SinAngle
      y2 = Abs(n * SinAngle + nn * CosAngle)
     
      If y2 <= Epaisseur + 0.5
        Application =  0.5 + Epaisseur - y2
        If Application > 1
          Application = 1
        EndIf
        If x2 > -1 And x2 < Distance + 1
          If x2 < 0
            Application * (1 + x2)
          ElseIf x2 > Distance
            Application * (1 - x2 + Distance)
          EndIf
        Else
          Application = 0
        EndIf
        If Application > 0
          x1 = X + n * SensX
          y1 = Y + nn * SensY
          If x1>=0 And x1<OutputWidth()-1 And y1>=0 And y1<OutputHeight()-1
            If Application < 1              
              Couleur_Fond = Point(x1,y1)
              colo = ColorBlending(Color, Couleur_Fond, Application)
;               r = Red(colo)/3
;               g = Green(colo)/3
;               b = Blue(colo)/3
;               a = Alpha(colo)
;               col = RGB(r,g,b)*3
;               colo = RGBA(Red(col),Green(col), Blue(col),a)
              Plot(x1, y1, colo)
              ; Plot(X + n * SensX, Y + nn * SensY, RGBA(Red(color),Green(color),Blue(color),Alpha(color)/2))
            Else
              Plot(x1, y1, Color)
            EndIf
          EndIf
        EndIf
      EndIf
     
    Next
  Next
 
EndProcedure
Procedure LineLSI(xx,yy,StartX1,StartY1,colo,size,alpha)
  
  CheckAlpha()
  
  IE_TypeDrawing() ; le drawingmode (alphablend, clip si alphalock, etc..
  
  xx + Brush(Action)\centerSpriteX/2  
  StartX1 + Brush(Action)\centerSpriteX/2  
  yy + Brush(Action)\centerSpriteY/2
  StartY1 + Brush(Action)\centerSpriteY/2 
  col = RGBA(Red(colo),Green(colo),Blue(colo),alpha)
  LineAA(xx,yy,StartX1-xx,StartY1-yy,col,size)
  StopDrawing()
  
EndProcedure


Procedure ThickLine(x1, y1, x2, y2, size, color=0, mode=0);, dash.d = 0)
  ; By BP, thanks a lot !
  ; dash is space between dots for dotted lines.
  ; default dash = 0 is for solid lines.
  
  Protected dx, dy, e2, err, sx, sy, pStep.d, n.d
  Shared Z.d
  
  If size < 1 : size = 1 : EndIf

  dash.d = Brush(Action)\Pas 
  ;  dash.d = Brush(Action)\Pass / (Brush(Action)\size)
  
  If dash> 0
    
    pStep = size /2 + dash ; size << 1 + dash 
    ;pStep = Brush(Action)\size + dash 
    n = pStep 
    
  EndIf
  
  dx = Abs(x2-x1) : dy = Abs(y2-y1) : err = dx - dy
  ;size - 1
  
  z.d = OptionsIE\Zoom * 0.01
  
    x1 + Brush(Action)\centerSpriteX  
    x2 + Brush(Action)\centerSpriteX    
    y1 + Brush(Action)\CenterSpriteY  
    y2 + Brush(Action)\CenterSpriteY    
    x1/z
    x2/z
    y1/z
    y2/z
  
  
  If x1 < x2 : sx = 1 : Else : sx = -1 : EndIf
  If y1 < y2 : sy = 1 : Else : sy = -1 : EndIf
  
  
;   If Brush(Action)\Melange = 0
;     
;     IE_DrawBeginC() 
;     
;   EndIf
  
  IE_TypeDrawing()
  
  Repeat
    
    
    If dash > 0
      
      ;{ le pas est > 0
      
      If n < pStep 
        
        n + 2
       
      Else
        
        
        DrawImage(ImageID(#BrushCopy),x1,y1,size, size)
;         If Brush(Action)\Melange>=1
;           
;           IE_PaintBrush(x1, y1)  
;           
;         Else
;           
;           IE_PaintBrushNormal(x1, y1) 
;           
;         EndIf
      
        n = (Brush(Action)\size) /2 ; size >> 1
        
      EndIf
      ;}
      
    Else
      
      ;{ le pas = 0
      
      DrawImage(ImageID(#BrushCopy),x1,y1,size, size)  
      
;       If Brush(Action)\Melange
;         
;         IE_PaintBrush(x1, y1)  
;         
;       Else
;         
;         IE_PaintBrushNormal(x1, y1) 
;         
;       EndIf
   
      ;}
      
    EndIf
    
    If x1 = x2 And y1 = y2 : Break : EndIf
    e2 = err << 1
    If e2 > -dy : err - dy : x1 + sx : EndIf
    If e2 <  dx : err + dx : y1 + sy : EndIf
    
  ForEver
  
  
  ; IE_DrawEnd()
  
  ProcedureReturn screen 
EndProcedure

Procedure InkLine(xx,yy,StartX1,StartY1,size,colo)
  
  CheckAlpha()
  
  IE_TypeDrawing() ; le drawingmode (alphablend, clip si alphalock, etc..
  z.d = OptionsIE\Zoom * 0.01
  x1 = (Brush(Action)\centerSpriteX/2 )/z 
  y1 = (Brush(Action)\centerSpriteY/2)/z
  xx + x1
  StartX1 + x1
  yy + y1
  StartY1 + y1
  ; Debug Str(xx)+"/"+Str(yy)+" | "+Str(colo)+ " | "+Str(size)
  
    
  NormalL_OLd(xx,yy,StartX1,StartY1,colo,alpha, size)
  StopDrawing()
    
EndProcedure

Procedure DashDraw(P1x.f, P1y.f, P2x.f, P2y.f, DashValue.l=1, size.d=2, Color.l=0)
  
  ; By HB, german forum 2010
  
  Protected DashVal1, DashVal2, DashMax, iStep

  
  CheckAlpha()
  
  IE_TypeDrawing() ; le drawingmode (alphablend, clip si alphalock, etc..
  
  DashValue *0.5
  CheckIfInf(DashValue,1)
  
  ; there is a decalage ?
;   P1x + size/2
;   P1y + size/2
;   P2x + size/2
;   P2y + size/2
  P1x + Brush(Action)\CenterX 
  P1y + Brush(Action)\CenterY
  P2x + Brush(Action)\CenterX 
  P2y + Brush(Action)\CenterY
  
    
  DashBreak = DashValue *2
 
  NextPointX.f = P1x 
  NextPointY.f = P1y
 
  DistX.f = P2x - P1x
  DistY.f = P2y - P1y
 
  dx = P1x - P2x
  dy = P1y - P2y
  Distance = Sqr(dx*dx + dy*dy)
  
  R = Red(Color)
  G = Green(Color)
  B = Blue(Color)

  DashColor = RGBA(r,g,b,alpha)
  
  
  While Distance >= 1
   
    If DashValue >= iStep
     
      For iStep = 1 To DashValue
        
;         If action <> #Action_Eraser
;           ;AntialiasedCircle(NextPointX,NextPointY,size/2,1,DashColor)
;           MyCircle(NextPointX,NextPointY,size/2,DashColor,3)
;         Else
        If NextPointX > 0 And NextPointY> 0
          
          If brush(action)\StrokeTyp = 1
            Circle(NextPointX,NextPointY,size/2,DashColor)
          Else
            RotImg = #BrushCopy
            ;If brush(action)\SizeOld <> Size And size >=1
            If size >=1
              RotImg= CopyImage(#BrushCopy,#PB_Any)                                              
              ;ResizeImage(RotImg,ImageWidth(RotImg)*brush(action)\FinalSize, ImageHeight(RotImg)*brush(action)\FinalSize,1 - Brush(Action)\Smooth)
              ResizeImage(RotImg,Size,Size,1-Brush(Action)\Smooth)
              NX = size/2
              NY = size/2
              ok = 1
              ;brush(action)\SizeOld = Size
            EndIf
            DrawAlphaImage(ImageID(RotImg),NextPointX- NX,NextPointY-NY,alpha)  
            If ok = 1
               FreeImage2(RotImg)
            EndIf             
          EndIf          
          
        EndIf
      
        XSchritt.f = DistX/Distance
        YSchritt.f = DistY/Distance
       
        NextPointX = NextPointX + XSchritt
        NextPointY = NextPointY + YSchritt
       
        DistX = P2x - NextPointX
        DistY = P2y - NextPointY
       
        dxNeu.f = NextPointX - P2x
        dyNeu.f = NextPointY - P2y
        Distance = Sqr(dxNeu*dxNeu + dyNeu*dyNeu)
       
      Next
     
    Else
     
      For iStep = DashBreak To 1 Step -1
        
;         If action <> #Action_Eraser
;           MyCircle(NextPointX,NextPointY,size/2,DashColor,3)
;         Else
        If NextPointX > 0 And NextPointY> 0
          If brush(action)\StrokeTyp = 1
            Circle(NextPointX,NextPointY,size/2,DashColor)
          Else            
            RotImg = #BrushCopy
            If brush(action)\SizeOld <> Size And size >=1
              RotImg= CopyImage(#BrushCopy,#PB_Any)                                              
              ;ResizeImage(RotImg,ImageWidth(RotImg)*brush(action)\FinalSize, ImageHeight(RotImg)*brush(action)\FinalSize,1 - Brush(Action)\Smooth)
              ResizeImage(RotImg,Size,Size,1-Brush(Action)\Smooth)
              NX = size/2
              NY = size/2 
              ok = 1
              ;brush(action)\SizeOld = Size
            EndIf
            DrawAlphaImage(ImageID(RotImg),NextPointX-NX,NextPointY-NY,alpha) 
            If ok = 1
              FreeImage2(RotImg) 
            EndIf            
          EndIf   
        EndIf        
        
        XSchritt.f = DistX/Distance
        YSchritt.f = DistY/Distance
       
        NextPointX = NextPointX + XSchritt
        NextPointY = NextPointY + YSchritt
       
        DistX = P2x - NextPointX
        DistY = P2y - NextPointY
       
        dxNeu.f = NextPointX - P2x
        dyNeu.f = NextPointY - P2y
        Distance = Sqr(dxNeu*dxNeu + dyNeu*dyNeu)
       
      Next
     
    EndIf
   
  Wend
  
  StopDrawing()
  
EndProcedure






; drawing
Procedure DrawSymetry(RotImg,x,y,alpha)
  
  z.d = OptionsIE\Zoom * 0.01
  
  
 

  If Brush(Action)\Symetry > 0
    
    Select Brush(Action)\symetry
        
      Case 1 ; symetry en X
        x = x + ImageWidth(RotImg) 
        symX = Doc\w - x
        DrawAlphaImage(ImageID(RotImg),SymX,y,alpha)
        
      Case 2 ; symetry en Y
        y = y + ImageHeight(RotImg)
        symY = Doc\h - y
        DrawAlphaImage(ImageID(RotImg),x,SymY,alpha)
        
      Case 3 ; symetry X et Y
        x = x + ImageWidth(RotImg) 
        y = y + ImageHeight(RotImg)
        symX = Doc\w - x
        symY = Doc\h - y
        DrawAlphaImage(ImageID(RotImg),SymX,SymY,alpha)
        
      Case 4 ; 4 views
        x1 = x
        y1 = y
        x = x + ImageWidth(RotImg) 
        y = y + ImageHeight(RotImg)
        symX = Doc\w - x
        symY = Doc\h - y
        DrawAlphaImage(ImageID(RotImg), SymX ,SymY,alpha)
        DrawAlphaImage(ImageID(RotImg), x1, SymY,alpha)
        DrawAlphaImage(ImageID(RotImg), SymX ,y1,alpha)
        
    EndSelect                                  
    
  EndIf
  
  
EndProcedure

Macro DoPaint(xx,yy,StartX1,StartY1,size,colo,OutputID=0)
  
  ; pour peindre sur le sprite et sur l'image
  ; il faut la même procédure pour un rendu identique
  ; outputID permet de savoir sur quoi on va peindre
  
  ;Debug "dessin sur "+Str(OutputID)
  
  CheckAlpha() ; alpha avec pression, random, etc...
  
  water = brush(#Action_Brush)\Water* 0.3; * size
  
  alpha = alpha *(1-brush(#Action_Brush)\Water/255)
  
  
  If Brush(Action)\Trait
    
    dist  = point_distance(xx,yy,StartX1,StartY1) ; to find the distance between two brush dots
    d.d   = point_direction(xx,yy,StartX1,StartY1); to find the direction between the two brush dots
    angle = GetAngle(xx,yy,StartX1,StartY1)
    ;d = (angle  * 180 / #PI) + 180
    sinD.d = Sin(d)               
    cosD.d = Cos(d)

    
    For u = 0 To dist-1
      Scx.d = Rnd(Brush(Action)\scatter)* Brush(Action)\size * 0.01
      Scy.d = Rnd(Brush(Action)\scatter)* Brush(Action)\size * 0.01

      x_result.d =  sinD * u + xx + scx
      y_result.d =  cosD * u + yy + scy
      
      ; CheckAlpha() ; alpha avec pression, random, etc...
      
      ;                                 If PaintOld > 0 
      ;                                   size = FinalSize + u * ratio
      ;                                   If size < 0
      ;                                     size = FinalSize
      ;                                   EndIf        
      ;                                 Else
      ;                                   size = FinalSize 
      ;                                   PaintOld = 1
      ;                                 EndIf
      
      
      
      
        
      If Brush(Action)\randRot > 0 Or Brush(Action)\RotateParAngle = 1
      
        If Brush(Action)\RotateParAngle = 1 
          RotImg = RotateImageEx2(ImageID(#BrushCopy),angle+Rnd(Brush(Action)\randRot)) ; test pour voir si je peux rotationné en fonction de l'angle
          ;RotImg2 = RotateImageEx2(ImageID(RotImg),) 
          ;FreeImage(RotImg)
          ;RotImg = RotImg2
          www = ImageWidth(RotImg) 
          hhh = ImageHeight(RotImg)
          ;If www < 20 Or hhh < 20
          
          StopDrawing()
          If StartDrawing(ImageOutput(RotImg))
            DrawingMode(#PB_2DDrawing_AlphaClip)
            Box(0,0,www,hhh,RGBA(Red(color),Green(color),Blue(color),255))
            StopDrawing()
          EndIf
          
          If OutputID = 0
            StartDrawing(SpriteOutput(Layer(LayerId)\Sprite))
          Else
            StartDrawing(ImageOutput(Layer(LayerId)\Image))
          EndIf
          
          checkok = 1
          ;EndIf
        Else
          RotImg = RotateImageEx2(ImageID(#BrushCopy),Rnd(Brush(Action)\randRot))  
        EndIf
        
        If Brush(Action)\Sizepressure And FinalSize >0 And Action <> #Action_Eraser
          www = ImageWidth(RotImg) * FinalSize
          hhh = ImageHeight(RotImg) * FinalSize
          ResizeImage(RotImg,www,hhh,1-Brush(Action)\Smooth)
          If  checkok =0
            If (www < 20 Or hhh < 20)
              StopDrawing()
              If StartDrawing(ImageOutput(RotImg))
                DrawingMode(#PB_2DDrawing_AlphaClip)
                Box(0,0,www,hhh,RGBA(Red(color),Green(color),Blue(color),255))
                StopDrawing()
              EndIf
              
              If OutputID = 0
                StartDrawing(SpriteOutput(Layer(LayerId)\Sprite))
              Else
                StartDrawing(ImageOutput(Layer(LayerId)\Image))
              EndIf

            EndIf
          EndIf
        EndIf
      
      
        IE_TypeDrawing() ; le drawingmode (alphablend, clip si alphalock, etc..
        
        x_result + Brush(Action)\centerX -ImageWidth(RotImg)/2 
        y_result + Brush(Action)\centerY -ImageHeight(RotImg)/2
        
        
        ; on draw
        alpha * (100-brush(#Action_Brush)\Water)*0.01
        DrawAlphaImage(ImageID(RotImg),x_result,y_result,alpha) 
        DrawSymetry(RotImg,x_result,y_result,alpha)
        
        ; AntialiasedCircle(x_result,y_result, Brush(Action)\size, Color,Brush(Action)\Softness)
        ; MyCircle(x_result,y_result, Brush(Action)\size, Color,Brush(Action)\Softness)
        
        If brush(action)\Water > 0 And action <> #Action_Eraser
          DrawingMode(#PB_2DDrawing_CustomFilter)
          CustomFilterCallback(@Filtre_MelangeAlpha2())            
          DrawAlphaImage(ImageID(RotImg),x_result,y_result,Water)
          DrawSymetry(RotImg,x_result,y_result,Water)
        EndIf
        
        
        FreeImage(RotImg)
      Else
        
        If Brush(Action)\Sizepressure And FinalSize > 0
          If Brush(Action)\RotateParAngle = 1
            RotImg = RotateImageEx2(ImageID(#BrushCopy),angle) ; test pour voir si je peux rotationné en fonction de l'angle
          Else
            RotImg= CopyImage(#BrushCopy,#PB_Any)
          EndIf                                    
          ResizeImage(RotImg,ImageWidth(RotImg)*FinalSize, ImageHeight(RotImg)*FinalSize,1 - Brush(Action)\Smooth)
          x_result + Brush(Action)\centerX -ImageWidth(RotImg)/2 
          y_result + Brush(Action)\centerY -ImageHeight(RotImg)/2
          
          IE_TypeDrawing() ; le drawingmode (alphablend, clip si alphalock, etc..
          alpha * (100-brush(#Action_Brush)\Water)*0.01
          DrawAlphaImage(ImageID(RotImg),x_result,y_result,alpha)          
          DrawSymetry(RotImg,x_result,y_result,alpha)
          
          If brush(action)\Water > 0 And action <> #Action_Eraser
            DrawingMode(#PB_2DDrawing_CustomFilter)
            CustomFilterCallback(@Filtre_MelangeAlpha2())            
            DrawAlphaImage(ImageID(RotImg),x_result,y_result,Water)
            DrawSymetry(RotImg,x_result,y_result,Water)
          EndIf
          
          FreeImage(RotImg)
        Else
          IE_TypeDrawing() ; le drawingmode (alphablend, clip si alphalock, etc..
          alpha * (100-brush(#Action_Brush)\Water)*0.01
          DrawAlphaImage(ImageID(#BrushCopy),x_result,y_result,alpha)
          DrawSymetry(#BrushCopy,x_result,y_result,alpha)
          If brush(action)\Water > 0 And action <> #Action_Eraser
            DrawingMode(#PB_2DDrawing_CustomFilter)
            CustomFilterCallback(@Filtre_MelangeAlpha2())            
            DrawAlphaImage(ImageID(#BrushCopy),x_result,y_result,Water)
            DrawSymetry(#BrushCopy,x_result,y_result,Water)
          EndIf
        EndIf
        
      EndIf
      
      v+1
      u + b
      
    Next u
    
    If OutputID
      StartX1 = XX
      StartY1 = YY
    EndIf
    brushsiz_old = brushsiz
    
  Else
    
    Scx.d = Rnd(Brush(Action)\scatter)* Brush(Action)\size * 0.01
    Scy.d = Rnd(Brush(Action)\scatter)* Brush(Action)\size * 0.01
    
    IE_TypeDrawing() ; le drawingmode (alphablend, clip si alphalock, etc..

    If Brush(Action)\rotate > 0
      RotImg = RotateImageEx2(ImageID(#BrushCopy),Random(Brush(Action)\rotate))                      
      xx + Brush(Action)\centerX -ImageWidth(RotImg)/2 + scx
      yy + Brush(Action)\centerY -ImageHeight(RotImg)/2 + scy
      alpha * (100-brush(#Action_Brush)\Water)*0.01
      DrawAlphaImage(ImageID(RotImg),xx,yy,Brush(Action)\alpha)
      DrawSymetry(RotImg,x_result,y_result,alpha)

      If brush(action)\Water > 0 And action <> #Action_Eraser
        DrawingMode(#PB_2DDrawing_CustomFilter)
        CustomFilterCallback(@Filtre_MelangeAlpha2())            
        DrawAlphaImage(ImageID(RotImg),x_result,y_result,water)
        DrawSymetry(RotImg,x_result,y_result,Water)
      EndIf
      
      FreeImage(RotImg)
    Else 
      alpha * (100-brush(#Action_Brush)\Water)*0.01
      DrawAlphaImage(ImageID(#BrushCopy),xx+scx,yy+scy,Brush(Action)\alpha)
      DrawSymetry(#BrushCopy,x_result,y_result,alpha)
      
      If brush(action)\Water > 0 And action <> #Action_Eraser
        DrawingMode(#PB_2DDrawing_CustomFilter)
        CustomFilterCallback(@Filtre_MelangeAlpha2())            
        DrawAlphaImage(ImageID(#BrushCopy),x_result,y_result,Water)
        DrawSymetry(#BrushCopy,x_result,y_result,Water)
      EndIf
    EndIf  
    
  EndIf
  
  StopDrawing()                      
  
EndMacro

Procedure DoPaintForImageLayer(xx,yy,StartX1,StartY1,size)
  
  ; je garde, mais je ne m'en sers plus
  
  If Brush(Action)\Trait
    dist  = point_distance(xx,yy,StartX1,StartY1) ; to find the distance between two brush dots
    d.d   = point_direction(xx,yy,StartX1,StartY1); to find the direction between the two brush dots
    sinD.d = Sin(d)                
    cosD.d = Cos(d)
    
    ;{ utile ? Déjà calculé plus haut
    ; pour la pression tablet, à finir
    ; b = (size/2+1) * Brush(Action)\Pas*0.01
    ;                         b = Brush(Action)\size * Brush(Action)\Pas*0.01
    ;                         brushsiz.d = Brush(Action)\size * size/20 +1
    ;                         If brushsiz_old.d <= 0
    ;                           brushsiz_old = brushsiz
    ;                         EndIf
    ;                         
    ;FinalSize = (brushsiz_old+newsiz*v)/2             
    ;}
    
    For u = 0 To dist-1
      
      Scx.d = Rnd(Brush(Action)\scatter)* Brush(Action)\size * 0.01
      Scy.d = Rnd(Brush(Action)\scatter)* Brush(Action)\size * 0.01
      
      x_result =  sinD * u + xx + scx
      y_result =  cosD * u + yy + scy
      CheckAlpha()
      
      ;{ on dessine les points
      If Brush(Action)\Sizepressure And finalsize >0
        
        If Brush(Action)\randRot > 0
          
          RotImg = RotateImageEx2(ImageID(#BrushCopy),Random(Brush(Action)\randRot))  
          ;If Brush(Action)\Sizepressure And FinalSize >0
          ResizeImage(RotImg,ImageWidth(RotImg)*FinalSize, ImageHeight(RotImg)*FinalSize,1 - Brush(Action)\Smooth)
          ;EndIf
          x_result + Brush(Action)\centerX -ImageWidth(RotImg)/2 
          y_result + Brush(Action)\centerY -ImageHeight(RotImg)/2
          DrawAlphaImage(ImageID(RotImg),x_result,y_result,alpha)
          DrawSymetry(RotImg,x_result,y_result,alpha)
          FreeImage(RotImg)
        Else
          ;If Brush(Action)\Sizepressure And FinalSize > 0
          RotImg= CopyImage(#BrushCopy,#PB_Any)
          ResizeImage(RotImg,ImageWidth(#BrushCopy)*FinalSize, ImageHeight(#BrushCopy)*FinalSize,1 - Brush(Action)\Smooth)
          x_result + Brush(Action)\centerX -ImageWidth(RotImg)/2 
          y_result + Brush(Action)\centerY -ImageHeight(RotImg)/2
          
          DrawAlphaImage(ImageID(RotImg),x_result,y_result,alpha)
          DrawSymetry(RotImg,x_result,y_result,alpha)
          FreeImage(RotImg)
          ;Else
          ;DrawAlphaImage(ImageID(#BrushCopy),x_result,y_result,alpha)
          ;EndIf
          
        EndIf
        
      Else
        
        If Brush(Action)\randRot > 0
          
          RotImg = RotateImageEx2(ImageID(#BrushCopy),Random(Brush(Action)\randRot))                      
          
          x_result + Brush(Action)\centerX -ImageWidth(RotImg)/2
          y_result + Brush(Action)\centerY -ImageHeight(RotImg)/2
          
          DrawAlphaImage(ImageID(RotImg),x_result,y_result,alpha)
          DrawSymetry(RotImg,x_result,y_result,alpha)
          FreeImage(RotImg)
        Else
          DrawAlphaImage(ImageID(#BrushCopy),x_result,y_result,alpha)
          DrawSymetry(#BrushCopy,x_result,y_result,alpha)
        EndIf
        
      EndIf
      
      
      ;}
      
      
      v+1
      u + b
    Next u
    
    StartX1 = xx
    StartY1 = yy
    brushsiz_old = brushsiz
    
  Else
    
    Scx.d = Rnd(Brush(Action)\scatter)* Brush(Action)\size * 0.01
    Scy.d = Rnd(Brush(Action)\scatter)* Brush(Action)\size * 0.01
    
    CheckAlpha()
    
    If Brush(Action)\randRot > 0
      RotImg = RotateImageEx2(ImageID(#BrushCopy),Random(Brush(Action)\randRot)) 
      xx + Brush(Action)\centerX -ImageWidth(RotImg)/2 + Scx
      yy + Brush(Action)\centerY -ImageHeight(RotImg)/2 + Scy
      DrawAlphaImage(ImageID(RotImg),xx,yx,alpha)
      FreeImage(RotImg)
    Else
      DrawAlphaImage(ImageID(#BrushCopy),xx+scx,yy+scy,alpha)
    EndIf  
    
  EndIf
                      
EndProcedure





; Gersam :)
Procedure.f Distance(*a.Vector2f, *b.Vector2f)
  ProcedureReturn Sqr( ((*a\x-*b\x)*(*a\x-*b\x)) + ((*a\y-*b\y)*(*a\y-*b\y)))
EndProcedure
Procedure GersamDraw(x,y,oldx,oldy,size,color,alpha=255)

  Shared PaintPos.Vector2f 
  Define OldPaintPos.Vector2f

  
  PaintPos\x = x
  PaintPos\y = y
  OldPaintPos\x = oldx
  OldPaintPos\y = Oldy
  
  w = size
  
    If Brush(Action)\pas * Size *0.1 > 0
      interval.f = Brush(Action)\pas * Size * 0.1
    Else
      interval = 1
    EndIf
    dist.f     = Distance(@PaintPos, @OldPaintPos)
    
    If(dist > interval)
      number.i = dist / interval
            
      ;If number = 1 ; slow speed
;         If dist > 
;           If StartDrawing(CanvasOutput(0))
;             DrawingMode(#PB_2DDrawing_AlphaBlend)
;             Circle(PaintPos\x,PaintPos\y,R,RGBA(0,0,0,100))   
;             StopDrawing()
;           EndIf
;         EndIf
      ;Else
        
        Direction.Vector2f
        Direction\x = OldPaintPos\x - PaintPos\x
        Direction\y = OldPaintPos\y - PaintPos\y
        
        lenght.f =  Sqr(Direction\x * Direction\x + Direction\y * Direction\y)
        
        If lenght > 0
          Direction\x / lenght
          Direction\y / lenght
        EndIf
        
        col = RGBA(Red(color),Green(color),Blue(color),alpha)
        ColF = RGBA(Red(color),Green(color),Blue(color),0)
        
        If StartDrawing(SpriteOutput(Layer(layerid)\Sprite))
          IE_TypeDrawing() 
          If Brush(Action)\type = #ToolType_Brush
            DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
          EndIf
          
          For i = 0 To number-1
            
            px.d = PaintPos\x + (Direction\x*(interval*i)) 
            py.d = PaintPos\y + (Direction\y*(interval*i))
            FrontColor(colF) : BackColor(col)
            CircularGradient(px, py, w - 1)
            Circle(px,py,size,col) 
            
          Next
          StopDrawing()
        EndIf
        ;EndIf
        
       If StartDrawing(ImageOutput(Layer(layerid)\Image))
         IE_TypeDrawing() 
         ;DrawingMode(#PB_2DDrawing_AlphaBlend)
         If Brush(Action)\type = #ToolType_Brush
           DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
         EndIf
          For i = 0 To number-1
            
            px.d = PaintPos\x + (Direction\x*(interval*i))
            py.d = PaintPos\y + (Direction\y*(interval*i))  
            FrontColor(ColF) : BackColor(col)
            CircularGradient(px,py, w - 1)
            Circle(px,py,size,col) 
            
          Next
          StopDrawing()
       EndIf
      
      OldPaintPos\x = PaintPos\x
      OldPaintPos\y = PaintPos\y 
    EndIf
    
  ; EndIf
  
  
EndProcedure







; color, blending
Procedure.l ColorBlending(Couleur1.l, Couleur2.l, Echelle.f) ; Mélanger 2 couleurs
  ; by Le soldat inconnu, thanks !
  
  Protected Rouge, Vert, Bleu, Rouge2, Vert2, Bleu2
  
  Rouge = Couleur1 & $FF
  Vert = Couleur1 >> 8 & $FF
  Bleu = Couleur1 >> 16
  Rouge2 = Couleur2 & $FF
  Vert2 = Couleur2 >> 8 & $FF
  Bleu2 = Couleur2 >> 16
  
  Rouge = Rouge * Echelle + Rouge2 * (1-Echelle)
  Vert = Vert * Echelle + Vert2 * (1-Echelle)
  Bleu = Bleu * Echelle + Bleu2 * (1-Echelle)
  
  ProcedureReturn (Rouge | Vert <<8 | Bleu << 16)
EndProcedure
Procedure GetColor(x,y)
  
  ;If x>0 And x<ScreenHeight()-1 And y>0 And y<ScreenHeight()-1
  Brush(Action)\Color = Point(x,y)
  Brush(Action)\ColorBG\R = Red(Brush(Action)\Color)
  Brush(Action)\ColorBG\G = Green(Brush(Action)\Color)
  Brush(Action)\ColorBG\B = Blue(Brush(Action)\Color)
  Brush(Action)\Col\R = Red(Brush(Action)\Color)
  Brush(Action)\Col\G = Green(Brush(Action)\Color)
  Brush(Action)\Col\B = Blue(Brush(Action)\Color)
  ;EndIf
  
EndProcedure






; les shapes : box, ellipse, shpae, line...
Macro DrawShape(sprite=1)
  
  If sprite = 1
    ; DrawingMode(#PB_2DDrawing_CustomFilter)
    DrawingMode(#PB_2DDrawing_AllChannels)
    ; CustomFilterCallback(@Filtre_MelangeAlpha2())  
    Box(0,0,doc\w,doc\h,RGBA(0,0,0,255))
    Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
    z.d = OptionsIE\Zoom*0.01
  Else
    z = 1
  EndIf
  
   DrawingMode(#PB_2DDrawing_AlphaBlend) 
  ; FrontColor(col)
  ; BackColor(Brush(Action)\ColorFG)
  
  Select Action
    Case #Action_Box
      RoundBox(x,y,w,h,brush(action)\size,brush(action)\size,col)
      If Brush(action)\ShapeOutSize >=1
        DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
        col = RGBA(Red(brush(action)\ColorFG),Green(brush(action)\ColorFG),Blue(brush(action)\ColorFG),brush(action)\AlphaFG)
        For i = 0 To  Brush(action)\ShapeOutSize
          RoundBox(x+i,y+i,w-i*2,h-i*2,brush(action)\Size,brush(action)\Size,col)
        Next
      EndIf
      
    Case #Action_Line
      Select OptionsIE\ShapeTyp
        Case 2 ; simple line 
          w1 = (1-OptionsIE\ShapeParam) * Random(layer(layerid)\w)
          h1 = OptionsIE\ShapeParam * Random(layer(layerid)\h)
          w2= (1-OptionsIE\ShapeParam) * w
          h2= OptionsIE\ShapeParam * h
          ;NormalL_OLd(x+w1,y+h1,w2+x+w1,h2+y+h1,col,brush(action)\Alpha, brush(action)\Size*z)  
          LineAA(x+w1,y+h1,w2+w1,h2+h1,col, brush(action)\Size*z)
          
        Case 1 ; radial       
          ; LineXY(x,y,w+x,h+y,col)
          ; NormalL_OLd(x,y,w+x,h+y,col,brush(action)\Alpha, brush(action)\Size*z)  
          LineAA(x,y,w,h,col,brush(action)\Size*z)

        Case 0 ; thickness line
          ;NormalL_OLd(x,y,w+x,h+y,col,brush(action)\Alpha, brush(action)\Size*z)  
          LineAA(x,y,w,h,col, brush(action)\Size*z)

      EndSelect
      
    Case #Action_Circle  
      Ellipse(x,y,w,h,col)
      If Brush(action)\ShapeOutSize >=1
        DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
        col = RGBA(Red(brush(action)\ColorFG),Green(brush(action)\ColorFG),Blue(brush(action)\ColorFG),brush(action)\AlphaFG)
        For i = 0 To  Brush(action)\ShapeOutSize
          Ellipse(x,y,w+i,h+i,col)
        Next i      
      EndIf
                      

      ; EllipseAA(x,y,w,h,col,brush(action)\Size*z,mode)
      
    Case #Action_Gradient
      DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)      
      BackColor(col)
      FrontColor(RGBA(Red(Brush(Action)\ColorFG),Green(Brush(Action)\ColorFG),Blue(Brush(Action)\ColorFG),Brush(Action)\AlphaFG))
      If OptionsIE\ShapeTyp = 0
        LinearGradient(x, y, w-x, h-y)
      ElseIf OptionsIE\ShapeTyp = 1
        CircularGradient(x, y, w)
      ElseIf OptionsIE\ShapeTyp = 2
        EllipticalGradient(x, y, w, h)
      ElseIf OptionsIE\ShapeTyp = 3
        angle = GetAngle(w-x,h-y,x,y)
        ConicalGradient(x,y,angle)
      ElseIf OptionsIE\ShapeTyp = 3
        BoxedGradient(x,y,w,h)
      EndIf
      
      Box(x,y,w,h)
  EndSelect
  
      
 EndMacro

Procedure CreateShape()
  
  z.d = OptionsIE\Zoom * 0.01
  
  OptionsIE\Shape = 0
  x = OptionsIE\ShapeX/z -canvasX/z
  y = OptionsIE\ShapeY/z -canvasY/z
  w = OptionsIE\shapeW/z
  h = OptionsIE\shapeH/z
  col = RGBA(Brush(Action)\ColorBG\R,Brush(Action)\ColorBG\G,Brush(Action)\ColorBG\B,Brush(Action)\alpha)
  
  If StartDrawing(ImageOutput(layer(layerid)\image))
    
    DrawShape(0)
    
    StopDrawing()
  EndIf
  
  NewPainting = 1
  ScreenUpdate(1)
      
EndProcedure




; text
Procedure OpenTxtEditor(x,y)
  
  txt$ = InputRequester("Txt", "tape tour text", "")
  
  If txt$ <> ""
    Layer_Add(x,y,txt$)
  EndIf
  
  
EndProcedure


; fillarea2 ; by comtois
Procedure FillArea3_(xx, yy, MinX, MinY, MaxX, MaxY, c=0, tolerance=10)
  
  ; By comtois 2005
  ; légère modification by blendman, to verify if we are in the area 2015
  
  ; Toutes les options de remplissage sont envisageables en modifiant légèrement ce code
  
  ; La version originale de ce code se trouve ici (ainsi que les explications)
  ; http://raphaello.univ-fcomte.fr/IG/Algorithme/Algorithmique.htm#remplissage
  
  ; Remarque : j'ai ajouté les paramètres Min et Max ,
  ; parce qu'une personne sur le forum anglais m'a demandé comment faire pour limiter la zone de remplissage.
  
    
  sp = Layer(layerId)\image
  
  w_1 = ImageWidth(sp)
  h_1 = ImageHeight(sp)
  
  If InSpriteArea(xx,yy,w_1,h_1)
    
    Psp = 1
    Dim Px(1000)
    Dim Py(1000)
    Px(0) = xx
    Py(0) = yy
    
    FrontColor(RGBA(Red(c),Green(c),Blue(c),brush(action)\alpha))
    
    
    lim = Point(xx, yy)
    
    If MinX < 0 : MinX = 0 : EndIf
    If MinY < 0 : MinY = 0 : EndIf
    If MaxX > w_1 : MaxX = w_1 : EndIf
    If MaxY > h_1 : MaxY = h_1 : EndIf
  
    While Psp <> 0
    xi = Px(Psp - 1)
    xf = Px(Psp - 1)
    x  = Px(Psp - 1)
    y  = Py(Psp - 1)
    
    x + 1
    If InSpriteArea(x,y,w_1,h_1)
      cp = Point(x, y)
    EndIf
    
    While (cp >= lim-tolerance And cp <=lim+tolerance ) And x < MaxX
      xf = x
      x + 1
      If InSpriteArea(x,y,w_1,h_1)
        cp = Point(x,y)
      EndIf            
    Wend
    
    x = Px(Psp - 1) - 1
    If InSpriteArea(x,y,w_1,h_1)
      cp = Point(x, y)
    EndIf
    While (cp >= lim-tolerance And cp <=lim+tolerance ) And x > MinX
      xi = x
      x - 1
      If InSpriteArea(x,y,w_1,h_1)
        cp = Point(x, y)
      EndIf            
    Wend
    
    LineXY(xi, y, xf, y)
    Psp - 1
    
    ; Y + 1
    x = xf
    While x >= xi And y < MaxY
      If InSpriteArea(x,y+1,w_1,h_1)
        cp = Point(x, y + 1)
      EndIf
      While (((cp <lim-tolerance And cp> lim+tolerance) Or (cp = c)) And (x >= xi))
        x - 1
        If InSpriteArea(x,y+1,w_1,h_1)          
          cp = Point(x, y + 1)
        EndIf
      Wend
      If ((x >= xi) And (cp >= lim-tolerance And cp <=lim+tolerance ) And (cp <> c))
        Px(Psp) = x
        Py(Psp) = y + 1
        Psp + 1
      EndIf
      If InSpriteArea(x,y+1,w_1,h_1)                
        cp = Point(x, y + 1)
      EndIf
      While ((cp >= lim-tolerance And cp <=lim+tolerance ) And ( x >= xi ))
        x - 1
        If InSpriteArea(x,y+1,w_1,h_1)                  
          cp = Point(x,y+1)
        EndIf
      Wend
    Wend
    
    ; Y - 1
    x = xf
    While x >= xi And y > MinY
      If InSpriteArea(x,y-1,w_1,h_1)
        cp = Point(x, y-1)
      EndIf
      While (((cp <lim-tolerance And cp> lim+tolerance) Or (cp = c)) And (x >= xi))
        x - 1
        If InSpriteArea(x,y-1,w_1,h_1)          
          cp = Point(x, y - 1)
        EndIf
      Wend
      If ((x >= xi) And (cp >= lim-tolerance And cp <=lim+tolerance ) And (cp <> c))
        Px(Psp) = x
        Py(Psp) = y - 1
        Psp + 1
      EndIf
      If InSpriteArea(x,y-1,w_1,h_1)
        cp = Point(x, y-1)
      EndIf
      While ((cp >= lim-tolerance And cp <=lim+tolerance ) And ( x >= xi ))
        x - 1
        If InSpriteArea(x,y-1,w_1,h_1)
          cp = Point(x,y-1)
        EndIf
      Wend
    Wend
  Wend
  
  EndIf
  
EndProcedure
Procedure GetColFill(x,y)
  p=Point(x, y)
  cp=RGB(Red(p),Green(p),Blue(c))
  ProcedureReturn cp
EndProcedure
Procedure FillArea2(xx, yy, MinX, MinY, MaxX, MaxY, c=0, tolerance=0)
  
  ; By comtois 2005
  ; légère modification by blendman, to verify if we are in the area (2015)
  
  ; Toutes les options de remplissage sont envisageables en modifiant légèrement ce code
  
  ; La version originale de ce code se trouve ici (ainsi que les explications)
  ; http://raphaello.univ-fcomte.fr/IG/Algorithme/Algorithmique.htm#remplissage
  
  ; Remarque : j'ai ajouté les paramètres Min et Max ,
  ; parce qu'une personne sur le forum anglais m'a demandé comment faire pour limiter la zone de remplissage.
  
  ; c = color
  ; tolerance = pixel plus ou moins proche (luminence ou hue ?)
    
  sp = Layer(layerId)\image
  
  w_1 = ImageWidth(sp)
  h_1 = ImageHeight(sp)
  
  Tolerance=0
  
  If InSpriteArea(xx,yy,w_1,h_1)
    
    Psp = 1
    Dim Px(w_1)
    Dim Py(h_1)
    Px(0) = xx
    Py(0) = yy
    
    FrontColor(RGBA(Red(c),Green(c),Blue(c),brush(action)\alpha))
    
    lim=Point(xx,yy)
    ;lim = RGB(Red(li),Green(li),Blue(li))
    ;c= RGB(Red(c),Green(c),Blue(c))
    
    If lim <> c
      
      If MinX < 0 : MinX = 0 : EndIf
      If MinY < 0 : MinY = 0 : EndIf
      If MaxX > w_1 : MaxX = w_1 : EndIf
      If MaxY > h_1 : MaxY = h_1 : EndIf
    
      While Psp <> 0
        
        xi = Px(Psp - 1)
        xf = Px(Psp - 1)
        x  = Px(Psp - 1)
        y  = Py(Psp - 1)
        
        x + 1
        If InSpriteArea(x,y,w_1,h_1)
          ;cp=GetColFill(x,y)
          cp=Point(x,y)
        EndIf
        
        ;While (cp=lim) And x < MaxX
        While (cp>=lim-tolerance And cp<=lim+tolerance) And x>MinX
          xf = x
          x + 1
          If InSpriteArea(x,y,w_1,h_1)
            cp = Point(x,y)
          EndIf            
        Wend
        
        x = Px(Psp - 1) - 1
        If InSpriteArea(x,y,w_1,h_1)
          cp = Point(x, y)
        EndIf
        ;While (cp=lim) And x > MinX
        While (cp>=lim-tolerance And cp<=lim+tolerance) And x>MinX
          xi = x
          x - 1
          If InSpriteArea(x,y,w_1,h_1)
            cp = Point(x, y)
          EndIf            
        Wend
        
        LineXY(xi, y, xf, y)
        Psp - 1
        x = xf
        While x>=xi And y<MaxY
          If InSpriteArea(x,y+1,w_1,h_1)
            cp = Point(x, y + 1)
          EndIf
          ;While ((cp<>lim) Or (cp=c)) And (x>=xi)
          While ((cp<lim-tolerance Or cp>lim+tolerance) Or (cp=c)) And (x>=xi)
            x - 1
            If InSpriteArea(x,y+1,w_1,h_1)          
              cp = Point(x, y + 1)
            EndIf
          Wend
          If ((x>=xi) And (cp>=lim-tolerance And cp<=lim+tolerance) And (cp<>c))
          ;If ((x >= xi) And (cp=lim) And (cp<>c))
            If Psp < ArraySize(px())
              Px(Psp) = x
              Py(Psp) = y + 1
              Psp + 1
            Else 
              psp = 0
            EndIf 
          EndIf
          If InSpriteArea(x,y+1,w_1,h_1)                
            cp = Point(x, y + 1)
          EndIf
          ;While ((cp=lim) And (x>=xi))
          While (cp>=lim-tolerance And cp<=lim+tolerance) And (x>=xi)
            x - 1
            If InSpriteArea(x,y+1,w_1,h_1)                  
              cp = Point(x,y+1)
            EndIf
          Wend
        Wend
        
        ; Y - 1
        x = xf
        While x >= xi And y > MinY
          If InSpriteArea(x,y-1,w_1,h_1)
            cp = Point(x, y-1)
          EndIf
          ;While (((cp <>lim) Or (cp = c)) And (x >= xi))
          While (((cp<lim-tolerance Or cp>lim+tolerance) Or (cp=c)) And (x>=xi))
            x - 1
            If InSpriteArea(x,y-1,w_1,h_1)          
              cp = Point(x, y - 1)
            EndIf
          Wend
          ;If ((x >= xi) And (cp=lim) And (cp <> c))
          If ((x>=xi) And (cp>=lim-tolerance And cp<=lim+tolerance) And (cp<>c))
            If Psp < ArraySize(px())
              Px(Psp) = x
              Py(Psp) = y - 1
              Psp + 1
            Else 
              psp = 0
            EndIf            
          EndIf
          If InSpriteArea(x,y-1,w_1,h_1)
            cp = Point(x, y-1)
          EndIf
          ;While ((cp=lim) And ( x >= xi ))
          While ((cp>=lim-tolerance And cp<=lim+tolerance) And (x>=xi))
            x - 1
            If InSpriteArea(x,y-1,w_1,h_1)
              cp = Point(x,y-1)
            EndIf
          Wend
        Wend
        
      Wend
  
    EndIf
    
  EndIf
  
  
EndProcedure




; stroke et dot
Procedure AddDot(x1,y1,size,col)
  
  i = ArraySize(stroke(StrokeId)\dot())
  
  With Stroke(StrokeId)
    
    If i >0      
      xx = x1
      yy = y1   
      StartX = \dot(i)\x
      StartY = \dot(i)\y
      
      dist  = point_distance(xx,yy,StartX,StartY) ; to find the distance between two brush dots
      
      If dist > size
        ok = 1
      EndIf
      
    Else
      ok = 1
    EndIf
    
    If ok
      i+1
      ReDim \dot(i)
      \dot(i)\size = size
      \dot(i)\Colo = col
      \dot(i)\x = x1
      \dot(i)\y = y1
      
      ; If StartDrawing(CanvasOutput(#canvas))
        
        ; the point for the distance and direction
        xx = \dot(i)\x
        yy = \dot(i)\y
        
        If i > 0
          StartX = \dot(i-1)\x
          StartY = \dot(i-1)\y
        Else
          StartX = xx
          StartY = yy
        EndIf
        
        dist  = point_distance(xx,yy,StartX,StartY) ; to find the distance between two brush dots
        d.d   = point_direction(xx,yy,StartX,StartY); to find the direction between the two brush dots
        sinD.d = Sin(d)                
        cosD.d = Cos(d)
        
        ; the ratio for the sie
        If i > 1
          ratio.d = \dot(i-1)\size - \dot(i)\size
          ratio/dist
          
          For u = 0 To dist-1
            
            b.d = 1 ; dot(i)\size * 0.1               
            
            x =  sinD * u + xx 
            y =  cosD * u + yy 
            
            If i > 0 
              size = \dot(i)\size + u * ratio
              If size < 2
                size = 2
              EndIf        
            Else
              size = \dot(i)\size 
            EndIf
            
            
            ; ici, je dois calculer la rotation, le scatter, le random alpha, size, etc...
            
            
            
           ; Circle(x,y,size/2,0)
            u + b
            
          Next u
          
        ; Else
        ; Circle(xx,yy,size,0)
          
        EndIf
      
      
     ; StopDrawing()
   ; EndIf
    
    EndIf
  
EndWith

  
  
  
  
EndProcedure

Procedure CreateDot(mx,my,pression,col,clear=0)
  
  
  ; ici, je vais ajouter tous les paramètres de chaque point.
  ; je les précalcule, comme ça, je pourrais ensuite les dessiner et utiliser un lissage (courbe de bézier).
  
  ; stroke() : c'est le tableau des trait, 
  ; le trait courant = strokeId. Si on undo, on fait strokeid -1 en vérifiant que resultat est >0, car le 0 je ne m'en sers pas.
  ; si redo on fait strokeID+1, en verifiant qu'on ne dépasse pas le Undomax (32 ?).
  
  nb = ArraySize(stroke(strokeId)\Dot())+1
  ReDim stroke(strokeId)\Dot(nb)
  
  ;     If clear = 1
  ;       CopySprite(#Sp_BrushCopy,#sp_max+nb,#PB_Sprite_AlphaBlending)
  ;       stroke(strokeId)\Dot(nb)\sprite = #sp_max+nb
  ;     EndIf
    
    With stroke(strokeId)\Dot(nb)
      \rot = Random(Brush(Action)\RandRot) + Brush(Action)\Rotate
      If Brush(Action)\SizeRand > 0
        rndsiz = Rnd(Brush(Action)\SizeRand)
      Else
        rndsiz = 100
      EndIf
      If Brush(Action)\AlphaRand > 0
        rndalpha = Rnd(Brush(Action)\AlphaRand)
      Else
        rndalpha = 100
      EndIf
      \size = ((Brush(Action)\Sizepressure)*(Brush(Action)\Size * pression/8.74) +(1-Brush(Action)\Sizepressure) * Brush(Action)\Size) * (rndsiz * 0.01)
      \Alpha = ((Brush(Action)\AlphaPressure)*(Brush(Action)\Alpha * pression/8.74) +(1-Brush(Action)\Alphapressure) * Brush(Action)\Alpha) * (rndalpha * 0.01)
      \Colo = col
      \sizeW = Brush(Action)\SizeW
      \sizeH = Brush(Action)\sizeH
      \x = mx-Brush(Action)\CenterX
      \y = My-Brush(Action)\CenterY
      \w = SpriteWidth(#Sp_BrushCopy)
      \h = SpriteHeight(#Sp_BrushCopy)
    EndWith
    
;     If clear = 1
;       RotateSprite(stroke(strokeId)\Dot(nb)\sprite, stroke(strokeId)\Dot(nb)\rot,1)
;     EndIf
  
EndProcedure



; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 1675
; FirstLine = 89
; Folding = AAAAAAAAAAAAN5AAAAAAAgHAAA9----cAA+
; EnableUnicode
; EnableXP