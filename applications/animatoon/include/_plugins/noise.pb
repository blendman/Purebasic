
; Animatoon - plugins example
; based on a code from G-ROm (french purebasic forum)
; july 2015
; by blendman
; pb 5.31


Structure MenuPlugin ; Action sur les icones du haut
  MenuId.i
  Name$
  *linkFunction.i
EndStructure 

Structure application
 
  winMain.i       ; identifiant de la fenêtre principale
  canvasID.i      ; id du canvas principal
  menuID.i        ; id du menu

  List MenuPlugin.MenuPlugin()
  *funcCreateToolBarButton.i 

  version_major.c ; version de l'application
  version_minor.c

  event.i         ; evenement de l'application
  
EndStructure

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


; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 6
; FirstLine = 9
; Folding = -
; EnableUnicode
; EnableXP