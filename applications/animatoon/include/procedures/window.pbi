
; ANIMATOON 
; PB5.22 - 5.31
; by Blendman
; Date 06/2015 




;--- FILE
Macro WinDocNewCont(typ)
  
  If IsGadget(cont) And cont > #G_LastGadget
    FreeGadget(cont)
  EndIf
  
  Cont = ContainerGadget(#PB_Any,xx,yy,w1-GadgetWidth(canvas)-20,h1-50)
  SetGadgetColor(Cont,#PB_Gadget_BackColor,col2)
  u = xx
  xx = 10
  
  Select Typ
      
    Case 0 ; recent document
      
    Case 1 ; template 
      If cont
        
        nomtxt=TG(xx,yy,"Name",col2)        
        x1 = xx + GadgetWidth(nomtxt)
        w2 = w1-x1-u-20
        SGnom  = StringGadget(#PB_Any, x1,yy,w2+10,20,"Untitled")
        yy+25
        w2 = w1-u-10
        FrameGadget(#GADGET_WNewTile,xx,yy,w2-10,150,"Image size")
        SetGadgetColor(#GADGET_WNewTile,#PB_Gadget_BackColor,col2)
        yy + 20
        TGTemplate = TextGadget(#PB_Any,xx+5,yy,Len(lang("Templates")+":")*7,20,lang("Templates")+":")
        SetGadgetColor(TGTemplate,#PB_Gadget_BackColor,col2)
        xt = GadgetWidth(TGTemplate)+5
        CbTemplate = ComboBoxGadget(#PB_Any,xx+xt,yy,w2-xt-20,20) : yy + 40
        
       
        
        
        Directory$ = GetCurrentDirectory() + "data\Presets\Template\"  ; Liste tous les fichiers et les dossiers du répertoire racine de l'utilisateur qui est actuellement logué (Home)
        Dim template.sTemplate(0)
        If ExamineDirectory(0, Directory$, "*.txt")  
          While NextDirectoryEntry(0)
            If DirectoryEntryType(0) = #PB_DirectoryEntry_File
             
              template_nom$ = DirectoryEntryName(0)
              If ReadFile(0, Directory$+template_nom$)                
                While Eof(0) = 0       
                  info$ = ReadString(0) 
                  ReDim template.sTemplate(i)
                  
                  template(i)\nom$ = StringField(info$,1,"|")
                  template(i)\dpi = Val(StringField(info$,2,"|"))
                  template(i)\format$ = StringField(info$,3,"|")
                  template(i)\w = Val(StringField(info$,4,"|"))
                  template(i)\h = Val(StringField(info$,5,"|"))
                  
                  AddGadgetItem(CbTemplate,i, template(i)\nom$)
                  i+1
                Wend
                ReDim template.sTemplate(i-1)
                CloseFile(0) 
              EndIf
            EndIf
          Wend
          FinishDirectory(0)
        EndIf

        n=7
        Dim Format$(n)
        Format$(0) = "Millimeters (mm)"
        Format$(1) = "Centimeters (cm)"
        Format$(2) = "Decimeters (dm)"
        Format$(3) = "Inch (in)"
        Format$(4) = "Pica (pi)"
        Format$(5) = "Cicero (cc)"
        Format$(6) = "Points (pt)"
        Format$(7) = "Pixels (px)"
        
        TGWidth=TG(xx+5,yy,"Width",col2)
        SpinGadget(#GADGET_WNewW,xx+60,yy,50,20,1,10000,#PB_String_Numeric) : SetGadgetText(#GADGET_WNewW,Str(doc\w_def))
        CBPixelW = ComboBoxGadget(#PB_Any,xx+115,yy,80,20) 
       
        YY +25
        TGHeight=TG(xx+5,yy,"Height",col2)
        SpinGadget(#GADGET_WNewH,xx+60,yy,50,20,1,10000,#PB_String_Numeric) : SetGadgetText(#GADGET_WNewH,Str(doc\h_def)) 
        CBPixelH = ComboBoxGadget(#PB_Any,xx+115,yy,80,20) 
        
        For i = 0 To n
          AddGadgetItem(CBPixelH,i,Format$(i))
          AddGadgetItem(CBPixelW,i,Format$(i))
        Next i
        SetGadgetState(CBPixelH,n)
        SetGadgetState(CBPixelW,n)
        
        YY -12.5
        x1 = xx+5+GadgetWidth(TGHeight)+GadgetWidth(#GADGET_WNewH)+GadgetWidth(CBPixelH)+40
        TGReso = TG(x1,yy,"Resolution",col2)
        SGReso = SpinGadget(#PB_Any,x1+GadgetWidth(TGReso)-15,yy,50,20,1,10000,#PB_String_Numeric) : SetGadgetText(SGReso,"100")
        
        yy +25+12.5
        
        
        CloseGadgetList()
      EndIf
    
    Case 2 ; preset cinema 
      
  EndSelect
  
  
  
EndMacro

Procedure WindowDocNew()
  
  If OpenWindow(#winNewTileset,0,0,650,500,Lang("NewDoc"),#PB_Window_ScreenCentered|#PB_Window_SystemMenu, WindowID(#WinMain))
    
    w1 = WindowWidth(#winNewTileset)
    h1 = WindowHeight(#winNewTileset)
    Col = RGB(80,80,80)
    col2 = RGB(120,120,120)
    SetWindowColor(#winNewTileset,col)
    
    xx = 165
    canvas = CanvasGadget(#PB_Any,10,10,150,WindowHeight(#winNewTileset)-50) 
    If StartDrawing(CanvasOutput(canvas))
      Box(0,0,200,1000,col2)
      StopDrawing()
    EndIf
    yy=10
    
    WinDocNewCont(1)
    
    ButtonGadget(#GADGET_WNewBtnOk,w1-70,h1 -25,60,20,Lang("Ok"))
    BtnCancel = ButtonGadget(#PB_Any,10,h1-25,GadgetWidth(canvas),20,Lang("Cancel"))
    SetGadgetColor(BtnCancel,#PB_Gadget_BackColor,col2)
    SetGadgetColor(#GADGET_WNewBtnOk,#PB_Gadget_BackColor,col2)
    
    Repeat
      
      Event       = WaitWindowEvent(10)
      EventGadget = EventGadget()
      EventType   = EventType()
      
      Select event
          
          
        Case #PB_Event_Gadget
          
          Select EventGadget
              
            Case CbTemplate
              templat = GetGadgetState(CbTemplate)
              SetGadgetText(#GADGET_WNewW,Str(template(templat)\w))
              SetGadgetText(#GADGET_WNewH,Str(template(templat)\h))

            Case canvas
              
            Case SGnom
              name$ =GetGadgetText(SGNom)
              
           
              
            Case #GADGET_WNewW,#GADGET_WNewH
              W = Val(GetGadgetText(#GADGET_WNewW))
              If W <1
                SetGadgetText(#GADGET_WNewW,Str(1))
              ElseIf W > 10000
                SetGadgetText(#GADGET_WNewW,Str(10000))
              EndIf
              H = Val(GetGadgetText(#GADGET_WNewH))
              If H <1 
                SetGadgetText(#GADGET_WNewH,Str(1))
              ElseIf H > 10000
                SetGadgetText(#GADGET_WNewH,Str(10000))
              EndIf
              
            Case #GADGET_WNewBtnOk
              quit = 1
              ok = 1
              
            Case BtnCancel              
              quit = 1
              
          EndSelect
          
          
        Case #PB_Event_CloseWindow
          quit = 1
          
      EndSelect
      
      
      
      
    Until quit = 1
    

    If ok =1
      Layer_FreeAll()
      
;       w = Val(InputRequester("Infos","New Width of Document",Str(doc\w)))
;       If w >0 And w < 10000
;         Doc\w = w
;       Else
;         MessageRequester("Infos", "The width must be between 1 and 10000. The default width is applied")
;         Doc\w = 1024
;       EndIf
; ;       
; ;       h = Val(InputRequester("Infos","New Height of Document",Str(doc\h)))
;       If h >0 And w < 10000
;         Doc\h = h
;       Else
;         MessageRequester("Infos", "The height must be between 1 and 10000. The default height is applied")
;         Doc\h = 768
;       EndIf
;       
      
      Doc\name$ = name$
      Doc\w = Val(GetGadgetText(#GADGET_WNewW))
      Doc\h = Val(GetGadgetText(#GADGET_WNewH))
      
      
      Layer_Add()
      
      
      ;ClearGadgetItems(#G_LayerList)
      ;n = ArraySize(layer())
      ;AddGadgetItem(#G_LayerList,-1,Layer(layerId)\Name$)
      
      IE_StatusBarUpdate()
      ScreenUpdate()
    
    EndIf
    
    
    FreeArray(template())
    FreeArray(Format$())
    
    CloseWindow(#winNewTileset)

    
  EndIf  
  
EndProcedure

Procedure WindowPref()
  
  Shared animBarre.a
  
  If OpenWindow(#Win_Pref,0,0,400,300,Lang("Preferences"),#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
    
    If PanelGadget(#G_PrefPanel,5,5,390,290)
      
      ;{ General
      AddGadgetItem(#G_PrefPanel,0,"General")
      
      FrameGadget(#G_Frame_Lang,5,5,100,40,"Langage")
      
      ComboBoxGadget(#G_Cob_Lang,15,20,80,20)
      
      Directory$ = "data\Lang\"   
      If ExamineDirectory(0, Directory$, "*.ini")  
        While NextDirectoryEntry(0)
          If DirectoryEntryType(0) = #PB_DirectoryEntry_File
            nom$ = RemoveString(DirectoryEntryName(0),".ini")            
            If nom$ = OptionsIE\Lang$
              pos = CountGadgetItems(#G_Cob_Lang)
            EndIf
            AddGadgetItem(#G_Cob_Lang,-1,nom$)  
          EndIf
        Wend
        FinishDirectory(0)
      EndIf
      SetGadgetState(#G_Cob_Lang,pos)
      ;}
      
      ;{ Grille
      
      AddGadgetItem(#G_PrefPanel,1,"Grille")
      SpinGadget(#G_GridW,5,10,50,20,1,500,#PB_Spin_Numeric)
      SpinGadget(#G_GridH,60,10,50,20,1,500,#PB_Spin_Numeric)
      ButtonGadget(#G_GridColor,120,10,60,20,"Grid Color")
      SetGadgetState(#G_GridW,OptionsIE\GridW)
      SetGadgetState(#G_GridH,OptionsIE\gridH)     
      ;}
      
      ;{ Preset
      AddGadgetItem(#G_PrefPanel,-1,"Brush Preset")
      CheckBoxGadget(#G_BrushPreset_Save_color,10,10,Len(Lang("SaveColorBrush"))*6,20,Lang("SaveColorBrush"))
      ;}
      
      ;{ Animation
      AddGadgetItem(#G_PrefPanel,-1,Lang("Animation"))
      
      ComboBoxGadget(#G_WAnim_CoBFrameTimeline,10,10,80,20)
      AddGadgetItem(#G_WAnim_CoBFrameTimeline,-1,"Frame")
      AddGadgetItem(#G_WAnim_CoBFrameTimeline,-1,"Seconde")
      SetGadgetState(#G_WAnim_CoBFrameTimeline,0)
      
      ComboBoxGadget(#G_WAnim_CBTimelineBar, 10,40,80,20)
      AddGadgetItem(#G_WAnim_CBTimelineBar,-1,"Barre")
      AddGadgetItem(#G_WAnim_CBTimelineBar,-1,"Line")
      SetGadgetState(#G_WAnim_CBTimelineBar,animBarre)
      
      SpinGadget(#G_WPref_SizeFrame,10,80,30,20,4,24,#PB_Spin_Numeric)
      SetGadgetState(#G_WPref_SizeFrame,OptionsIE\SizeFrameW)
      
      ;}
      
      
      CloseGadgetList()      
    EndIf
    
  EndIf
  
EndProcedure


;--- EDITIONS


;--- IMAGES



;--- VIEW



;--- LAYERS
Macro WinLayerPropCont(newtyp)
  
  If Typ <> newtyp
    
    Typ = newtyp
    
    If IsGadget(cont) And cont > #G_LastGadget
      FreeGadget(cont)
    EndIf
    
    xx = 160 : yy = 5
    www = w1-GadgetWidth(canvas)-GadgetWidth(btnok)-30
    hhh = h1-50
    If hhh < 50
      hhh = WindowHeight(#Win_Layer) - 20
    EndIf
    If www < 50
      www = 300
    EndIf  
    Cont = ContainerGadget(#PB_Any,xx,yy,www,hhh)
    
    ; SetGadgetColor(Cont,#PB_Gadget_BackColor,col2)
    u = xx
    xx = 10
    w3 = www-10
    
    Select Typ
        
      Case 0 ; general
        If cont           
          
          nomtxt=TG(xx,yy,Lang("Name"))        
          x1 = xx + GadgetWidth(nomtxt)
          w3 -x1
          SGnom  = SG(x1,yy,w3+10,layer(layerid)\Name$)
          yy+25
          w3 = www
          FrameGadget(#GADGET_WNewTile,xx,yy,w3-10,150,Lang("General"))
          ; SetGadgetColor(#GADGET_WNewTile,#PB_Gadget_BackColor,col2)
          yy + 20
          
          CloseGadgetList()
        EndIf
        
      Case 1 ; style 
        If cont  
          FrameGadget(#GADGET_WNewTile,xx,yy,w3-10,150,Lang("Style"))
          CloseGadgetList()
        EndIf
        
      Case 2 ; drop shadow
        If cont 
          FrameGadget(#GADGET_WNewTile,xx,yy,w3-10,150,Lang("Drop shadow"))
          CloseGadgetList()
        EndIf
        
      Case 3 ; inner shadow
        If cont 
          FrameGadget(#GADGET_WNewTile,xx,yy,w3-10,150,Lang("Inner shadow"))
          CloseGadgetList()
        EndIf
        
      Case 4 ; outer glow
        If cont  
          FrameGadget(#GADGET_WNewTile,xx,yy,w3-10,150,Lang("Outer glow"))
          CloseGadgetList()
        EndIf
        
      Case 5 ; inner glo<w
        If cont  
          FrameGadget(#GADGET_WNewTile,xx,yy,w3-10,150,Lang("Inner glow"))
          CloseGadgetList()
        EndIf
        
      Case 6 ; border
        If cont  
          FrameGadget(#GADGET_WNewTile,xx,yy,w3-10,150,Lang("Border"))
          CloseGadgetList()
        EndIf

    EndSelect
    
  EndIf
  
EndMacro
Procedure WindowLayerProp()
  
  
  If OpenWindow(#Win_Layer,0,0,600,400,Lang("Layer Properties"),#PB_Window_SystemMenu|#PB_Window_ScreenCentered,WindowID(#WinMain))
    
    
    ww = 150
    h1 = WindowHeight(#Win_Layer)
    w1 = WindowWidth(#Win_Layer)
    canvas = ContainerGadget(#PB_Any,5,5,ww,h1-20,#PB_Container_Flat)
    If canvas
      
      xx = 5
      yy = 5
      w2 = ww-10
      
      CB_General    = AddButon2(-2,-1,w2+15,26,"  "+ Lang("General"),#PB_Button_Left,"") : yy+21
      CB_Style      = AddButon2(-2,yy,w2+15,26,"  "+ Lang("Style"),#PB_Button_Left,"") : yy+27
      CB_DropShado  = AddCheckBox2(xx,yy,w2,20,Lang("Drop shadow"),0,"") : yy+20
      CB_InShado    = AddCheckBox2(xx,yy,w2,20,Lang("Inner shadow"),0,"") : yy+20
      CB_OutGlow    = AddCheckBox2(xx,yy,w2,20,Lang("Outer glow"),0,"") : yy+20
      CB_InGlow     = AddCheckBox2(xx,yy,w2,20,Lang("Inner glow"),0,"") : yy+20
      CB_Stroke     = AddCheckBox2(xx,yy,w2,20,Lang("Border"),0,"") : yy+20
      
      CloseGadgetList()
    EndIf
    
    yy = 5
    wu = 80
    btnok     = AddButon2(w1-wu-5,yy,wu,20,Lang("Ok"),#PB_Button_Default,"")      : yy+21
    btnCancel = AddButon2(w1-wu-5,yy,wu,20,Lang("Cancel"),#PB_Button_Default,"")  : yy+21
    btnNewStyle = AddButon2(w1-wu-5,yy,wu,20,Lang("New Style"),#PB_Button_Default,"")  : yy+21
    
    yy+5
    ; preview style 
    img_prev_style = CreateImage(#PB_Any, wu,wu)
    If StartDrawing(ImageOutput(img_prev_style))
      Box(0,0,wu,wu,RGB(190,190,190))
      Box(wu/2-10,wu/2-10,20,20,RGB(120,120,120))
      StopDrawing()
    EndIf
    Preview   = ImageGadget(#PB_Any, w1-wu-5,yy,wu,wu,ImageID(img_prev_style))
    
    Typ = -1
    
    WinLayerPropCont(0)
    
    
    Select layer(LayerId)\Typ
        
      Case #Layer_TypText
        ; Layer_ChangeText()                       
        
    EndSelect  

    
    
    Repeat
      
      event = WaitWindowEvent(10)
      
      Select event
          
          
        Case #PB_Event_Gadget
          Select EventGadget()
              
            Case CB_Style
              WinLayerPropCont(1)
              
            Case CB_General
              WinLayerPropCont(0)
              
            Case  CB_DropShado 
              WinLayerPropCont(2)
              
            Case  CB_InShado 
              WinLayerPropCont(3)
              
            Case  CB_OutGlow 
              WinLayerPropCont(4) 
              
            Case  CB_InGlow 
              WinLayerPropCont(5)
              
            Case  CB_Stroke 
              WinLayerPropCont(6)
              
            Case btnok
              quit = 1
              ok = 1
              
            Case btnCancel
              quit = 1 
              
            Case btnNewStyle
              
              
              
          EndSelect
          
        Case #PB_Event_CloseWindow
          quit = 1
          
      EndSelect
      
    Until quit = 1
    
    
    CloseWindow(#Win_Layer)
    freeimage2(img_prev_style)
    
    If ok = 1
    EndIf
    
  
  EndIf
  

  
  
  
EndProcedure


;--- HELP
Procedure WindowAbout()
  
  txt$ = "Animatoon (version "+#ProgramVersion+")"+Chr(13)+"Développé par Blendman"+Chr(13)
  
  txtcredit$ ="Fred (Purebasic)"+Chr(13)+"B.Vignoli pour la base"+Chr(13)
  txtcredit$ + "LSI (Image Processing), Venom, G-rom,"+Chr(13)+"Kwangee, Dobro, Fangbeast,"+Chr(13)+"Blbltheworm"+Chr(13)+Chr(13)
  
  txtcredit$ +"Icone by : "+Chr(13)+"Sergio Sanchez Lopez, Marco Martin"+Chr(13)+"Oxygen Team, Gnome Project"+Chr(13)+"Creative FreeDom Ltd"+Chr(13)+"David Vignoni"
  txtcredit$ +Chr(13)+"FatCow Web Hosting, Jaanos"
  
  t1$ = "Developped By : "  
    
  
  ;txt_1$ + Chr(13)+ Chr(13)+"Distributed under the LGPL Licence"
  
  If OpenWindow(#Win_About,0,0,400,500,optionsIE\name$,#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
    imgH = 150
    ImgAbout = CreateImage(#PB_Any, 380,imgH);,32, #PB_Image_Transparent)
    ImgAboutCredit = CreateImage(#PB_Any, 380,WindowHeight(#win_About)-80);,32, #PB_Image_Transparent)
    
    ImageLoad2(#Img_About,optionsIE\Theme$+"\paint.png" )
    
    ImageGadget(#GADGET_WAboutImage,10,10,380,imgH,ImageID(ImgAbout))
    
    h = WindowHeight(#win_About)-80
    If ScrollAreaGadget(#GADGET_WAboutSA,10,imgH +20,380, WindowHeight(#win_About)-80-imgH,350,h,#PB_ScrollArea_BorderLess)
      ImageGadget(#GADGET_WAboutImageCredit,0,0,380,h,ImageID(ImgAboutCredit))
      CloseGadgetList()
    EndIf
    SetGadgetColor(#GADGET_WAboutSA,#PB_Gadget_BackColor  ,RGB(170,170,170))
   
    
    If StartDrawing(ImageOutput(ImgAbout))     
      Box(0,0,400,WindowHeight(#win_About),RGB(170,170,170))
      DrawAlphaImage(ImageID(#Img_About),5,5)
      
      DrawingMode(#PB_2DDrawing_Transparent)
      yy1 = 30 + ImageHeight(#Img_About)
      xx1 = 10 + ImageWidth(#Img_About)
      yy2 = 30
      DrawingFont(FontID(#fnt_Arial12))
      DrawText(xx1,yy2,t1$,0)
      DrawText(xx1,yy2+40,"Version : ",0) 
      
      DrawingFont(FontID(#fnt_Arial12Italic))
      DrawText(xx1+TextWidth(t1$),yy2,"Blendman",0)
      
      DrawingFont(FontID(#fnt_Arial10BoldItalic))
      DrawText(xx1+5+TextWidth("Version : "),yy2+42,#ProgramVersion+" ("+FormatDate("%dd/%mm/%yyyy", #ProgramDate)+")",#Black) 
      StopDrawing()
    EndIf
    
    If StartDrawing(ImageOutput(ImgAboutCredit))
      DrawingFont(FontID(#fnt_Arial10BoldItalic))
      Box(0,0,400,WindowHeight(#win_About),RGB(170,170,170))
      DrawingMode(#PB_2DDrawing_Transparent)
      yy1 = 10
      DrawText(10,yy1,Lang("Thanks to "),0)      
      DrawingFont(FontID(#fnt_Arial12))
      DrawTextEx(10,yy1+20,txtcredit$) 
      StopDrawing()
    EndIf
    
    
    
    SetGadgetState(#GADGET_WAboutImage,ImageID(ImgAbout))
    SetGadgetState(#GADGET_WAboutImageCredit,ImageID(ImgAboutCredit))
    
    ButtonGadget(#GADGET_WAboutBtnOk,170,WindowHeight(#win_About)-50,60,20,"Ok")
  EndIf
  
  
  Repeat
    
    event = WaitWindowEvent(10)
    
    Select event 
        
      Case #PB_Event_Gadget       
        
        Select  EventGadget()
            
          Case #GADGET_WAboutBtnOk           
            QuitAbout = 1
            
        EndSelect
        
      Case #PB_Event_CloseWindow
        
        If GetActiveWindow() = #win_About
          QuitAbout = 1
        EndIf
        
    EndSelect
    
  Until QuitAbout = 1 
  CloseWindow(#Win_About)
  FreeImage2(ImgAbout)
  FreeImage2(ImgAboutCredit)
  FreeImage2(#Img_About)
  
EndProcedure




; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 597
; FirstLine = 78
; Folding = AAAAAL5
; EnableXP
; EnableUnicode