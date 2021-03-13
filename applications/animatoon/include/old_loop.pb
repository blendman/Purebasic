

; animatoon (screen), loop 5pb5.30 / 06/2015


Repeat
  
  Z.d = OptionsIE\Zoom*0.01
  mx = WindowMouseX(0) - ScreenX 
  my = WindowMouseY(0) - ScreenY

  Repeat 
    
    Event       = WaitWindowEvent(1)
    EventMenu   = EventMenu()
    EventGadget = EventGadget()
    EventType   = EventType()
    EventWindow = EventWindow()
    
    If event <> 0
      
      Select Event
          
        Case #PB_Event_Menu
          
          If inscreen
            ;ReleaseMouse(1)
            MenuOpen = 1
          EndIf
        
          Select EventMenu
              
              ;{ file
              
            Case #menu_New            
              Doc_New()
              
            Case #Menu_Open
              Doc_Open()
              
            Case #Menu_Save
              Doc_Save()
              
            Case #Menu_SaveImage
              File_SaveImage()
                            
            Case #Menu_Import
             Layer_ImportImage()
              
            Case #Menu_ExportAll             
              filename$ = SaveFileRequester("Save Image","","png|*.png",0)
              If filename$ <>""
                For i=0 To ArraySize(layer())-1
                  ; name$=GetFilePart(filename$)+"_Layer"+Str(i)+ ".png"
                  name$=filename$+"_Layer"+Str(i)+ ".png"
                  SaveImage(Layer(i)\image, name$,#PB_ImagePlugin_PNG)
                Next i  
              EndIf
              
            Case #Menu_ExportAllZip  
              filename$ = SaveFileRequester("Save Image","","png|*.png",0)
              If filename$ <>""
                UseZipPacker()
                If CreatePack(0, filename$+".zip")
                  For i=0 To ArraySize(layer())-1
                    name$=GetFilePart(filename$)+"_Layer"+Str(i)+ ".png"
                    SaveImage(Layer(i)\image, name$,#PB_ImagePlugin_PNG)
                    AddPackFile(0, name$, name$)
                    DeleteFile(name$)
                  Next i
                  ClosePack(0) 
                EndIf
              EndIf
              
            Case #Menu_Export ; on export le layer courant              
              filename$ = SaveFileRequester("Save Image","","png|*.png",0)
              If filename$ <>""
                If GetExtensionPart(filename$) <> "png"
                  filename$ + ".png"
                EndIf                
                SaveImage(Layer(LayerId)\image, filename$,#PB_ImagePlugin_PNG)
              EndIf
              
            Case #Menu_Exit
              quit = 1
              Break
              
              ;}
              
              ;{ Editions
            Case #Menu_clear
              Layer_Clear(LayerId)
              
            Case #Menu_Paste
              Edit_Paste()
              
            Case #Menu_Cut
              Edit_Copy()
              Layer_Clear(LayerId)
              
            Case #Menu_Copy
              Edit_Copy()
              
            Case #Menu_FillAll
              Layer_Fill(1)
              
            Case #Menu_Fill
              Layer_Fill(0)
              
            Case #Menu_FillPatern
             Layer_Fill(2)
              
            Case #Menu_MirorH 
              MirorImage(Layer(LayerId)\Image)
              
            Case #Menu_MirorV 
              MirorImage(Layer(LayerId)\Image,0)
              
            Case #Menu_RealTime
              Clear = 1-clear
              SetMenuItemState(0,#Menu_RealTime,Clear)
              ;}
              
              ;{ image
            Case #Menu_ResizeDoc
              ResizeDoc(0)
              
            Case #Menu_ResizeCAnvas
              ResizeDoc(1)
              
            Case #menu_InverseColor
              IE_InvertColor(layer(layerId)\Image)
              
            Case #menu_Desaturation
              IE_Desaturation(layer(layerId)\Image)
              
            Case #menu_Constrast
              
              
              
              ;}
              
              ;{ view
            Case #menu_IE_ZoomPlus            
              If OptionsIE\Zoom <= 200
                OptionsIE\Zoom +10
                ScreenZoom()
              ElseIf OptionsIE\Zoom < 1000 And OptionsIE\Zoom > 200
                OptionsIE\Zoom +100
                ScreenZoom()
              EndIf
              
            Case #menu_IE_ZoomMoins
              If OptionsIE\Zoom > 10
                If OptionsIE\Zoom > 200
                  OptionsIE\Zoom -100
                  ScreenZoom()
                Else
                  OptionsIE\Zoom -10
                  ScreenZoom()
                EndIf              
              EndIf
              
            Case #menu_IE_Zoom50   
              OptionsIE\Zoom = 50
              ScreenZoom()   
              
            Case #menu_IE_Zoom100   
              OptionsIE\Zoom = 100
              ScreenZoom()  
              
            Case #menu_IE_Zoom200
              OptionsIE\Zoom = 200
              ScreenZoom()
              
            Case #menu_IE_Zoom300   
              OptionsIE\Zoom = 300
              ScreenZoom() 
              
            Case #menu_IE_Zoom400             
              OptionsIE\Zoom = 400
              ScreenZoom() 
              
            Case #menu_IE_Zoom500   
              OptionsIE\Zoom = 500
              ScreenZoom() 
              
            Case #Menu_ResetCenter
              canvasX =0
              canvasY = 0
              ScreenUpdate()
              
            Case #Menu_CenterView
              CanvasX = ScreenWidth()/2 - (doc\w*z)/2
              CanvasY = ScreenHeight()/2 - (doc\h*z)/2                
              ScreenUpdate()
              ;}
              
              ;{ Layer 
            Case #Menu_LayerDuplicate
              OldLayerId = LayerId
              Layer_Add()
              If  StartDrawing(ImageOutput(layer(LayerId)\image))
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                ; Box(0,0,canvasW,canvasH,RGBA(0,0,0,0))
                DrawAlphaImage(ImageID(Layer(OldLayerId)\image),0,0)
                StopDrawing()
              EndIf
              If  StartDrawing(SpriteOutput(layer(LayerId)\Sprite))
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                ; Box(0,0,canvasW,canvasH,RGBA(0,0,0,0))
                DrawAlphaImage(ImageID(Layer(LayerId)\image),0,0)
                StopDrawing()
              EndIf
              NewPainting = 1
              ScreenUpdate()
              
            Case #Menu_LayerMoveDown
              Layer_ChangePos(-1)
              
            Case #Menu_LayerMoveUp
              Layer_ChangePos()
              
            Case #Menu_LayerDel
              If ArraySize(layer()) > 1
                Layer_Delete()
              EndIf
                
            Case #Menu_LayerMergeDown
              If ArraySize(layer()) > 1 And LayerId > 0
                Layer_Merge()
              EndIf
              
            Case #Menu_LayerMergeAllVisible
              If ArraySize(layer()) > 1
                Layer_Merge(2)
              EndIf
              
            Case #Menu_LayerMergeAll
              If ArraySize(layer()) > 1
                Layer_Merge(1)
              EndIf
              
           Case #Menu_LayerMergeLinked
              If ArraySize(layer()) > 1
                Layer_Merge(3)
              EndIf
              
                
              ;}
              
              ;{ Help
            Case #menu_about 
              MessageRequester("About",#ProgramName+" "+#ProgramVersion+" (Revision "+#ProgramRevision+")"+
                                       Chr(13)+"Made in purebasic (5.22,5.31) by Blendman"+Chr(13)+"Date : "+#ProgramDate+
                                       Chr(13)+"Thanks to : Fred (purebasic power !) & PB team, Danilo, LSI, Dobro, G-Rom, Onilink, KwanJeen, Netmaestro, "+
                                       "Infratec, ApplePy, Idle And all the guys at the PB forums (English & French).")
              ;}
              
            Default
              MessageRequester("Info", "Not implemented")
              
          EndSelect
          
        Case #PB_Event_Gadget
          Gad = 1
          If EventGadget>=#G_IE_Pen And eventgadget<=#G_IE_Zoom
            
            UpdateTool(EventGadget)
            MoveLayerY = 0
            MoveLayerX = 0
            ActionKeyb = 0
            If Brush\Action = #Action_Hand
              MoveCanvas = 1
            Else
              MoveCanvas = 0
            EndIf
            
          Else
            
            Select eventgadget
                
                ;{ Layer
              Case #G_LayerList
                If OldAction <> Brush\Action
                  Layer_ValidChange(Brush\Action)  
                  OldAction = Brush\Action
                EndIf                
                Id = GetGadgetState(#G_LayerList) 
                UpdateGadgetLayer(id)
                ScreenUpdate()            
                LayerId= id
                If EventType = #PB_EventType_LeftDoubleClick
                  nom$ = InputRequester("Name","New Name","")
                  If nom$ <> ""
                    layer(layerid)\name$ = nom$
                    SetGadgetItemText(#G_LayerList,id,nom$)
                  EndIf
                EndIf
                
              Case #G_LayerBM
                oldbm = layer(layerid)\bm
                Layer_SetBm(GetGadgetState(#G_LayerBM))
                newpainting = 1
                ScreenUpdate(1) 
                
              Case #G_LayerView
                Layer(LayerId)\view = GetGadgetState(#G_LayerView)
                ScreenUpdate()
                
              Case #G_LayerLocked
                Layer(LayerId)\locked = GetGadgetState(#G_LayerLocked)
                
              Case #G_LayerAlpha
                Layer(LayerId)\alpha = GetGadgetState(#G_LayerAlpha)
                SetGadgetState(#G_LayerAlphaSpin,Layer(LayerId)\alpha)
                If layer(layerId)\bm <> #Bm_Normal
                  NewPainting = 1
                EndIf                
                ScreenUpdate()
                
              Case #G_LayerAlphaSpin                
                Layer(LayerId)\alpha = GetGadgetState(#G_LayerAlphaSpin)
                SetGadgetState(#G_LayerAlpha,Layer(LayerId)\alpha)
                If layer(layerId)\bm <> #Bm_Normal
                  NewPainting = 1
                EndIf                
                ScreenUpdate()
                
              Case #G_LayerDel
                If ArraySize(layer()) > 1
                  Layer_Delete()
                EndIf
                
                
              Case #G_LayerAlphaLock
                Layer(LayerId)\LockAlpha = GetGadgetState(#G_LayerAlphaLock)
                
              Case #G_LayerAdd
                If OldAction <> Brush\Action
                  Layer_ValidChange(Brush\Action)  
                  OldAction = Brush\Action
                EndIf  
                If NewPainting
                  ScreenUpdate()
                EndIf            
                Layer_Add()
                                
              Case #G_LayerMoveup
                Layer_ChangePos()
                
              Case #G_LayerMovedown
                Layer_ChangePos(-1)
                
                ;}
                
                ;{ brush 
                
                ; alpha  
              Case #G_BrushAlphaRand
                Brush\AlphaRand = GetGadgetState(#G_BrushAlphaRand)
                
              Case #G_BrushAlphaMin
                Brush\AlphaMin = GetGadgetState(#G_BrushAlphaMin)
                
              Case #G_BrushAlphaPressure
                Brush\AlphaPressure = GetGadgetState(#G_BrushAlphaPressure)
                
              Case #G_BrushAlpha
                Brush\alpha = GetGadgetState(#G_BrushAlpha)
                color = RGBA(Brush\col\R,Brush\col\G,Brush\col\B,Brush\alpha)
                
              ; param  
              Case #G_IE_Type 
                BRush\Type = GetGadgetState(#G_IE_Type)
                
              Case #G_brushSmooth
                Brush\Smooth = GetGadgetState(#G_brushSmooth)
                BrushUpdateImage(0,1)
                BrushUpdateColor() 
                                 
              Case #G_brushHardness,#G_brushIntensity,#G_brushSoftness
                Brush\Hardness = GetGadgetState(#G_brushHardness)
                Brush\Intensity = GetGadgetState(#G_brushIntensity)
                Brush\Softness = GetGadgetState(#G_brushSoftness)
                BrushUpdateImage(0,1)
                BrushUpdateColor() 
                
              Case #G_BrushPas                
                Brush\pas = GetGadgetState(#G_BrushPas)
                   
              Case #G_brushTrait               
                Brush\Trait = GetGadgetState(#G_brushTrait)
                
              Case #G_BrushSymetry                
                Brush\symetry = GetGadgetState(#G_BrushSymetry)
                

                
              ; size  
              Case #G_BrushSizePressure
                Brush\Sizepressure = GetGadgetState(#G_BrushSizePressure)
                
              Case #G_BrushSize,#G_BrushSizeW,#G_BrushSizeH 
                Brush\size = GetGadgetState(#G_BrushSize)
                If brush\SizeMin> brush\Size
                  SetGadgetState(#G_BrushSizeMin,brush\size)
                  brush\sizemin = brush\size
                EndIf
                Brush\sizeW = GetGadgetState(#G_BrushSizeW)
                Brush\sizeH = GetGadgetState(#G_BrushSizeH)
                BrushUpdateImage(0,1)
                BrushUpdateColor()   
                
              Case #G_BrushSizeMin
                Brush\SizeMin = GetGadgetState(#G_BrushSizeMin)
                If brush\SizeMin> brush\Size
                  SetGadgetState(#G_BrushSizeMin,brush\size)
                  brush\sizemin = brush\size
                EndIf
                
                
              Case #G_BrushSizeRand 
                Brush\SizeRand = GetGadgetState(#G_BrushSizeRand)
                
              ; dynamic                
              Case #G_BrushScatter
                Brush\scatter = GetGadgetState(#G_BrushScatter)
                
              Case #G_BrushRandRotate
                Brush\randRot = GetGadgetState(#G_BrushRandRotate)
                
              Case #G_BrushRotate
                Brush\rotate = GetGadgetState(#G_BrushRotate)
                BrushUpdateImage(0,1)
                BrushUpdateColor() 
                
              Case #G_BrushRotateAngle  
                Brush\RotateParAngle = GetGadgetState(#G_BrushRotateAngle)
                
                ; color                
              ; Case #G_BrushMixLayerCustom
                
              Case #G_BrushMixLayer
                brush\MixLayer = GetGadgetState(#G_BrushMixLayer)
                                
              Case #G_BrushMixTyp
                Brush\MixType = GetGadgetState(#G_BrushMixTyp)
                
              Case #G_BrushMix
                Brush\mix = GetGadgetState(#G_BrushMix)
                If brush\mix = 0
                  If brush\Lavage = 1
                    BrushUpdateImage(0,1)
                    BrushUpdateColor() 
                  EndIf
                EndIf
            
              Case #G_BrushVisco
                Brush\Visco = GetGadgetState(#G_BrushVisco)
                
              Case #G_BrushLavage
                Brush\Lavage = GetGadgetState(#G_BrushLavage)
                                
              Case #G_BrushColorFG
                If eventType = #PB_EventType_LeftClick
                  Brush\ColorFG = ColorRequester(Brush\colorFG)
                  ; BrushUpdateColor()      
                  ; color = RGBA(Brush\colR,Brush\colG,Brush\colB,Brush\alpha)
                  UpdateColorFG()
                EndIf
                
              Case #G_BrushColor
                If eventType = #PB_EventType_LeftClick
                  Brush\color = ColorRequester(Brush\color)
                  Brush\ColorBG\R = Red(Brush\Color)
                  Brush\ColorBG\G = Green(Brush\Color)
                  Brush\ColorBG\B = Blue(Brush\Color)
                  BrushUpdateColor()      
                  color = RGBA(Brush\col\R,Brush\col\G,Brush\col\B,Brush\alpha)
                EndIf
                
              Case #G_BrushPrevious
                If brush\id > 1
                  brush\id -1
                Else
                  Brush\Id = brush\BrushNumMax+1
                EndIf                
                BrushUpdateImage(1,1)
                BrushUpdateColor() 
                
              Case #G_BrushNext
                If brush\id < Brush\BrushNumMax+1
                  brush\id +1
                Else
                  Brush\id = 1
                EndIf                
                BrushUpdateImage(1,1)
                BrushUpdateColor()     
                
                ;}
                
                ;{ roughboard
              Case #G_RBPaint
                OptionsIE\RB_Action = 1- OptionsIE\RB_Action 
                If OptionsIE\RB_Action = 1
                  SetGadgetAttribute(#G_RBPaint,#PB_Button_Image,ImageID(#ico_IE_Pen))
                Else
                  SetGadgetAttribute(#G_RBPaint,#PB_Button_Image,ImageID(#ico_IE_Pipette))
                EndIf
                
              Case #G_RBOpen
                file$ = OpenFileRequester("Open Roughboard Image","","Image|*.png;*.jpg;*.bmp",0)
                If file$ <> ""
                  If LoadImage(#image_RB,file$)
                    OptionsIE\RB_Img$ = File$
                    If StartDrawing(CanvasOutput(#G_RoughtBoard))
                      DrawImage(ImageID(#image_RB),0,0)
                      StopDrawing()
                    EndIf
                  EndIf
                EndIf
                                    
              Case #G_RBSave
                Format = SelectFormat(OptionsIE\RB_Img$)                
                If SaveImage(#image_RB, OptionsIE\RB_Img$,format) : EndIf
                
                
              Case #G_RBExport
                file$ = SaveFileRequester("Save Roughboard Image","","JPG|*.jpg|PNG|*.png",0)
                If file$ <> ""
                  ext$ = GetExtensionPart(file$)
                  If ext$ <> "png" Or ext$ <> "jpg" 
                    index = SelectedFilePattern()
                    If index = 0
                      File$+".jpg"
                    Else
                      File$+".png"
                    EndIf
                  EndIf
                  OptionsIE\RB_Img$ = File$
                  Debug  OptionsIE\RB_Img$
                  Format = SelectFormat(file$) 
                  Debug format
                  If SaveImage(#image_RB, OptionsIE\RB_Img$,format) : EndIf
                EndIf
                
                
              Case #G_RoughtBoard
                If EventType = #PB_EventType_LeftButtonDown Or 
                   (EventType= #PB_EventType_MouseMove And 
                    GetGadgetAttribute(#G_RoughtBoard, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton )
                  If OptionsIE\RB_Action = 0 ; on pick la couleur
                    If StartDrawing(CanvasOutput(#G_RoughtBoard))
                      rbx = GetGadgetAttribute(#G_RoughtBoard, #PB_Canvas_MouseX)
                      rby = GetGadgetAttribute(#G_RoughtBoard, #PB_Canvas_MouseY)                    
                      Brush\color = Point(rbx,rby)
                      StopDrawing()
                    EndIf  
                    BrushResetColor()
                    BrushUpdateColor()
                    Brush\ColorBG\R = Red(brush\color)
                    Brush\ColorBG\G = Green(brush\color)
                    Brush\ColorBG\B = Blue(brush\color)
                    color = RGBA(Brush\col\R,Brush\col\G,Brush\col\B,Brush\alpha)
                  Else
                    If StartDrawing(CanvasOutput(#G_RoughtBoard))
                      rbx = GetGadgetAttribute(#G_RoughtBoard, #PB_Canvas_MouseX)
                      rby = GetGadgetAttribute(#G_RoughtBoard, #PB_Canvas_MouseY)                    
                      Circle(rbx,rby,3,brush\color)
                      StopDrawing()
                    EndIf                    
                  EndIf
                  
                ElseIf EventType = #PB_EventType_LeftButtonUp
                  If StartDrawing(ImageOutput(#image_RB))
                    DrawImage(GetGadgetAttribute(#G_RoughtBoard, #PB_Canvas_Image), 0, 0)
                    StopDrawing()
                  EndIf
                EndIf
                
                ;}
                
                ;{ preset
              Case #G_PresetChangeBank
                nom$ = PathRequester("Open a Bank folder", OptionsIE\DirPreset$ )
                If nom$ <> ""
                  OptionsIE\DirPreset$ = nom$
                  OpenPresetBank()
                EndIf
                
              Case #G_PresetReloadBank
                OpenPresetBank()
                
              Case #G_PresetSavePresetAs
                SaveBrushPreset()
                
              Case #G_PresetSavePreset
                file$ = GetParentItemText(#G_PresetTG) 
                SaveBrushPreset(1,file$)
                 
              Case #G_PresetTG 
                brush$ = GetGadgetText(#G_PresetTG)
                file$ = GetParentItemText(#G_PresetTG)
                OpenPreset(file$,brush$)
                ;}
                
                ;{ paper
              Case #G_ListPaper                
                OptionsIE\Paper$ = GetGadgetItemText(#G_ListPaper,GetGadgetState(#G_ListPaper))
                PaperUpdate(1)
                ScreenUpdate(0)
                ;} 
                
                ;{ splitters
              Case #G_SplitLayerRB,#G_SplitToolCol
                IE_SaveSplitter(GetGadgetState(#G_SplitLayerRB),GetGadgetState(#G_SplitToolCol), 0)
               
                
                ;}
                
            EndSelect
            
          EndIf 
          
        Case #PB_Event_SizeWindow
          ;{ on resize la fenêtre
          MenuOpen = 1
          ScreenResized = 1
          IE_UpdateGadget()
          ;}
          
        Case #PB_Event_CloseWindow
          If EventWindow = #WinMain
            quit = 1
          Else
            CloseWindow(EventWindow)
          EndIf
                
        Case #WM_MOUSEWHEEL 
          ; Mwheel = 
          If Mwheel <> 0
            If MWheel > 0
              If OptionsIE\zoom <5000
                OptionsIE\zoom=OptionsIE\zoom +10
              EndIf
            Else
              If OptionsIE\zoom> 10
                OptionsIE\zoom=OptionsIE\zoom -10
              EndIf
            EndIf    
            ScreenZoom()
          EndIf  

          
        Case #WM_LBUTTONDOWN
          If Mx>0 And My>0 And Mx<ScreenWidth()-1 And My<ScreenHeight()-1 
            MouseClic = 1
            Paint = 1
          EndIf
          
        Case  #WM_LBUTTONUP
          MouseClic = 0
          If paint = 1
            paint = 0 
            ; on modifie le tableau des stroke
            
            n = ArraySize(Stroke())
            If n < OptionsIE\Maxundo
              StrokeId +1
              ReDim Stroke(StrokeId)
            Else
              If StrokeId = n
                StrokeId = 0
              Else
                StrokeId +1
              EndIf              
            EndIf
            
            ; on lave le pinceau si besoin
            If brush\Lavage
              Brush\Color = RGB(Brush\ColorBG\R,Brush\ColorBG\G,Brush\ColorBG\B)
              BrushResetColor()
              BrushUpdateImage(0,1)
            EndIf
          EndIf
          
      EndSelect
      
    EndIf
        
  Until event = 0 Or event = #WM_LBUTTONDOWN Or event = #WM_LBUTTONUP
    
  
  ;{ Mouse, paint
  
  ;{ on garde pour mac, linux 
  ; MouseClic = 0
  ; ExamineMouse()     
  ;If MouseButton(1)
  ;MouseClic = 1
  ;EndIf
 ; CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    
    ;If mouseclic = 0
      ;ExamineMouse()     
      ;Mwheel + MouseWheel()
;       If Mwheel <> 0
;         If MWheel > 0
;           If OptionsIE\zoom <5000
;             OptionsIE\zoom=OptionsIE\zoom +10
;           EndIf
;         Else
;           If OptionsIE\zoom> 10
;             OptionsIE\zoom=OptionsIE\zoom -10
;           EndIf
;         EndIf    
;         ScreenZoom()
;       EndIf 
    ;EndIf
    
 ; CompilerEndIf

  ;}
  
  If Mx>0 And My>0 And Mx<ScreenWidth()-1 And My<ScreenHeight()-1 
    
    StatusBarText(#Statusbar,2,Str(mx)+"/"+Str(my)+" - "+Str(rx)+"/"+Str(ry)+" - canvas : "+Str(canvasX)+"/"+Str(canvasY)+"-"+Str(ScreenWidth()))
    
    ;{ on est sur le screen-canvas, on peut effectuer des actions de dessin
        
    ;{ d'abord, on modifie quelques parametres
    If MenuOpen = 1
      MenuOpen = 0
      ;ReleaseMouse(0)
      ;MouseClic = 1  
      
      If ScreenResized ; on resizé l'acran
        W = WindowWidth(#WinMain) - ScreenX*2 ; -10
        H = WindowHeight(#WinMain) - 150
        ResizeScreen(w,h)
        ScreenResized = 0
      EndIf
      
    EndIf
        
    If gad = 1 And MouseClic = 1
      gad = 0
      SetActiveGadget(#G_ToolBar)    
    EndIf             
    
    If inscreen = 0 ;And size =0
      inscreen = 1
      ; pour window
      ;CompilerIf #PB_Compiler_OS = #PB_OS_Windows
        ;If Mwheel = 0
          ;ReleaseMouse(1)
        ;EndIf        
      ;CompilerElse 
      ; pour linux et mac (j'utilise examinemouse() avec llinux et mac)
      ; ReleaseMouse(0)
      ; MouseLocate(mx,my)
      ;CompilerEndIf
        
    EndIf
    
    ;}
    
    If MouseClic ; on clique sur le canvas
      
      OPtionsIE\cursorX = 10000
      
      If MoveCanvas >= 1
        
        ;{ on bouge le canvas
        If MoveCanvas=1 
          Movecanvas = 2
;           OldCanvasX = MouseX() - CanvasX
;           OldCanvasY = MouseY() - CanvasY
          OldCanvasX = Mx - CanvasX
          OldCanvasY = My - CanvasY
          If NewPainting = 1
            ScreenUpdate()
          EndIf
        EndIf
        ;CanvasX = MouseX() - OldCanvasX
        ;CanvasY = MouseY() - OldCanvasY 
        CanvasX = Mx - OldCanvasX
        CanvasY = My - OldCanvasY 
        ClearScreen(RGB(120,120,120))
        
        ; the paper
        PaperDraw()
        
        ; on affiche tous les calques du fond
        Layer_DrawAll()
        ;}
        
      Else
      
        ;{ On fait une action : peindre, effacer, bouger un layer, etc..
                
        If Brush\Action <= #Action_Eraser ; (pen, pinceau, particule, spray, effacer, )
          
          
          Select Brush\action
              
             ;{ -------------- dessin, gomme             
              
            Case #Action_Brush, #Action_Eraser 
              
              ;{ on efface l'écran ou non ? (options tps réel)
;               ; en fait, je le fais en fonction de l'outil (si on pick la couleur ou si on peint, donc c'est mis pour chacun et pas ici, car ça ferait doublon
;               If clear = 1
;                 
;                 ClearScreen(RGB(120,120,120))
;                 
;                 ; Puis on affiche le fond (paper)          
;                 PaperDraw()
;                 
;                 ; on affiche les calques du dessous
;                 For i = 0 To ArraySize(layer())-1
;                   If layer(i)\ordre <= layer(layerId)\ordre
;                     If layer(i)\view 
;                       Layer_Draw(i)
;                     EndIf
;                   EndIf
;                 Next i 
;                 
;               EndIf
;}
              
              Paint = 1 ; on peint (c'est pour voir si c'est la souris ou non)
              
              If alt = 0 ; on dessine         
                               
                ; on va dessiner sur le "calque" actif  et sur l'image active
                If layer(layerId)\view
                  
                  If layer(layerId)\locked = 0
                    
                    ;{ on calcule divers paramètres (pression, etc..)

                    ;{ tablet 
                    size.d = 0
                    
                    If ListSize(Pakets()) = 0 ; ça c'est juste au cas où on dessine avec la souris, 
                      ; auquel cas, pas de packet et donc pas de pression non plus. ben voui, c'est comme ça la vie.
                      If pression <> 1
                        Size = 8.6
                        pression = 2
                      EndIf
                      
                      ;Debug "ok souris  - " + Str(pression)
                   ; Else
                      ; Size = 0.01
                      ;Debug "on a des packets, meme avec souris ?"
                    EndIf
                    
                    
                    If StartDrawing(ImageOutput(#ImageTablet))                      
                      DrawingMode(#PB_2DDrawing_AlphaBlend)                      
                      If ListSize(Pakets())
                        ForEach Pakets()
                          Define p.POINT
                          
                          p\x = MulDiv_(Pakets()\pkX,winw,10000)
                          p\y = winh-MulDiv_(Pakets()\pkY,winh,10000)
                          
                          size.d = Pakets()\pkNormalPressure / 120
                          If size > 0
                            Pression = 1
                          EndIf
                          size + 0.2
                          ; ; ScreenToClient_(GadgetID(#canvas),@p)
                          ; ; ScreenToClient_(ScreenOutput(),@p)
                          ;; drawbrush(p\x, p\y, size)
                          
                          ; Mousex_Old = mx
                          ; MouseY_Old = my
                          Mousex_Old = p\x
                          MouseY_Old = p\y
                          ;;StartX = MouseX_Old
                          ;;StartY = MouseY_Old
                        Next
                        ClearList(Pakets())
                      Else
                        ; drawbrush(MouseX, MouseY, size)                          
                        MouseX_Old = Mx
                        MouseY_Old = My
                        StartX = MouseX_Old
                        StartY = MouseY_Old
                      EndIf
                      StopDrawing()                      
                    EndIf
                    
                    
                    ;}
                                          
                    ; le blendmode
                    Layer_Bm(layerId)
                    ;}
                    
                    If size > 0 ; on ne dessine que si on a notre brush visible, pardi :)
                    
                    ;******** puis on dessine
                    ; NewPainting = 1
                    
                    ;{ pour dessiner sur le screenoutput(), si besoin, (attention lent ?)
                    ; If StartDrawing(ScreenOutput())
                    ;   DrawingMode(#PB_2DDrawing_AlphaBlend)
                    ;   Circle(mx-Brush\centerSpriteX,My-brush\centerSpriteY,Brush\size,color)
                    ;   StopDrawing()
                    ; EndIf
                    ;}
                    
                    
                    ; d'abord, on va mélanger les couleurs en tps réel 
                      
                      If brush\mix > 0 
                        
                      Select brush\MixLayer ; on vérifie sur quels layers on peut prendre la couleur
                          
                          ; Case 0 ; tous ceux en dessous (defaut) : pas besoin on ne change rien
                          
                        Case 1 ; le calque sélectionné uniquement
                          ClearScreen(RGB(120,120,120))                    
                          ; Puis on affiche le fond (paper)          
                          ; PaperDraw()                    
                          ; on affiche les calques du dessous
                          Layer_Draw(LayerId)
                          
                        Case 2 ; tous
                          ClearScreen(RGB(120,120,120))                    
                          ; Puis on affiche le fond (paper)          
                          ; PaperDraw()                    
                          ; on affiche les calques du dessous
                          For i = 0 To ArraySize(layer())-1
                            If layer(i)\view 
                              Layer_Draw(i)
                            EndIf
                          Next i 
                          
                        Case 3 ; calques qu'on a mis ok pour le pick color
                          ClearScreen(RGB(120,120,120))                    
                          ; Puis on affiche le fond (paper)          
                          ; PaperDraw()                    
                          ; on affiche les calques du dessous
                          For i = 0 To ArraySize(layer())-1
                            If layer(i)\view 
                              If layer(i)\OkForColorPick
                                Layer_Draw(i)
                              EndIf
                            EndIf
                          Next i 
                          
                      EndSelect
                      
                      ; puis on chope la couleur
                      color = brush\color                                              
                      If brush\MixType = 0
                        color = BrushCheckMixClassic(mx,my)
                      ElseIf Brush\MixType = 1
                        color = BrushCheckMixInverse(mx,my)
                      ElseIf Brush\MixType = 2
                        color = BrushCheckMixOld(mx,my)
                      Else
                        Color = BrushCheckMixNew(mx,my)
                      EndIf
                        
                      EndIf
                      
                      ; Puis, on réaffiche les calques du dessous, ben oui
                      If clear
                        ClearScreen(RGB(120,120,120))                  
                        ; Puis on affiche le fond (paper)          
                        PaperDraw()                  
                        ; on affiche les calques du dessous
                        For i = 0 To ArraySize(layer())-1
                          If layer(i)\ordre <= layer(layerId)\ordre
                            If layer(i)\view 
                              Layer_Draw(i)
                            EndIf
                          EndIf
                        Next i 
                      EndIf
                      
                      
                    ; on enregistre les dot()             
                    ;{ pour créer les dot() en tps réel // désactivé pour l'instant
                     ; AddDot(mx,my,size,color)
                    ;}
                    
                    
                    ; position x et y du brush
                    xx = mx - Brush\centerSpriteX  
                    yy = My - brush\centerSpriteY  
                    
                    If clic= 0 ; on garde la position de la souris
                      clic=1
                      StartX = xx
                      StartY = yy          
                    EndIf
                    
                    ;*************** Ensuite, on dessine tout sur le sprite (clear = 1) ou le screen (clear=0)
                    ; peut-être devrais-je faire une inversion  : 
                    ; d'abord dessiner sur l'image, puis sur le sprite ?
                    
                    ; <------------ attention, j'ai mis plusieurs fois la même chose, à modifier/supprimer lors de la phase d'optimisation
                    
                    If Brush\Trait
                      dist  = point_distance(xx,yy,StartX,StartY) ; to find the distance between two brush dots
                      d.d   = point_direction(xx,yy,StartX,StartY); to find the direction between the two brush dots
                      sinD.d = Sin(d)                
                      cosD.d = Cos(d)
                      
                      ; pour la pression tablet, à finir                     
                      ; brushsiz.d = Brush\size * size*0.02 +1 ; old  
                      ; b = (size/2+1) * Brush\Pas*0.01 ; old
                      
                      brushsiz.d = Brush\size * size/(8.54)                      
                      If brushsiz<0
                        brushsiz = 1
                      EndIf
                      b = (brushsiz * Brush\Pas*0.01) * brush\SizeW*0.01
                      
                      ;{ transition, pas encore pris en compte : 
                      ; la transition = le fade entre les points pour lisser le changement de taille ou d'alpha.
                      If brushsiz_old.d <= 0
                        brushsiz_old = brushsiz
                      EndIf
                      
                      ; ratio.d = \dot(i-1)\size - \dot(i)\size
                      ratio.d = brushsiz_old - brushsiz
                      ratio/dist
                                                                  
;}
                      
                      ; FinalSize.d = (brushsiz_old+newsiz*v)*Brush\Sizepressure + (1-Brush\Sizepressure)     
                      FinalSize.d = ((size/8.54)*Brush\Sizepressure + (1-Brush\Sizepressure))
                      
                      rndsiz.d = Random(brush\Size,brush\SizeMin)
                      rndsiz/brush\Size
                      If rndsiz <= 0
                        rndsiz = 0.5 * (brush\Size)/brush\Size
                      EndIf
                      FinalSize = rndsiz * Brush\SizeRand + (1-Brush\SizeRand)*FinalSize
                      If finalsize * brush\size < Brush\SizeMin
                        finalsize = Brush\SizeMin/brush\size 
                      EndIf
                    
                      If FinalSize > 0
                                              
                        z = OptionsIE\Zoom*0.01
                      
                        If clear = 0
                        
                          ;{ technic pas tps réel, on dessine sur le screen
                          For u = 0 To dist-1
                            
                            Scx.d = Rnd(Brush\scatter)* Brush\size * 0.01
                            Scy.d = Rnd(Brush\scatter)* Brush\size * 0.01
                            CheckAlpha()
                                                    
                            
                            x_result =  sinD * u + xx + scx + Brush\centerSpriteX - (FinalSize*Brush\W*z)/2 
                            y_result =  cosD * u + yy + scy + Brush\centerSpriteY - (FinalSize*Brush\H*z)/2
                            
                            
                            RotateSprite(#Sp_BrushCopy, Random(brush\randRot),1)
                            ZoomSprite(#Sp_BrushCopy,FinalSize*Brush\W*z,FinalSize*Brush\H*z) ; tablet pas encore actif 
                            
                            
                            If brush\Action = #Action_Eraser
                              col = RGB(250,250,250)
                            Else
                              col = Color
                            EndIf
                            
                            DisplayTransparentSprite(#Sp_BrushCopy,x_result,y_result,alpha,Col) 
                            
                            v+1
                            u + b
                          Next u
                          
                          StartX = XX
                          StartY = YY
                          brushsiz_old = brushsiz
                          ;}
                          
                        Else
                          
                          ; sinon, on dessine directement sur le sprite qu'on va afficher ensuite
                          If StartDrawing(SpriteOutput(Layer(LayerId)\Sprite))
                            
                            IE_TypeDrawing() ; le drawingmode (alphablend, clip si alphalock, etc..
                            
                            ;{ calcul de position x et y / et on capture le premier point
                            zoum.d = 100
                            zoum = 100/OptionsIE\zoom
                            
                            xx = (mx - canvasX)*zoum -Brush\CenterX 
                            yy = (My - canvasY)*zoum -brush\CenterY 
                            
                            If StartDrawingOnImage = 0
                              StartDrawingOnImage = 1
                              StartX1 = xx
                              StartY1 = yy
                            EndIf
                            
                            ;}
                            
                            DoPaint(xx,yy)
                            
                            StopDrawing()
                          EndIf
                          
                        EndIf
                        
                        
                      EndIf
                    
                    Else ; on n'utilise pas de trait, mais que des points
                      
                      CheckAlpha()
                      
                      If clear = 0
                        
                        RotateSprite(#Sp_BrushCopy, Random(brush\randRot),1)
                        DisplayTransparentSprite(#Sp_BrushCopy,xx,yy,alpha,Color) 
                        
                      Else
                        
                        If StartDrawing(SpriteOutput(Layer(LayerId)\Sprite))
                         ; DrawingMode(#PB_2DDrawing_AlphaBlend)
                          
                          If brush\Action = #Action_Eraser
                            DrawingMode(#PB_2DDrawing_CustomFilter)
                            CustomFilterCallback(@Filtre_MelangeAlpha2())  
                          Else                            
                            DrawingMode(#PB_2DDrawing_AlphaBlend)
                          EndIf
                          
                          zoum.d = 100
                          zoum = 100/OptionsIE\zoom
                          Scx.d = Rnd(Brush\scatter)* Brush\size * 0.01
                          Scy.d = Rnd(Brush\scatter)* Brush\size * 0.01
                          xx = (mx - canvasX + Scx)*zoum -Brush\CenterX + scx
                          yy = (My - canvasY + Scy)*zoum -brush\CenterY + scy
                          
                          If brush\randRot > 0
                            RotImg = RotateImageEx2(ImageID(#BrushCopy),Random(brush\randRot))                      
                            xx + Brush\centerX -ImageWidth(RotImg)/2 
                            yy + Brush\centerY -ImageHeight(RotImg)/2 
                            DrawAlphaImage(ImageID(RotImg),xx,yy,alpha)
                            FreeImage(RotImg)
                          Else                          
                            DrawAlphaImage(ImageID(#BrushCopy),xx,yy,alpha)
                          EndIf  
                          
                          StopDrawing() 
                          
                        EndIf
                        
                      EndIf
                      
                    EndIf
                    
                    
                    
                    
                    ;*****************  puis on dessine sur l'image active
                    v = 0                    
                    If StartDrawing(ImageOutput(Layer(LayerId)\Image))
                      
                      ;                       If brush\Action = #Action_Eraser
                      ;                         DrawingMode(#PB_2DDrawing_CustomFilter)                        
                      ;                         CustomFilterCallback(@Filtre_MelangeAlpha2())  
                      ;                       Else
                      ;                         If Layer(layerId)\LockAlpha = 0
                      ;                           DrawingMode(#PB_2DDrawing_AlphaBlend)
                      ;                         Else
                      ;                           DrawingMode(#PB_2DDrawing_AlphaClip)
                      ;                         EndIf                            
                      ;                       EndIf
                      
                      
                      IE_TypeDrawing()
                      
                      
                      ;{ calcul position et capture du premier point
                      zoum.d = 100
                      zoum = 100/OptionsIE\zoom
                      xx = (mx - canvasX)*zoum -Brush\CenterX 
                      yy = (My - canvasY)*zoum -brush\CenterY
                      
                      ; calcul alpha
                      ; alpha = Brush\AlphaRand*Random(brush\alpha,brush\AlphaMin) + (1-Brush\AlphaRand)*brush\alpha
                      
                      
                      If StartDrawingOnImage = 0
                        StartDrawingOnImage = 1
                        StartX1 = xx
                        StartY1 = yy
                      EndIf
                      ;}
                      
                      If Brush\Trait
                        dist  = point_distance(xx,yy,StartX1,StartY1) ; to find the distance between two brush dots
                        d.d   = point_direction(xx,yy,StartX1,StartY1); to find the direction between the two brush dots
                        sinD.d = Sin(d)                
                        cosD.d = Cos(d)
                        
                        ;{ utile ? Déjà calculé plus haut
                        ; pour la pression tablet, à finir
                        ; b = (size/2+1) * Brush\Pas*0.01
;                         b = Brush\size * Brush\Pas*0.01
;                         brushsiz.d = Brush\size * size/20 +1
;                         If brushsiz_old.d <= 0
;                           brushsiz_old = brushsiz
;                         EndIf
;                         
                        ;FinalSize = (brushsiz_old+newsiz*v)/2             
                        ;}
                        
                        For u = 0 To dist-1
                          
                          Scx.d = Rnd(Brush\scatter)* Brush\size * 0.01
                          Scy.d = Rnd(Brush\scatter)* Brush\size * 0.01
                          
                          x_result =  sinD * u + xx + scx
                          y_result =  cosD * u + yy + scy
                          CheckAlpha()
                          
                          ;{ on dessine les points
                          If brush\Sizepressure And finalsize >0
                            
                            If brush\randRot > 0
                                
                                RotImg = RotateImageEx2(ImageID(#BrushCopy),Random(brush\randRot))  
                                ;If brush\Sizepressure And FinalSize >0
                                  ResizeImage(RotImg,ImageWidth(RotImg)*FinalSize, ImageHeight(RotImg)*FinalSize,1 - Brush\Smooth)
                                ;EndIf
                                x_result + Brush\centerX -ImageWidth(RotImg)/2 
                                y_result + Brush\centerY -ImageHeight(RotImg)/2
                                DrawAlphaImage(ImageID(RotImg),x_result,y_result,alpha)
                                DrawSymetry(RotImg,x_result,y_result,alpha)
                                FreeImage(RotImg)
                              Else
                                ;If brush\Sizepressure And FinalSize > 0
                                  RotImg= CopyImage(#BrushCopy,#PB_Any)
                                  ResizeImage(RotImg,ImageWidth(#BrushCopy)*FinalSize, ImageHeight(#BrushCopy)*FinalSize,1 - Brush\Smooth)
                                  x_result + Brush\centerX -ImageWidth(RotImg)/2 
                                  y_result + Brush\centerY -ImageHeight(RotImg)/2
                                
                                  DrawAlphaImage(ImageID(RotImg),x_result,y_result,alpha)
                                  DrawSymetry(RotImg,x_result,y_result,alpha)
                                  FreeImage(RotImg)
                                ;Else
                                  ;DrawAlphaImage(ImageID(#BrushCopy),x_result,y_result,alpha)
                                ;EndIf
                              
                              EndIf
                              
                          Else
                            
                            If brush\randRot > 0
                              
                              RotImg = RotateImageEx2(ImageID(#BrushCopy),Random(brush\randRot))                      
                              
                              x_result + Brush\centerX -ImageWidth(RotImg)/2
                              y_result + Brush\centerY -ImageHeight(RotImg)/2
                              
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
                        
                        Scx.d = Rnd(Brush\scatter)* Brush\size * 0.01
                        Scy.d = Rnd(Brush\scatter)* Brush\size * 0.01
                        
                        CheckAlpha()
                        
                        If brush\randRot > 0
                          RotImg = RotateImageEx2(ImageID(#BrushCopy),Random(brush\randRot)) 
                          xx + Brush\centerX -ImageWidth(RotImg)/2 + Scx
                          yy + Brush\centerY -ImageHeight(RotImg)/2 + Scy
                          DrawAlphaImage(ImageID(RotImg),xx,yx,alpha)
                          FreeImage(RotImg)
                        Else
                          DrawAlphaImage(ImageID(#BrushCopy),xx+scx,yy+scy,alpha)
                        EndIf  
                        
                      EndIf
                      
                      StopDrawing()
                    EndIf
                    
                    
                    
                  EndIf
                  
                    ; on affiche l'écran (nécessaire ?)
                    If clear = 1                 
                      ;  ScreenUpdate() 
                    EndIf
                    
                    If brush\Action = #Action_Eraser                      
                      ;NewPainting = 1
                      ;ScreenUpdate(0)
                    EndIf
                    
                  EndIf         
                  
                EndIf  
                
                
              Else ; on prend la couleur (alt + clic)
                
                ;{ on prend la couleur (alt + clic)
                ; If StartDrawing(ImageOutput(Layer(LayerId)\Image))
                ClearScreen(RGB(120,120,120))                    
                ; Puis on affiche le fond (paper)          
                PaperDraw()                    
                ; on affiche les calques du dessous
                For i = 0 To ArraySize(layer())-1
                  If layer(i)\view 
                    Layer_Draw(i)
                  EndIf
                Next i 
               
                ; puis, on chope la couleur
                If StartDrawing(ScreenOutput())
                  DrawingMode(#PB_2DDrawing_AlphaBlend)
                  GetColor(mx,my)
                  StopDrawing()
                EndIf
                BrushUpdateColor()
                ; ScreenUpdate() 
                
                
                ; Puis, on réaffiche, ben oui
                If clear
                  ClearScreen(RGB(120,120,120))                  
                  ; Puis on affiche le fond (paper)          
                  PaperDraw()                  
                  ; on affiche les calques du dessous
                  For i = 0 To ArraySize(layer())-1
                    If layer(i)\ordre <= layer(layerId)\ordre
                      If layer(i)\view 
                        Layer_Draw(i)
                      EndIf
                    EndIf
                  Next i 
                EndIf
                ;}
                
                
              EndIf
              
              ;}
              
             ;{ --------------  autres outils de dessin: fill, gradient, box, circle...
              
            Case #Action_Fill ; bug PB avec bordure en rgb(0,0,0)              
              ;{ fillarea
              
              If clic = 0
                clic = 1
                newpainting = 1              
                IE_DrawBegin()  
                
                FillArea(mx, my, -1, brush\Color)
                
                IE_DrawEnd()  
                
                ScreenUpdate(1)
              EndIf  
              ;}
              
              
            Case #Action_Gradient
              
              
            Case #Action_Box              
               ;{ Box - bugued
              If StartDrawingOnImage = 0
                StartDrawingOnImage =1
                startx = mx 
                startY = my 
              EndIf
              NewPainting = 1
              
              IE_DrawBegin()  
              
              If brush\Type = #ToolType_Shape
                
                ; DrawAlphaImage(ImageID(#IMAGE_Content), 0, 0)
                
              EndIf
              
              ;{ taille de la box - rx et ry
              rx = mx - StartX 
              ry = my - StartY 
              
              If shift
                ry = rx
              EndIf
              
              ;}
              
              ;{ box plain, avec bord...
              If brush\ShapePlain  
                If brush\ShapeType = 0
                  Box(StartX, StartY, rx, ry, RGBA(Red(brush\Color),Green(brush\Color),Blue(brush\Color),brush\alpha)) 
                Else
                  RoundBox(StartX, StartY, rx, ry, Brush\RoundX, Brush\RoundY, RGBA(Red(brush\Color),Green(brush\Color),Blue(brush\Color),brush\alpha)) 
                EndIf                  
              EndIf
              
              StopDrawing()
              
              cx = rx*2 + brush\ShapeOutSize*4
              cy = ry*2 + brush\ShapeOutSize*4
              
              If cx <> 0
                If cy<> 0
                  
                  temp = CreateImage(#PB_Any, Abs(cx), Abs(cy), 32, #PB_Image_Transparent)
                  If StartDrawing(ImageOutput(temp))
                    If brush\ShapeOutline 
                      
                      If brush\ShapeType = 0
                        DrawingMode(#PB_2DDrawing_AlphaBlend)
                        Box(0, 0, Abs(rx), Abs(ry), brush\ColorFG)
                        DrawingMode(#PB_2DDrawing_AlphaChannel) 
                        dx = Abs(rx) - brush\ShapeOutSize*2                        
                        dy = Abs(ry) - brush\ShapeOutSize*2                                                
                        Box(brush\ShapeOutSize, brush\ShapeOutSize, dx , dy, RGBA(0, 0, 0, 0))
                      Else
                        DrawingMode(#PB_2DDrawing_AlphaBlend)
                        RoundBox(0, 0, Abs(rx), Abs(ry), Brush\RoundX, Brush\RoundY, brush\ColorFG)
                        DrawingMode(#PB_2DDrawing_AlphaChannel) 
                        dx = Abs(rx) - brush\ShapeOutSize*2                        
                        dy = Abs(ry) - brush\ShapeOutSize*2                                                
                        RoundBox(brush\ShapeOutSize, brush\ShapeOutSize, dx , dy, Brush\RoundX, Brush\RoundY, RGBA(0, 0, 0, 0))
                      EndIf
                      
                    EndIf 
                    StopDrawing()
                  EndIf
                  
                  If StartDrawing(ImageOutput(layer(LayerID)\Image))                  
                    If rx >= 0
                      If ry >= 0                  
                        DrawAlphaImage(ImageID(temp), StartX, StartY)                       
                      Else                               
                        DrawAlphaImage(ImageID(temp), StartX, StartY - Abs(ry))                       
                      EndIf
                    Else
                      If ry >= 0                  
                        DrawAlphaImage(ImageID(temp), StartX - Abs(rx), StartY)                       
                      Else                               
                        DrawAlphaImage(ImageID(temp), StartX - Abs(rx), StartY - Abs(ry))                       
                      EndIf
                    EndIf           
                  EndIf
                  
                  FreeImage(temp)
                EndIf
              EndIf
              ;}
              
              IE_DrawEnd()
              ScreenUpdate(1)
              ;}
              
              
            Case #Action_Circle
                            
              ;}
              
              
          EndSelect
          
          
          
        ;{ on affiche les calques du dessus
        If clear = 1 ; 0
          For i = 0 To ArraySize(layer())-1
            If layer(i)\ordre > layer(layerId)\ordre
              If layer(i)\view 
                 Layer_Draw(i)
              EndIf
            EndIf
          Next i 
        EndIf
          
;           If my <> OldMx Or My <> OldMy
;             ;RotateSprite(OptionsIE\CursorSpriteId,Random(brush\RandRot),0)
;             SpriteBlendingMode(5,3)
;             OPtionsIE\cursorX = 0
;             ZoomSprite(OptionsIE\CursorSpriteId,OptionsIE\CursorW * Z, OptionsIE\CursorH * z)
;             DisplayTransparentSprite(OptionsIE\CursorSpriteId,mx-(OptionsIE\CurSorW/2)*z,my-(OptionsIE\CursorH/2)*z,100)
;             SpriteBlendingMode(0,8)
;             
;             OldMx = Mx
;             OldMY = My
;             
;           EndIf

          ;}
         
          
          
        Else ; action autre que dessiner : bouger, transform, pipette
        
          Select Brush\Action
              
            Case #Action_Pipette             
              If StartDrawing(ScreenOutput())
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                GetColor(mx,my)
                StopDrawing()
              EndIf
              BrushUpdateColor()
              
            Case #Action_Move
              If layer(LayerID)\locked = 0 And layer(LayerID)\view = 1
                If Clic = 0
                  oldposx = mx/z - layer(layerid)\x
                  oldposy = my/z - layer(layerid)\y
                  Clic = 1
                EndIf
                ActionKeyb = 0
                MoveLayerX = 0
                MoveLayerY = 0
                Layer(layerId)\x = mx/z - oldposx 
                Layer(layerId)\y = my/z - oldposy
                ScreenUpdate()
              EndIf
              
            Case #Action_Transform              
              If layer(LayerID)\locked = 0 And layer(LayerID)\view = 1
                If clic = 0
                  StartX = Mx/z - Layer(LayerID)\W
                  StartY = My/z - Layer(LayerID)\H
                  clic=1                  
                EndIf                
                Layer(LayerId)\selected = 1
                Layer(layerId)\W = Mx/z -StartX ; - CanvasX
                If shift = 1
                  ratio.d = Layer(LayerID)\NewH/Layer(LayerID)\NewW
                  Layer(layerId)\H = Layer(layerId)\W*ratio
                Else                  
                  Layer(layerId)\H = My/z -startY ; - CanvasY 
                EndIf                
                ScreenUpdate()
              EndIf
              
              
            ;Case #Action_Zoom 
              
              
          EndSelect
          
        EndIf
        
        ;}
         
          
      EndIf
      
      
      FlipBuffers() ; on affiche l'ecran


    Else ; on ne clique pas sur le screen
      
      
      ;{ on a levé notre souris, on ne dessine plus
      If MoveCanvas = 2 ; on bouge le canvas
        MoveCanvas =1
      EndIf 
      
      If clear = 0
        If clic = 1
          newpainting= 1
          ScreenUpdate(1)          
        EndIf
      Else
        ScreenUpdate() 
      EndIf
           
;       If Paint = 1
;         Paint = 0
;         Debug "on a peint !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
;         
;         ; ScreenUpdate() 
;       EndIf
      Brush\ViscoCur = 0
      
      Clic = 0
      Pression = 0
      StartDrawingOnImage = 0
      ;}
      
    EndIf
    
    ;}
    
    
  Else 
    
    ;{ on n'est pas sur le screen, on libère la souris pour pouvoir utiliser les gadgets      
    If inscreen = 1
      inscreen = 0
      ;ReleaseMouse(1) ; mac, linux ?
      FlipBuffers()
    EndIf
    ;}
    
  EndIf
  
  ;}
      
  ;{ Keyboard
  ExamineKeyboard()
  If KeyboardPushed(#PB_Key_LeftControl)
    Control = 1
  EndIf
  If KeyboardReleased(#PB_Key_LeftControl)
    Control = 0
  EndIf
  If KeyboardPushed(#PB_Key_LeftAlt)
    Alt = 1
  EndIf
  If KeyboardReleased(#PB_Key_LeftAlt)
    Alt = 0
  EndIf
  If KeyboardPushed(#PB_Key_LeftShift)
    Shift = 1
  EndIf
  If KeyboardReleased(#PB_Key_LeftShift)
    Shift = 0
  EndIf
  
  If Control = 1
    If KeyboardPushed(#PB_Key_Subtract) ; zoom -
      If KeyZoom = 0
        KeyZoom = 1
        If OptionsIE\zoom> 10
          OptionsIE\zoom=OptionsIE\zoom -10
          ScreenZoom()
        EndIf
      EndIf
    ElseIf KeyboardPushed(#PB_Key_Add) ; zoom+
      If KeyZoom = 0
        KeyZoom = 1
        If OptionsIE\zoom< 5000
          OptionsIE\zoom=OptionsIE\zoom +10
          ScreenZoom()
        EndIf
      EndIf
    EndIf
    If KeyboardReleased(#PB_Key_Subtract) Or KeyboardReleased(#PB_Key_Add)
      KeyZoom = 0
    EndIf
    If KeyboardPushed(#PB_Key_T) ; transform
      If key = 0
        key = 1
        UpdateTool(#G_IE_Transform) 
      EndIf
    EndIf

  Else
    
    If alt = 0 And shift = 0
      
      ; move the canvas
      If KeyboardPushed(#PB_Key_Space)
        If MoveCanvas = 0
          MoveCanvas = 1
        EndIf      
      EndIf
      If KeyboardReleased(#PB_Key_Space)
        MoveCanvas = 0 
        MouseClic = 0
      EndIf
      
      
      If KeyboardPushed(#PB_Key_Left)
        If key > 0
          key -1
        Else
          If Brush\Action = #Action_Move         
            If layer(LayerID)\locked = 0 And layer(LayerID)\view = 1
              MoveLayerX -1
              If ActionKeyb = 0
                oldposx = layer(layerid)\x
                oldposy = layer(layerid)\y
                ActionKeyb = 1
              EndIf              
              Layer(layerId)\x = oldposx + MoveLayerX
              Layer(layerId)\y = oldposy + MoveLayerY
              ScreenUpdate()
            EndIf
            key = 5
          EndIf 
        EndIf
      EndIf
      If KeyboardPushed(#PB_Key_Right)
        If key > 0
          key -1
        Else
          If Brush\Action = #Action_Move  
            If layer(LayerID)\locked = 0 And layer(LayerID)\view = 1
              MoveLayerX +1
              If ActionKeyb = 0
                oldposx = layer(layerid)\x
                oldposy = layer(layerid)\y
                ActionKeyb = 1
              EndIf             
              Layer(layerId)\x = oldposx + MoveLayerX
              Layer(layerId)\y = oldposy + MoveLayerY
              ScreenUpdate()
            EndIf            
            key = 5
          EndIf 
        EndIf        
      EndIf
      If KeyboardPushed(#PB_Key_Up)
        If key > 0
          key -1
        Else
          If Brush\Action = #Action_Move          
            If layer(LayerID)\locked = 0 And layer(LayerID)\view = 1
              MoveLayerY-1
              If ActionKeyb = 0
                oldposx = layer(layerid)\x
                oldposy = layer(layerid)\y
                ActionKeyb = 1
              EndIf              
              Layer(layerId)\x = oldposx + MoveLayerX
              Layer(layerId)\y = oldposy + MoveLayerY
              ScreenUpdate()
            EndIf  
            key = 5
          EndIf 
        EndIf        
      EndIf
      If KeyboardPushed(#PB_Key_Down)
        If key > 0
          key -1
        Else
          If Brush\Action = #Action_Move          
            If layer(LayerID)\locked = 0 And layer(LayerID)\view = 1
              MoveLayerY+1
              If ActionKeyb = 0
                oldposx = layer(layerid)\x
                oldposy = layer(layerid)\y
                ActionKeyb = 1
              EndIf              
              Layer(layerId)\x = oldposx + MoveLayerX
              Layer(layerId)\y = oldposy + MoveLayerY
              ScreenUpdate()
            EndIf  
            key = 5
          EndIf 
        EndIf        
      EndIf
      
      ; raccourci outil
      If KeyboardPushed(#PB_Key_B)
        If key = 0
          key = 1
          UpdateTool(#G_IE_Brush) 
        EndIf
      EndIf
      If KeyboardPushed(#PB_Key_E)
        If key = 0
          key = 1
          UpdateTool(#G_IE_Eraser) 
        EndIf
      EndIf
      If KeyboardPushed(#PB_Key_K)
        If key = 0
          key = 1
          UpdateTool(#G_IE_Fill) 
       EndIf
      EndIf
      If KeyboardPushed(#PB_Key_G)
        If key = 0
          key = 1
          UpdateTool(#G_IE_Gradient) 
        EndIf
      EndIf
      If KeyboardPushed(#PB_Key_H)
        If key = 0
          key = 1
          UpdateTool(#G_IE_Hand) 
        EndIf
      EndIf      
      If KeyboardPushed(#PB_Key_Z)
        If key = 0
          key = 1
          UpdateTool(#G_IE_Zoom) 
        EndIf      
      EndIf 
      If KeyboardPushed(#PB_Key_V) ;move the layer
        MoveLayerY = 0
        MoveLayerX = 0
        If key = 0
          key = 1
          UpdateTool(#G_IE_Move) 
        EndIf
      EndIf
            
      ; raccourcis brush
      If KeyboardPushed(#PB_Key_D)
        If brush\size > 1
          If brush\size >= 100
            Brush\size -5         
          ElseIf brush\size < 100 And brush\size > 20
            brush\size - 2          
          Else
            brush\size-1          
          EndIf
          BrushUpdateImage(0,1) 
          BrushUpdateColor() 
          SetGadgetState(#G_BrushSize,brush\size)
        EndIf
      EndIf
      If KeyboardPushed(#PB_Key_F)
        If brush\size < 1000 
          If brush\size >=100
            Brush\size +5          
          ElseIf brush\size < 100 And brush\size > 20
            brush\size + 2            
          Else
            brush\size+1            
          EndIf
          BrushUpdateImage(0,1)
          BrushUpdateColor()     
          SetGadgetState(#G_BrushSize,brush\size)
        EndIf        
      EndIf
      
    EndIf
    
  EndIf
  
  If KeyboardReleased(#PB_Key_All)
    key = 0
  EndIf
  ;}
  
  
  FPS()

  
Until quit = 1

;{ on ferme l'application
If tablet
  WTClose(hCtx)
  CloseLibrary(0)
EndIf

If OptionsIE\autosave
  ExportImage(1)
EndIf

SaveOptions()
CloseScreen()
End
;}


; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 1167
; FirstLine = 119
; Folding = NAAEQGjAMiAA53gx8AUgQBjAhHR5BAABCGABI9evHAQh5
; EnableUnicode
; EnableXP
; DisableDebugger