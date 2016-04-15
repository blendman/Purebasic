; PB 5.11 - 5.22 - 5.31
; 2013 - june 2015
; by blendman
; for Animatoon (my 2D painting and animation software)

Enumeration ; gadget
  #Gadget_image
  #Gadget_GradientX
  #Gadget_GradientX2
  #Gadget_GradientX3
  #Gadget_Radius 
EndEnumeration

Global gradientX.d=0.1, gradientX2.d=0.1, radius.w = 800,gradientX3.d = 0.5

Macro Update()
  If StartDrawing(ImageOutput(0))
    Box(0, 0, 400, 200, $FFFFFF)   
    DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)     
    ;BackColor(RGBA(0,0,0,255))     
    GradientColor(gradientX, 0)   
    GradientColor(gradientX3, RGBA(0,0,0,125))     
    GradientColor(gradientX2, RGBA(0,0,0,0))   
    ;FrontColor(RGBA(0,0,0,0))
    CircularGradient(100, 100, radius)     
    Box(0,0,200,200)   
    StopDrawing()
  EndIf
  Debug gradientX2
EndMacro

If OpenWindow(0, 0, 0, 400, 200, "Brush Example", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
 
  If CreateImage(0, 200, 200)
    Update()
    ImageGadget(#Gadget_image, 0, 0, 400, 200, ImageID(0))
  EndIf
  x = 30
  TrackBarGadget(#Gadget_GradientX,220,x,150,20,1,100)
  SetGadgetState(#Gadget_GradientX,gradientX *100)
 
  TrackBarGadget(#Gadget_GradientX2,220,x*2,150,20,1,100)
  SetGadgetState(#Gadget_GradientX2,gradientX2 *100)
 
  TrackBarGadget(#Gadget_GradientX3,220,x*3,150,20,1,100)
  SetGadgetState(#Gadget_GradientX3,gradientX3 *100)
 
  TrackBarGadget(#Gadget_Radius,220,x*4,150,20,1,1000)
  SetGadgetState(#Gadget_Radius,radius)
 
  Repeat
    Event = WaitWindowEvent()
       
    Select event
       
      Case #PB_Event_Gadget
       
        Select EventGadget()
           
          Case #Gadget_GradientX
            gradientX= GetGadgetState(#Gadget_GradientX)/100
            update()
            SetGadgetState(#Gadget_image,ImageID(0))
           
          Case #Gadget_GradientX2
            gradientX2 = GetGadgetState(#Gadget_GradientX2)/100
            update()
            SetGadgetState(#Gadget_image,ImageID(0))
           
          Case #Gadget_GradientX3
            gradientX3 = GetGadgetState(#Gadget_GradientX3)/100
            update()
            SetGadgetState(#Gadget_image,ImageID(0))
           
          Case #Gadget_Radius
            radius = GetGadgetState(#Gadget_Radius)
            update()
            SetGadgetState(#Gadget_image,ImageID(0))
           
        EndSelect
       
    EndSelect
       
  Until Event = #PB_Event_CloseWindow
EndIf

