

; distance, direction..
Macro point_distance(x1,y1,x2,y2)   
  Int(Sqr((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1)) )       
EndMacro

Macro point_direction(x1,y1,x2,y2)
  ATan2((y2- y1),(x2- x1))
EndMacro

Procedure.f GetAngle(xb,yb,Xa,Ya)

     
   ;calcul de l'angle en radian
   
   ar.f=ATan((Ya-yb)/(Xa-xb))
   
   ;conversion en degres (je suis pas un crac des radians, je préfère bosser avec les degrés)
   ad=ar*360/2/3.1415

   
   ;ajout de la partie de l'angle suivant la position des points car Atang ne renvoie qu'un angle de -90 à 90
   If Xa<xb And Ya<yb : ad=180+ad :EndIf ; cas haut gauche
   If Xa>xb And Ya<yb : ad=360+ad :EndIf ;cas haut droite
   If Xa<xb And Ya>yb : ad=180+ad :EndIf ; cas bas gauche
   If Xa>xb And Ya>yb :           :EndIf ; cas bas droite

   ; reconversion en radian si tu en as besoins
   ;ar=ad*2*3.1415/360
   
  ProcedureReturn ad+ar
EndProcedure


; mouse in area
Procedure.a MouseInArea(mx,my,x,y,w,h)
  
  If mx>=x And mx<x+w And my>=y And my<=y+h
    ProcedureReturn 1
  EndIf
  
  ProcedureReturn 0
EndProcedure
Procedure InSpriteArea(x,y,w,h)  
  If x>=0 And y>=0 And x<=w-1 And y<=h-1
    ProcedureReturn 1
  EndIf
  ProcedureReturn 0
EndProcedure

; snap
Procedure Snap(x,grid=10)
  x = Round(X/grid,#PB_Round_Nearest)*grid
  ProcedureReturn x
EndProcedure

;{ util, math
Procedure Max(a,b)
  If a > b
    a = b
  EndIf
  ProcedureReturn a
EndProcedure
Procedure min(a,b)
  
  If a>b
    ProcedureReturn b
  EndIf
  ProcedureReturn a
  
EndProcedure


Procedure.f Max3(Value1.f=0, Value2.f=0, Value3.f=0)
  Protected MaxValue.f = 0
  If Value1 > MaxValue : MaxValue = Value1 : EndIf
  If Value2 > MaxValue : MaxValue = Value2 : EndIf
  If Value3 > MaxValue : MaxValue = Value3 : EndIf
  ProcedureReturn MaxValue
EndProcedure
Procedure.f Min3(Value1.f=255, Value2.f=255, Value3.f=255)
  Protected MinValue.f = 255
  If Value1 < MinValue : MinValue = Value1 : EndIf
  If Value2 < MinValue : MinValue = Value2 : EndIf
  If Value3 < MinValue : MinValue = Value3 : EndIf
  ProcedureReturn MinValue
EndProcedure

Procedure.f MinF(n1.f, n2.f) 
  If n1<n2 
    ProcedureReturn n1 
  EndIf 
  ProcedureReturn n2 
EndProcedure 
Procedure.f MaxF(n1.f, n2.f) 
  If n1>n2 
    ProcedureReturn n1 
  EndIf 
  ProcedureReturn n2 
EndProcedure 



Macro Check(a,b)
  If a > b
    a = b
  EndIf  
EndMacro
Macro Check2(a,b)
  If a < b
    a = b
  EndIf  
EndMacro

Macro CheckIfSup(a,b)
  If a > b
    a = b
  EndIf  
EndMacro
Macro CheckIfInf(a,b)
  If a < b
    a = b
  EndIf  
EndMacro
Macro CheckIfInf2(a,b)
  If a < b
    b = a
  EndIf  
EndMacro
Macro Check0(a)
  CheckIfSup(a,255)
  CheckIfInf(a,0)
EndMacro



Procedure.f Rnd2(min.f,max.f)
  result.f = Random(min,max)-Random(min,max)
  ProcedureReturn result
EndProcedure
Procedure Rnd(a)
  ProcedureReturn Random(a) - Random(a)
EndProcedure
;}



Macro DeleteArrayElement(ar, el)
 
  For a=el To ArraySize(ar())-1
    ar(a) = ar(a+1)
  Next 
 
  ReDim ar(ArraySize(ar())-1)
 
EndMacro


; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 55
; Folding = 5VU4VA9
; EnableUnicode
; EnableXP