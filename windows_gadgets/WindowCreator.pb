;{ infos

; Nom : WindowMaker
; Date : 22/09/2013
; Dev : blendman
; PB Version : 5.20 LTS, 5.42+
; OS : tous / All 

; A revoir : 
; - utiliser un canvas pour dessiner, modifier, etc... les gadgets
; - pour tester la fenêtre il faudrait faire : menu\tester la fenêtre

; Modification : 
; [14/04/2016] (0.10)
; - On peut désormais redimensionner la fenêtre dynamiquement
; - ajout des gadgets (propriétés du gadget ajouté dans la nouvelle fenêtre) dans le panel gadget
; - on peut ajouter des gadgets, ça s'actualise dans la fenêtre
; - on peut modifier le gadget sélectionné
; - on peut Supprimer le gadget sélectionné

; [02/10/2013] (0.05)
; - ajout d'un canvas pour tester la création de fenêtre avec le canvas


; [24/09/2013] (0.02)
; - file new project : crée la nouvelle fenêtre


; [22/09/2013] (0.01)
; - interface général
; - ajout menu



;}

;{ Constantes

Enumeration 
    
    ; windows
    #Win_Main=0
    #Win_New
    
    ;{ menu
    
    ; Files
    #PGC_MenuNew = 0
    #PGC_MenuOpen
    #PGC_MenuSave
    #PGC_MenuExit
    
    ; Edit
    #PGC_Menu
    #WM_TestWindow
    
    ; View
    #PGC_MenuViewCode
    
    ; models
    #PGC_MenuOpenModels
    
    ; help
    #PGC_MenuAbout
    ;}
    
    ;{ gadgets
    #Container_Gadget=0
    #canvas
    
    ; Gadgets
    #Panel_Gadget
    
    #G_GadgetTyp
    #G_AddGadget
    #G_DelGadget
    #G_GadgetX
    #G_GadgetY
    #G_GadgetW
    #G_GadgetH    
    #G_GadgetName
    #G_GadgetTip
    #G_GadgetText
    #G_GadgetMin
    #G_GadgetMax
    #G_GadgetOption1
    #G_GadgetImg
    
    
    
    
    ; Models
    #Bt_SimpleMenu
    #Bt_Simple
    
    
    ; Properties
    #Panel_Properties
    
    ; Window properties
    #Spin_WinW
    #Spin_WinH 
    #SG_WinName
    
    #CB_WinMaxGadget
    #CB_WinMinGadget
    #CB_WinMaximise
    #CB_WinSizeGadget
    #CB_WinScreenCentered
    ;}
    
    ;{ Type de gadgets
    #Gad_Btn    =0
    #Gad_BtnImg
    #Gad_Canvas
    #Gad_Chkbox
    #Gad_Cbbox
    #Gad_FrameG
    #Gad_ListV
    #Gad_ListIcon
    #Gad_Spin    
    #Gad_String    
    #Gad_Text
    #Gad_Panel
    ;}
    
EndEnumeration

;}

;{ structures

Structure sGadget
    
    x.w
    y.w
    w.w
    h.w
    typ.a
    Nom$
    
    Id.i
    Pb_any.a
    
    Txt$
    ToolTip$
    Value.i
    
    Img.i
    ; spin
    Min.i
    Max.i
    
EndStructure

; the window we create
Structure WM_Window_s
    
    Name$
    Width.w
    Height.w
    X.w
    Y.w
    
    ; Flags
    SizeGadget.a
    Maximize.a
    MaximizeGadget.a
    MinimizeGadget.a
    Screencentered.a
    SystemMenu.a
    
    ; gadgets in the window
    Array Gadget.sGadget(0)
    
EndStructure
Global WM_Window.WM_Window_s

; Options
Structure WM_Options_s
    
    PanelGadgetW.w
    
EndStructure
Global WM_Options.WM_Options_s


Global GadgetId.i
GadgetId = -1
;}

;{ Procédures

Macro DeleteArrayElement(ar, el)
    
    For a=el To ArraySize(ar())-1
        ar(a) = ar(a+1)
    Next
    
    a = 0
    If ArraySize(ar())-1>=0
        a = ArraySize(ar())-1    
    EndIf
    ReDim ar(a)
    
EndMacro


;{ UI

Procedure AddGadget(id,typ,x,y,w,h,txt$="",min=0,max=0,tip$="",val=-65257)
    
    ; pour ajouter plus facilement un gadget
    
    If txt$ <> "" 
        Select typ 
            Case #Gad_String, #Gad_Spin  
                w1 = 35
                If TextGadget(#PB_Any,x,y+2,w1,h,txt$) : EndIf    
                ;w1
        EndSelect
    EndIf
    
    Select typ
        Case #Gad_spin
            id1= SpinGadget(id, x+w1,y,w,h,min,max,#PB_Spin_Numeric) 
            
            
        Case #Gad_String
            If min = 1
                id1 = StringGadget(id, x+w1,y,w,h,txt$,#PB_String_Numeric) 
            Else
                id1 = StringGadget(id, x+w1,y,w,h,txt$)                 
            EndIf
            
        Case #Gad_Btn
            If min = 1
                id1= ButtonGadget(id,x+w1,y,w,h,txt$,#PB_Button_Toggle)      
            Else
                id1= ButtonGadget(id,x+w1,y,w,h,txt$)    
            EndIf
            
        Case #Gad_Panel
            id1= PanelGadget(id,x+w1,y,w,h)
            If id1 
                CloseGadgetList()
            EndIf
            
            
        Case #Gad_BtnImg
            If min = 1
                id1= ButtonImageGadget(id,x+w1,y,w,h,ImageID(max),#PB_Button_Toggle)  
            Else
                id1= ButtonImageGadget(id,x+w1,y,w,h,ImageID(max))      
            EndIf
            
        Case #Gad_Chkbox
            id1= CheckBoxGadget(id,x+w1,y,w,h,txt$)     
            
        Case #Gad_Cbbox
            id1= ComboBoxGadget(id,x+w1,y,w,h)     
                 
        Case #Gad_ListV
            id1= ListViewGadget(id,x+w1,y,w,h)     
            
            
    EndSelect
    
    If id = #PB_Any
        id = id1
    EndIf
    
    If tip$ <> ""        
        If IsGadget(id)
            GadgetToolTip(id,tip$)
        EndIf
    EndIf
    
    If val <> -65257
        SetGadgetState(id,val)
    EndIf
    
    ProcedureReturn id1
EndProcedure


Procedure WM_Reset()
    
    ; reset the program with default parameters
    
    SetWindowColor(0,RGB(120,120,120))
    
    With WM_Options
        
        \PanelGadgetW = 210
        
    EndWith
    
    With WM_Window
        
        \Width      = 600
        \Height     = 400
        \SystemMenu = 1
        
    EndWith
    
EndProcedure
;}


Procedure WM_CreateWindow(F=0)
    
    Flag = F
    
    If OpenWindow(#Win_New,WindowX(#Win_Main) + 220,WindowY(#Win_Main) + 80, WM_Window\Width, WM_Window\Height,  WM_Window\Name$, Flag,WindowID(#Win_Main))           
        ; DisableWindow(#Win_New, 1)
        SetGadgetState(#Spin_WinW, WM_Window\Width)
        SetGadgetState(#Spin_WinH, WM_Window\Height)
        ; SetActiveWindow(#Win_Main)
        
        If ArraySize(WM_Window\Gadget())>0
            For i = 0 To ArraySize(WM_Window\Gadget())-1
                With WM_Window\Gadget(i)
                    gadgetId = i
                    \Id =AddGadget(#PB_Any,\typ,\x,\y,\w,\h,\txt$,\min,\max,\ToolTip$)  
                EndWith                
            Next
        EndIf
        
    EndIf
    
EndProcedure

Procedure WM_SizeWindow()
    
    If IsWindow(#Win_New) And EventWindow() = #win_new       
        SetGadgetState(#Spin_WinW,WindowWidth(#Win_New))    
        SetGadgetState(#Spin_WinH,WindowHeight(#Win_New))
        With  WM_Window
            \Width = WindowWidth(#Win_New)
            \height = WindowHeight(#Win_New)
            \X = WindowX(#Win_New)
            \Y = WindowY(#Win_New)
        EndWith
    EndIf                    
                
EndProcedure


Procedure WM_EventMenu()
    
    If EventWindow() = #Win_Main
        
        Select EventMenu()
                
            Case #PGC_MenuNew               
                WM_CreateWindow(#PB_Window_SystemMenu)

           Case #PGC_MenuExit
                End

        EndSelect
        
    EndIf

EndProcedure



Procedure WM_CreateGadget()
     
    ; first, we get the info
    x = GetGadgetState(#G_GadgetX)
    y = GetGadgetState(#G_GadgetY)
    h = GetGadgetState(#G_GadgetH)    
    w = GetGadgetState(#G_GadgetW)
    min = GetGadgetState(#G_GadgetMin)
    max = GetGadgetState(#G_GadgetMax)
    name$ = GetGadgetText(#G_GadgetName)
    typ = GetGadgetState(#G_GadgetTyp)
    tip$ = GetGadgetText(#G_GadgetTip)
    txt$ = GetGadgetText(#G_GadgetText)
    ;val = GetGadgetState(#G_GadgetOption1)
    
    ; create the gadget
    n =ArraySize(WM_Window\Gadget())
    
    With WM_Window\Gadget(n)
        \x = x
        \y = y
        \h = h
        \w = w
        \Min = min
        \Max = max
        \typ = typ
        \ToolTip$   = tip$
        \Nom$       = name$
        \Txt$       = txt$        
    EndWith
        
    SetActiveWindow(#Win_New)
    WM_Window\Gadget(n)\Id =AddGadget(#PB_Any,typ,x,y,w,h,txt$,min,max,tip$)  
    
    GadgetId = n
    
    ReDim WM_Window\Gadget(n+1)
    
EndProcedure

Procedure WM_UpdateGadget()
    
    If GadgetId > -1
        ; Debug "on met à jour le gadget"
        x = GetGadgetState(#G_GadgetX)
        y = GetGadgetState(#G_GadgetY)
        h = GetGadgetState(#G_GadgetH)    
        w = GetGadgetState(#G_GadgetW)
        min = GetGadgetState(#G_GadgetMin)
        max = GetGadgetState(#G_GadgetMax)
        name$ = GetGadgetText(#G_GadgetName)
        typ = GetGadgetState(#G_GadgetTyp)
        tip$ = GetGadgetText(#G_GadgetTip)
        txt$ = GetGadgetText(#G_GadgetText)
        ;val = GetGadgetState(#G_GadgetOption1)
        
        n = GadgetId
        
        With WM_Window\Gadget(n)
            \x = x
            \y = y
            \h = h
            \w = w
            \Min = min
            \Max = max
            \typ = typ
            \ToolTip$   = tip$
            \Nom$       = name$
            \Txt$       = txt$        
        EndWith
                
        id = WM_Window\Gadget(n)\Id
        
        ResizeGadget(id,x,y,w,h)
        SetGadgetText(id,txt$)
        GadgetToolTip(id,tip$)
        
    EndIf
EndProcedure

Procedure WM_GetGadgetProperties()
    
    ; create the gadget
    For i=0 To ArraySize(WM_Window\Gadget())        
        If WM_Window\Gadget(i)\id = EventGadget()  
            GadgetId = i
            With WM_Window\Gadget(i)                
                SetGadgetState(#G_GadgetX,\x)
                SetGadgetState(#G_GadgetY,\y)
                SetGadgetState(#G_GadgetH,\h)    
                SetGadgetState(#G_GadgetW,\w)
                SetGadgetState(#G_GadgetMin,\Min)
                SetGadgetState(#G_GadgetMax,\Max)
                SetGadgetText(#G_GadgetName,\Nom$)
                SetGadgetState(#G_GadgetTyp,\typ)
                SetGadgetText(#G_GadgetTip,\ToolTip$)
                SetGadgetText(#G_GadgetText,\Txt$)
                ;val = GetGadgetState(#G_GadgetOption1)
            EndWith    
            Break
        EndIf        
    Next 
EndProcedure

Procedure WM_SetGadgetProperties()
   
    WM_UpdateGadget()     
     
EndProcedure

;}

;{ Openwindow

If OpenWindow(#Win_Main, 0, 0, 640, 480, "WindowMaker", 
              #PB_Window_SystemMenu | #PB_Window_ScreenCentered |#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget|#PB_Window_Maximize)
        
    WM_Reset()
    
    ;{ Menu
    If CreateMenu(0, WindowID(#Win_Main))
        
        MenuTitle("File")    
        MenuItem(#PGC_MenuNew,"New Project")
        MenuItem(#PGC_MenuOpen,"Open Project")
        MenuBar()
        MenuItem(#PGC_MenuSave,"Save Project")
        MenuItem(#PGC_MenuSave,"Save Project as...")
        MenuBar()
        MenuItem(#PGC_MenuExit,"Exit")
                
        MenuTitle("Editions")
        MenuItem(#WM_TestWindow,"Test the Window")
        
        MenuTitle("View")
        MenuItem(#PGC_MenuViewCode,"View Code")
                
        MenuTitle("Models")
        MenuItem(#PGC_MenuOpenModels,"Open Models")
                
        MenuTitle("Help")
        MenuItem(#PGC_MenuAbout,"About")
        
    EndIf
    ;}
    
    ;{ Status bar
    CreateStatusBar(0, WindowID(#Win_Main))
    ;}
    
    ;{ Gadgets
    
    If ContainerGadget(#Container_Gadget, 0, 0, WM_Options\PanelGadgetW, WindowHeight(0) - MenuHeight() - StatusBarHeight(0), #PB_Container_Single)
        
        If PanelGadget(#Panel_Gadget,0,5,200,300)
            
            AddGadgetItem(#Panel_Gadget,-1,"Gadgets")
                        
            x1 = 10 : y1 = 10
            a = 3 : b = 5 : c = 2
            w1 = 100 : w2 = 30 : w3 = 50 : w4 = 60 : w5 = 20 : w6 = 80 : w7=45 : w8=40 :w9 = 120
            h1 = 20 : h2 = 25

            AddGadget(#G_GadgetTyp,#Gad_Cbbox,x1,y1,w9-5,h1) : x1+w9
            ; be careful, the order is the same as the #Gad_ type :
            T$ = "Button,Button Image,Canvas,Checkbox,Combobox,Frame,List view,List icon,Spin,String,Text"
            For i=0 To CountString(t$,",")
                AddGadgetItem(#G_GadgetTyp,i,StringField(t$,i+1,",") )
            Next
                        
            AddGadget(#G_AddGadget,#Gad_Btn,x1,y1,w5,h1,"+",0,0,"Add Gadget") :  x1+w5+a
            AddGadget(#G_DelGadget,#Gad_Btn,x1,y1,w5,h1,"-",0,0,"delete current Gadget") : y1 + h1 +a : x1 = 10
                        
            AddGadget(#G_GadgetName,#Gad_String,x1,y1,w6,h1,"Name",0,0,"Gadget Name") : y1 + h1 +a
            SetGadgetText(#G_GadgetName,"")
            AddGadget(#G_GadgetX,#Gad_Spin,x1,y1,w6,h1,"X",-100000,100000,"Gadget X",0) : y1 + h1 +a
            AddGadget(#G_GadgetY,#Gad_Spin,x1,y1,w6,h1,"Y",-100000,100000,"Gadget Y",0) : y1 + h1 +a
            AddGadget(#G_GadgetW,#Gad_Spin,x1,y1,w6,h1,"Width",1,50000,"Gadget Width",60) : y1 + h1 +a
            AddGadget(#G_GadgetH,#Gad_Spin,x1,y1,w6,h1,"Height",1,50000,"Gadget height",20) : y1 + h1 +a
            AddGadget(#G_GadgetMin,#Gad_Spin,x1,y1,w6,h1,"Min",-1000000,1000000,"Min Value for the gadget",0) : y1 + h1 +a
            AddGadget(#G_GadgetMax,#Gad_Spin,x1,y1,w6,h1,"Max",-1000000,1000000,"Max Value for the gadget",0) : y1 + h1 +a
            
            AddGadget(#G_GadgetText,#Gad_String,x1,y1,w6,h1,"Text",0,0,"The text of the gadget") : y1 + h1 +a
            SetGadgetText(#G_GadgetText,"")
            
            AddGadget(#G_GadgetTip,#Gad_String,x1,y1,w6,h1,"Tips",0,0,"The tooltip of the gadget") : y1 + h1 +a
            SetGadgetText(#G_GadgetTip,"")            
            ;   Il manque :#G_GadgetOption1, #G_GadgetImg
                  
                        
            
            AddGadgetItem(#Panel_Gadget,-1,"Menu")
            
            AddGadgetItem(#Panel_Gadget,-1,"Models")
            
            CloseGadgetList()
            
        EndIf
        
        If PanelGadget(#Panel_Properties,0,310,200,WindowHeight(0)-MenuHeight() - 315 - StatusBarHeight(0))
            
            AddGadgetItem(#Panel_Properties,-1,"Window")
            
            yy = 5
            xx =5
            
            SpinGadget(#Spin_WinW, xx, yy, 60, 20, 1, 2000, #PB_Spin_Numeric)
            SpinGadget(#Spin_WinH, 70, yy, 60, 20, 1, 2000, #PB_Spin_Numeric)
            yy + 25
            
            TextGadget(#PB_Any, xx, yy, 40, 20, "Name : ")      
            StringGadget(#SG_WinName, xx+45, yy, 100, 20, "")                        
            yy + 25
            CheckBoxGadget(#CB_WinMaxGadget, xx, yy, 120, 20,   "Maximise Gadget")            
            yy +25
            CheckBoxGadget(#CB_WinMinGadget, xx, yy, 120, 20,   "Minimise Gadget")            
            yy +25
            CheckBoxGadget(#CB_WinMaximise, xx, yy, 120, 20,    "Maximise Window")            
            yy +25
            CheckBoxGadget(#CB_WinSizeGadget, xx, yy, 120, 20,  "Size Gadget")            
            yy +25
            CheckBoxGadget(#CB_WinScreenCentered, xx, yy, 120, 20,  "Screen Centered")
            
            AddGadgetItem(#Panel_Properties,-1,"Properties")
                        
            CloseGadgetList()
            
        EndIf
        
        CloseGadgetList()
        
    EndIf
    
    xx = GadgetX(#Container_Gadget) + GadgetWidth(#Container_Gadget) + 5
    yy = 5
    
    ;If CanvasGadget(#canvas, xx, yy, WM_Window\Width, WM_Window\Height) :   EndIf
    
    BindEvent(#PB_Event_SizeWindow,@WM_SizeWindow())
    BindEvent(#PB_Event_Menu,@WM_EventMenu())
    
    ;}
    
    Repeat
        
        Event       = WaitWindowEvent()
        EventMenu   = EventMenu()
        EventWindow = EventWindow()
        EventGadget = EventGadget()
        EventType   = EventType()
        
        Select Event
                                
            Case #PB_Event_Gadget
                If EventWindow =#Win_New
                    WM_GetGadgetProperties()
                Else
                    WM_SetGadgetProperties()
                EndIf
                                
                Select EventGadget
                        
                    Case #G_DelGadget
                        If gadgetId >-1
                            FreeGadget(WM_Window\Gadget(gadgetId)\Id)
                            DeleteArrayElement(WM_Window\Gadget, gadgetId)
                            gadgetId = 0
                        EndIf
                        
                    Case #G_AddGadget
                        WM_CreateGadget()
                        
                    Case #Spin_WinW, #Spin_WinH
                        If IsWindow(#Win_New)
                            ResizeWindow(#Win_New, #PB_Ignore, #PB_Ignore, GetGadgetState(#Spin_WinW), GetGadgetState(#Spin_WinH))
                        EndIf
                        
                    Case  #CB_WinMaxGadget To #CB_WinScreenCentered  
                        If IsWindow(#Win_New)                             
                            ;CloseWindow(#Win_New)
                            Flag = 0
                            
                            If GetGadgetState(#CB_WinMaxGadget) = 1
                                Flag | #PB_Window_MaximizeGadget                    
                            EndIf
                            
                            If GetGadgetState(#CB_WinMinGadget) = 1
                                Flag | #PB_Window_MinimizeGadget                    
                            EndIf
                            
                            If GetGadgetState(#CB_WinSizeGadget) = 1
                                Flag | #PB_Window_SizeGadget                    
                            EndIf
                            
                            If GetGadgetState(#CB_WinScreenCentered) = 1
                                Flag | #PB_Window_ScreenCentered                    
                            EndIf
                            
                            WM_CreateWindow(#PB_Window_SystemMenu|Flag)
                            
                        EndIf
                                                
                    Case #SG_WinName 
                        If IsWindow(#Win_New)  
                            If EventType =  #PB_EventType_Change                
                                WM_Window\Name$ = GetGadgetText(#SG_WinName)                
                                SetWindowTitle(#Win_New,  WM_Window\Name$)
                                SetActiveGadget(EventGadget)
                            EndIf
                        EndIf
                        
                EndSelect
                
            Case #PB_Event_CloseWindow 
                If EventWindow = #Win_main
                    Quit = 1
                Else 
                    CloseWindow(EventWindow)
                EndIf
                  
        EndSelect
        
    Until Quit = 1
    
EndIf

;}


; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 534
; FirstLine = 19
; Folding = AgQAAAAAMOfA9
; EnableXP