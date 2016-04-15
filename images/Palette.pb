; open a palette *.gpl (gimp, mypaint, krita, animatoon)
; pb 5.22 / 5.31
; date : 25/06/2015
; by blendman
; For animatoon, my 2D painting and animation free software

#Win_Swatch = 0

Enumeration
 
  #G_WinSwatchScroll
  #G_WinSwatchCanvas
  #G_WinSwatchNbCol
  #G_WinSwatchName
  #G_WinSwatchNameSwatch
 
  #G_WinSwatchSave
  #G_WinSwatchNew
  #G_WinSwatchOpen
  #G_WinSwatchMerge
  #G_WinSwatchFromImg
 
  #G_WinSwatchAdd
  #G_WinSwatchDel
  #G_WinSwatchInsert
 
 
EndEnumeration

UsePNGImageDecoder()
UseJPEGImageDecoder()


;{ structures
Structure sColor
  R.a
  G.a
  B.a
EndStructure
Structure sSwatch
  col.sColor
  Color.i
  x.w
  y.w
  name$
EndStructure
Structure sPalette
  name$
  column.w
  Array swatch.sSwatch(0)
 
EndStructure


Global Dim SwatchColor.sPalette(0)
SwatchColor(0)\column = 7
SwatchColor(0)\name$ = "Palette test"

Global SwatchId = 0
;}


Procedure AddSwatchColor(r,g,b, name$="")
 
  n = ArraySize(SwatchColor(SwatchId)\swatch())
 
  With SwatchColor(SwatchId)\swatch(n)
   
    \Color = RGB(r,g,b)
    \col\R = r
    \col\G = g
    \col\B = b
    \name$ = name$
   
  EndWith
 
  ReDim SwatchColor(SwatchId)\swatch(n+1)
 
EndProcedure
Procedure SwatchUpdatePropCanvas(x1=0,y1=0,Selected=0)
 
  column = SwatchColor(swatchId)\column
  u = Round((GadgetWidth(#G_WinSwatchCanvas)-25) / column, #PB_Round_Down)
  n = ArraySize(SwatchColor(swatchid)\swatch()) -1
 
  y = (1+n/column) *u
  If n> 0
  ;If GadgetHeight(#G_WinSwatchCanvas) <> y Or
    ResizeGadget(#G_WinSwatchCanvas,#PB_Ignore,#PB_Ignore,#PB_Ignore,y+25)
    SetGadgetAttribute(#G_WinSwatchScroll,#PB_ScrollArea_InnerHeight,y+50)
  ;EndIf

  EndIf
 
 
  If StartDrawing(CanvasOutput(#G_WinSwatchCanvas))
    Box(0,0,GadgetWidth(#G_WinSwatchCanvas),GadgetHeight(#G_WinSwatchCanvas),RGB(150,150,150))
    For i = 0 To ArraySize(SwatchColor(swatchId)\swatch())-1
     
      With SwatchColor(swatchId)\swatch(i)
        x = (i%column) * u         
        y = (i/column) * u
        Box(x,y,u,u,RGB(\col\R,\col\G,\col\B))
       
      EndWith
     
    Next i
   
    If Selected = 1
      DrawingMode(#PB_2DDrawing_Outlined)
      Box(x1*u,y1*u,u,u,RGB(255,0,0))
      Box(x1*u+1,y1*u+1,u-2,u-2,RGB(0,0,0))
    EndIf
    StopDrawing()
   
  EndIf
 
EndProcedure
Procedure SwatchOpen(merge=0)
 
  If merge = 0
    ReDim SwatchColor(SwatchId)\swatch(0)
  EndIf
 
  file$ = OpenFileRequester("Open","","GPL (gimp, krita, mypaint, animatoon)|*.gpl",0)
  If file$ <> ""
    If ReadFile(0,file$)
     
      Editor$ = ReadString(0)     
      SwatchColor(swatchId)\name$ = RemoveString(ReadString(0),"Name: ") 
      line$ = ReadString(0)
      st$ = StringField(line$,2," ")
      SwatchColor(swatchId)\column = Val(st$)
     
      While Eof(0) = 0   
        line$ = ReadString(0)
        char$ = Mid(line$,1,1)
       
        If char$ <> "#" And line$ <> ""           
          line$ = ReplaceString(line$,Chr(9),Chr(32))
          While char$ = Chr(32)
            char$ = Mid(line$,1,1)
            line$ = Right(line$,Len(line$)-1)
          Wend           
          While FindString(line$,Chr(32)+Chr(32)) >= 1
            line$ = ReplaceString(line$,Chr(32)+Chr(32),Chr(32))
          Wend
          RGB$ = line$
          count = CountString(line$,Chr(32))
          R = Val(StringField(RGB$, 1, " "))
          G = Val(StringField(RGB$, 2, " "))
          B = Val(StringField(RGB$, 3, " "))
          name$ =""         
          For i = 0 To count
            Name$ + StringField(RGB$, 4+i, " ")           
          Next i
          Name$ = ReplaceString(Name$,Chr(9),"")
          ;Debug Str(r)+"/"+Str(g)+"/"+Str(b)
          AddSwatchColor(r,g,b,name$)
        EndIf           
       
      Wend
     
      CloseFile(0)
    EndIf   
  EndIf
  SetGadgetState(#G_WinSwatchNbCol,SwatchColor(swatchId)\column)
  SetGadgetText(#G_WinSwatchName,SwatchColor(swatchId)\name$)
 
  SwatchUpdatePropCanvas()
 
 
EndProcedure
Procedure SwatchSave(export=0)
 
  Shared SwatchSaved$
  ; for save a swatch.
  ; format supported : GPL (gimp palette, krita...)
 
  If export = 1 ; save only
   
    File$ = SaveFileRequester("Save Swatch","","GPL (Gimp, Krita, Inkscape, Animatoon)|*.gpl",0)
   
    If File$ <> ""
     
      ext$  = LCase(GetExtensionPart(File$))
      If ext$ <> "gpl"
        file$ = RemoveString(file$,ext$)
        file$ + ".gpl"
      EndIf
      SwatchSaved$ = file$
      export = 0
    EndIf
       
  EndIf
 
  If export =0
   
     ;ext$  = GetExtensionPart(SwatchSaved$)
   
     ;If ext$ = "gpl"
       
       If OpenFile(0,SwatchSaved$)
         
         With SwatchColor(swatchid)
           
           WriteStringN(0, "Animatoon Palette")
           WriteStringN(0, "Name:"+ \name$)
           WriteStringN(0, "Columns: "+ Str(\column))
           WriteStringN(0, "# ")
           
           For i = 0 To ArraySize(SwatchColor(swatchid)\swatch())-1
             
             R$ = Str(\Swatch(i)\col\R)
             G$ = Str(\swatch(i)\col\G)
             B$ = Str(\swatch(i)\col\B)           
             WriteStringN(0, R$+" "+G$+" "+B$+"   "+\swatch(i)\name$)
             
           Next i
           
         EndWith
         
         CloseFile(0)
         
       EndIf
       
     ;EndIf
   
  EndIf
 
EndProcedure
Procedure SwatchCreateFromImage()
  File$ = OpenFileRequester("Open Image","","IMAGE|*.jpg;*.png;*.bmp",0)
  If file$ <> ""
    w = Val(InputRequester("Max colors", "Set the maximum number of colors (for the palette)",""))
    If w > 0
      If LoadImage(0,file$)
        ReDim SwatchColor(swatchId)\Swatch(0)
        width = Round(Sqr(w),#PB_Round_Down)
        Debug Sqr(w)
        ResizeImage(0,width,width,1)
        If StartDrawing(ImageOutput(0))
          For i= 0 To width-1
            For j = 0 To width-1
              color = Point(i,j)
              name$ = "color"+Str(a)
              ok = 1
              For aa = 0 To ArraySize(SwatchColor(swatchId)\Swatch())
                If color = SwatchColor(swatchId)\Swatch(aa)\Color
                  ok = 0
                  Break
                EndIf
              Next aa
              If ok = 1
                AddSwatchColor(Red(color),Green(color),Blue(color),Name$)
                a+1
              EndIf                         
            Next j
          Next i
          StopDrawing()
        EndIf
        SwatchUpdatePropCanvas()
      EndIf                 
    EndIf
  EndIf
EndProcedure

  If OpenWindow(#Win_Swatch,0,0,550,460,"Palette creation (Gimp, Mypaint, Krita, Animatoon...)",
                #PB_Window_SystemMenu|#PB_Window_SizeGadget|#PB_Window_ScreenCentered)
   
    SetWindowColor(0,RGB(120,120,120))
    i = 5
    column = SwatchColor(swatchId)\column
    ; butons
    w1 = 80 ; size
    xb = WindowWidth(#Win_Swatch) - w1 - 10 ; x 

    If StringGadget(#G_WinSwatchName,10,i,150,20,SwatchColor(swatchId)\name$)    : EndIf
    GadgetToolTip(#G_WinSwatchName, "Swatch global name")
    If SpinGadget(#G_WinSwatchNbCol,170,i,40,20,1,64,#PB_Spin_Numeric)           : EndIf
    SetGadgetState(#G_WinSwatchNbCol,column)
    i +25
    GadgetToolTip(#G_WinSwatchNbCol, "Number of Columns for the swatch")
   
    If ScrollAreaGadget(#G_WinSwatchScroll, 10,i,xb-20,400,xb-20-25,400)
      SetGadgetColor(#G_WinSwatchScroll,#PB_Gadget_BackColor,RGB(150,150,150))
      If CanvasGadget(#G_WinSwatchCanvas,0,0,xb-20,400) : EndIf
      i + 405
      CloseGadgetList()
    EndIf
   
    If StringGadget(#G_WinSwatchNameSwatch,10,i,150,20,"Swatch name")            : EndIf
   
    i = 5
    If ButtonGadget(#G_WinSwatchNew,xb,i,w1,20,"New")     : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchOpen,xb,i,w1,20,"Open")   : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchMerge,xb,i,w1,20,"Merge")   : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchFromImg,xb,i,w1,20,"From Image")   : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchSave,xb,i,w1,20,"Save")  : i + 35  : EndIf
    If ButtonGadget(#G_WinSwatchInsert,xb,i,w1,20,"Insert")  : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchAdd,xb,i,w1,20,"Add")  : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchDel,xb,i,w1,20,"Delete")  : i + 25  : EndIf
       
    SwatchUpdatePropCanvas()
       
    Repeat
     
      Event = WaitWindowEvent(1)
      EventType = EventType()
     
      Select event
         
        Case #PB_Event_Gadget
         
          Select EventGadget()
             
            Case #G_WinSwatchCanvas
              u = Round((GadgetWidth(#G_WinSwatchCanvas)-25) / SwatchColor(swatchId)\column , #PB_Round_Down)
              x = Round(GetGadgetAttribute(#G_WinSwatchCanvas, #PB_Canvas_MouseX)/u,#PB_Round_Down)
              y = Round(GetGadgetAttribute(#G_WinSwatchCanvas, #PB_Canvas_MouseY)/u,#PB_Round_Down)
              id = x +y* SwatchColor(swatchId)\column             
             
              If EventType = #PB_EventType_LeftButtonDown   
                If StartDrawing(CanvasOutput(#G_WinSwatchCanvas))
                  If id <= ArraySize(SwatchColor(swatchId)\swatch())-1                   
                    SetGadgetText(#G_WinSwatchNameSwatch,SwatchColor(swatchId)\swatch(id)\name$)
                  EndIf
                  StopDrawing()
                EndIf
                SwatchUpdatePropCanvas(x,y,1)
              ElseIf EventType = #PB_EventType_LeftDoubleClick
                Color = ColorRequester(SwatchColor(swatchId)\swatch(id)\Color)
                SwatchColor(swatchId)\swatch(id)\col\R = Red(color)
                SwatchColor(swatchId)\swatch(id)\col\G = Green(color)
                SwatchColor(swatchId)\swatch(id)\col\B = Blue(color)
                SwatchColor(swatchId)\swatch(id)\Color  = color
                SwatchUpdatePropCanvas(x,y,1)
              EndIf
             
            Case #G_WinSwatchNbCol
              SwatchColor(swatchId)\column  = GetGadgetState(#G_WinSwatchNbCol)             
              SwatchUpdatePropCanvas()
             
            Case #G_WinSwatchName
              SwatchColor(swatchId)\Name$ = GetGadgetText(#G_WinSwatchName)       
             
            Case #G_WinSwatchNameSwatch
              SwatchColor(swatchId)\Swatch(id)\name$ = GetGadgetText(#G_WinSwatchNameSwatch)     
             
            Case #G_WinSwatchMerge
              SwatchOpen(1)
             
            Case #G_WinSwatchNew
              ReDim SwatchColor(swatchId)\Swatch(0)
              SwatchUpdatePropCanvas()
             
            Case #G_WinSwatchFromImg
              SwatchCreateFromImage()
             
            Case #G_WinSwatchSave
              SwatchSave(1)
             
            Case #G_WinSwatchAdd
              color = ColorRequester()
              Name$ = InputRequester("Name","Name of the new swatch : ","Untitled")
              AddSwatchColor(Red(color),Green(color),Blue(color),Name$)
              SwatchUpdatePropCanvas()
             
            Case #G_WinSwatchOpen
              SwatchOpen(1)
             
            Case #G_WinSwatchMerge
              SwatchOpen()
                           
          EndSelect
         
      EndSelect
                 
    Until event = #PB_Event_CloseWindow
       
  EndIf
