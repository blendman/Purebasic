

; Menu
Procedure AddMenu(clear)
    
  If CreateMenu(#Menu_Main,WindowID(#WinMain))
    
    ;{ menu 
    ; FILE
    MenuTitle(Lang("File"))  
    MenuItem(#menu_New,         Lang("New")+Chr(9)+"Ctrl+N")
    MenuBar()
    MenuItem(#Menu_Open,        Lang("Open")+Chr(9)+"Ctrl+O")
    MenuItem(#Menu_Import,      Lang("Import")+Chr(9)+"Ctrl+I")
    MenuBar()
    MenuItem(#Menu_Save,        Lang("Save")+Chr(9)+"Ctrl+S")
    MenuItem(#Menu_SaveAs,      Lang("Save As")+Chr(9)+"Ctrl+Shift+S")
    OpenSubMenu(Lang("Export"))
    MenuItem(#Menu_SaveImage,   Lang("Save image"))    
    MenuItem(#Menu_ExportAll,   Lang("Export layers (in png)")+Chr(9)+"Ctrl+Alt+E")
    MenuItem(#Menu_ExportAllZip,Lang("Export layers (zip)")+Chr(9)+"Alt+E")
    MenuItem(#Menu_Export,      Lang("Export layer image")+Chr(9)+"Ctrl+E")
    CloseSubMenu()
    MenuBar()
    MenuItem(#Menu_Pref,        Lang("Preferences"))
    MenuBar()
    MenuItem(#Menu_Exit,        Lang("Exit")+Chr(9)+"Escape")
    
    ; EDITIONS
    MenuTitle(Lang("Edit"))
    MenuItem(#Menu_Cut,         Lang("Cut")+Chr(9)+"Ctrl+X")
    MenuItem(#Menu_Copy,        Lang("Copy")+Chr(9)+"Ctrl+C")
    MenuItem(#Menu_Paste,       Lang("Paste")+Chr(9)+"Ctrl+V")
    MenuBar()
    MenuItem(#Menu_clear,       Lang("Clear")+Chr(9)+"Ctrl+W")
    MenuBar()
    OpenSubMenu(Lang("Fill"))
    MenuItem(#Menu_FillAll,      Lang("Fill with BG color")+Chr(9)+"Ctrl+K")
    MenuItem(#Menu_Fill,         Lang("Fill the transparent pixel with BG color"))
    MenuItem(#Menu_FillPatern,   Lang("Fill with pattern"))
    CloseSubMenu()
    
    
    ; VIEW
    MenuTitle(Lang("View"))
    MenuItem(#menu_IE_Grid,       Lang("Grid") + Chr(9) + "Ctrl + G")
    MenuBar()
    MenuItem(#menu_IE_ZoomPlus,   Lang("Zoom +") + Chr(9) + "Ctrl '+'")
    MenuItem(#menu_IE_ZoomMoins,  Lang("Zoom -")+ Chr(9) + "Ctrl '-'")
    OpenSubMenu(Lang("Zoom"))
    MenuItem(#menu_IE_Zoom50,     Lang("Zoom")+" 50%")
    MenuItem(#menu_IE_Zoom100,    Lang("Zoom")+" 100%"+ Chr(9) + "Ctrl + Pad0")
    MenuItem(#menu_IE_Zoom200,    Lang("Zoom")+" 200%")
    MenuItem(#menu_IE_Zoom300,    Lang("Zoom")+" 300%"+ Chr(9) + "Ctrl + Pad3")
    MenuItem(#menu_IE_Zoom400,    Lang("Zoom")+" 400%"+ Chr(9) + "Ctrl + Pad4")
    MenuItem(#menu_IE_Zoom500,    Lang("Zoom")+" 500%")
    MenuItem(#menu_IE_Zoom1000,   Lang("Zoom")+" 1000%")
    CloseSubMenu()
    MenuBar()
    ;OpenSubMenu(Lang("Canvas"))
    ;CloseSubMenu()
    OpenSubMenu(Lang("Screen"))
    MenuItem(#Menu_RealTime,      Lang("Update the screen (Real Time)"))
    SetMenuItemState(0,#Menu_RealTime,Clear)
    MenuItem(#menu_ChangeCenter,  Lang("Change the Center"))
    MenuItem(#menu_ScreenRedraw,  Lang("Refresh the screen"))
    MenuItem(#menu_ScreenQuality, Lang("Screen Filtering"))
    
    CloseSubMenu()
    MenuBar()
    MenuItem(#Menu_ResetCenter,   Lang("Reset view")+ Chr(9) + "Ctrl + Pad1")
    MenuItem(#Menu_CenterView,    Lang("Center view")+ Chr(9) + "Ctrl + Pad5")
    ;MenuBar()
    ;MenuItem(#Menu_CenterView,    Lang("Center view")+ Chr(9) + "Ctrl + Pad5")
    
    MenuTitle(Lang("Selection"))
    MenuItem(#Menu_SelectAll,     Lang("Select all")+Chr(9)+"Ctrl+A")
    MenuItem(#Menu_DeSelect,      Lang("Deselect")+Chr(9)+"Ctrl+D")
    MenuBar()
    ;MenuItem(#Menu_SelExtend,     Lang("Extend"))
    ;MenuItem(#Menu_SelContract,   Lang("Contract"))
    ;MenuItem(#Menu_SelInverse,    Lang("Inverse"))
    ;MenuBar()
;     OpenSubMenu(Lang("Selection"))
;     MenuItem(#Menu_SelectExtend,  Lang("Extend"))
;     CloseSubMenu()

    ; IMAGE
    MenuTitle(Lang("Image")) 
    OpenSubMenu(Lang("Adjustement"))
    MenuItem(#menu_Constrast,     Lang("Brightness/constrast"))
    MenuItem(#menu_Level,         Lang("Level"))
    MenuBar()
    ;MenuItem(#menu_HueSat,         Lang("Hue/Saturation"))
    MenuItem(#menu_ColorBalance,  Lang("Color balance"))
    MenuBar()    
    MenuItem(#menu_InverseColor,  Lang("Inverse Color"))
    MenuItem(#menu_Posterize,     Lang("Posterize"))
    MenuBar()   
    MenuItem(#menu_Desaturation,  Lang("Desaturate"))
    CloseSubMenu()
    MenuBar()    
    MenuItem(#Menu_ResizeDoc,     Lang("Image Size"))
    MenuItem(#Menu_ResizeCanvas,  Lang("Canvas Size"))
    MenuBar()
    MenuItem(#menu_Crop,          Lang("Crop"))
    MenuItem(#menu_Trim,          Lang("Trim"))
    DisableMenuItem(0, #menu_Crop, 0)
    MenuBar()    
    OpenSubMenu(Lang("Rotation"))
    MenuItem(#menu_Rotate90,      Lang("Rotation 90"))
    MenuItem(#menu_Rotate180,     Lang("Rotation 180"))
    MenuItem(#menu_Rotate270,     Lang("Rotation 270"))
    MenuItem(#menu_RotateFree,    Lang("Rotation free"))
    CloseSubMenu()
   
   
    
    ; LAYER
    MenuTitle(Lang("Layer"))
    MenuItem(#Menu_LayerAdd,      Lang("Add a layer"))
    MenuItem(#Menu_LayerDel,      Lang("Delete the layer"))
    MenuBar()
    MenuItem(#Menu_LayerDuplicate,Lang("Duplicate the layer"))
    MenuBar()
    MenuItem(#Menu_LayerMoveDown, Lang("Move layer down"))
    MenuItem(#Menu_LayerMoveUp,   Lang("Move layer up"))
    MenuBar()
    MenuItem(#Menu_LayerMergeDown,Lang("Merge layer down"))
    ; MenuItem(#Menu_LayerMergeAllVisible,"Merge all visible Layer")
    MenuItem(#Menu_LayerMergeAll, Lang("Merge all layers"))
    ; MenuItem(#Menu_LayerMergeLinked,"Merge all Layer")
    MenuBar()
    MenuItem(#Menu_MirorH,        Lang("Flip layer horizontaly"))
    MenuItem(#Menu_MirorV,        Lang("Flip layer verticaly"))
    MenuItem(#Menu_LayerRotate,   Lang("Rotate the layer"))
    
    ; FILTERS
    MenuTitle(Lang("Filters"))
    
    OpenSubMenu(lang("Blur"))
    MenuItem(#Menu_IE_Blur,       Lang("Blur"))
    CloseSubMenu()
    OpenSubMenu(lang("Sharpen"))
    ; MenuItem(#Menu_IE_Sharpen,    Lang("Sharpen"))
    MenuItem(#Menu_IE_SharpenAlpha,    Lang("Sharpen alpha"))
    CloseSubMenu()
    OpenSubMenu(lang("Noise"))
    MenuItem(#menu_IE_Noise,      Lang("Noise"))
    MenuItem(#menu_IE_Clouds,     Lang("Clouds"))
    CloseSubMenu()
    OpenSubMenu(lang("Misc"))
    MenuItem(#menu_IE_Offset,      Lang("Offset"))
    CloseSubMenu()
    

    If plugin = 1
    OpenSubMenu(lang("Plugins"))
    
    If ExamineDirectory(0,"./data/Plugins/Filters/","*.dll")
      While NextDirectoryEntry(0)
        If DirectoryEntryType(0) = #PB_DirectoryEntry_File
          pluginFile.s = DirectoryEntryName(0)
          
          lib = OpenLibrary(#PB_Any,"./data/plugins/Filters/"+pluginFile)
          If lib
            ; OptionsIE\nbPlugins + 1
            AddElement(Ani_Plugins())
            Ani_Plugins()\lib= lib
            
            n =ListSize(Ani_Plugins())
            Ani_Plugins()\menuId= n
            Ani_Plugins()\name$ = RemoveString(pluginFile,".dll")
            
            ; AddElement(*aP\pluginLibrary())
            ; *aP\pluginLibrary() = lib
            MenuItem(#Menu_Last +n , Ani_Plugins()\name$)
          Else
            MessageRequester(Lang("Error"), Lang("Unable To load the dll")+" "+pluginFile)
          EndIf 
          
          
        EndIf
      Wend 
      FinishDirectory(0)
    EndIf 
    
    CloseSubMenu()
    EndIf
    
    
    ; ACTIONS
    MenuTitle(Lang("Actions"))
    MenuItem(#Menu_ActionSave,    Lang("Save action"))
    MenuItem(#Menu_ActionStop,    Lang("Stop action"))
    MenuItem(#Menu_ActionRun,     Lang("Run action"))
    
    ; HELP
    MenuTitle(Lang("Help"))
    MenuItem(#Menu_about,         Lang("About"))
    MenuItem(#Menu_Infos,         Lang("Info"))
    ;}
    
    ;{ shortcuts
    ; file
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_N|#PB_Shortcut_Control,#menu_New)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_O|#PB_Shortcut_Control,#Menu_Open)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_S|#PB_Shortcut_Control,#menu_Save)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_S|#PB_Shortcut_Control|#PB_Shortcut_Shift,#Menu_SaveAs)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_I|#PB_Shortcut_Control,#Menu_Import)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_E|#PB_Shortcut_Control,#Menu_Export)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_E|#PB_Shortcut_Control|#PB_Shortcut_Alt,#Menu_ExportAll)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_E|#PB_Shortcut_Alt,#Menu_ExportAllZip)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_Escape,#menu_Exit)
    
    ; edit
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_C|#PB_Shortcut_Control,#Menu_Copy)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_W|#PB_Shortcut_Control,#menu_Clear)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_X|#PB_Shortcut_Control,#Menu_Cut)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_V|#PB_Shortcut_Control,#Menu_Paste)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_K|#PB_Shortcut_Control,#Menu_FillAll)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_D|#PB_Shortcut_Control,#Menu_DeSelect)
    AddKeyboardShortcut(#WinMain,#PB_Shortcut_A|#PB_Shortcut_Control,#Menu_SelectAll)
    
    ; view
    AddKeyboardShortcut(#WinMain, #PB_Shortcut_G|#PB_Shortcut_Control, #menu_IE_Grid)
    AddKeyboardShortcut(#WinMain, #PB_Shortcut_Pad0|#PB_Shortcut_Control, #menu_IE_Zoom100)
    AddKeyboardShortcut(#WinMain, #PB_Shortcut_Pad5|#PB_Shortcut_Control, #Menu_CenterView)
    AddKeyboardShortcut(#WinMain, #PB_Shortcut_Pad1|#PB_Shortcut_Control, #Menu_ResetCenter)
    AddKeyboardShortcut(#WinMain, #PB_Shortcut_Pad4|#PB_Shortcut_Control, #menu_IE_Zoom400)
    AddKeyboardShortcut(#WinMain, #PB_Shortcut_Pad3|#PB_Shortcut_Control, #menu_IE_Zoom300)
    ;}
    
  EndIf 
  
  
  If CreatePopupMenu(#Menu_Layer) 
    
    MenuItem(#Menu_Layer_Normal,Lang("Layer bitmap"))
    MenuItem(#Menu_Layer_Text,  Lang("Layer text"))
    MenuItem(#Menu_Layer_BG,    Lang("Layer background"))
    MenuItem(#Menu_Layer_Shape, Lang("Layer shape"))
    MenuBar()
    MenuItem(#Menu_Layer_Group, Lang("Layer group"))
    
  EndIf
  

EndProcedure

Procedure AddLogError(error, info$)
  
  LogError$ +info$ + Chr(13)
  Date$ = FormatDate("%yyyy%mm%dd", Date()) 
  thedate$= FormatDate("%yyyy/%mm/%dd(%hh:%ii:%ss)", Date())
  
  If OpenFile(0, "save\logError"+Date$+".txt") 
    WriteStringN(0,  thedate$)
    WriteString(0, LogError$)
    CloseFile(0)
  Else
    If CreateFile(0, "save\logError"+Date$+".txt")
      WriteStringN(0,  thedate$ )
      WriteString(0, LogError$)
      CloseFile(0)
    EndIf
    
  EndIf
  
EndProcedure



;{ File

Procedure.a GetFileExist(filename$)
  
  Directory$ = GetPathPart(filename$)
  name$ = GetFilePart(filename$)
  
   If ExamineDirectory(0, Directory$, "*.*")  
    While NextDirectoryEntry(0)
      If DirectoryEntryType(0) = #PB_DirectoryEntry_File
        If DirectoryEntryName(0) = name$
          ProcedureReturn #True
          Break
        EndIf        
      EndIf
    Wend
    FinishDirectory(0)
  EndIf
  
  
  ProcedureReturn #False
EndProcedure
Procedure ChangeCursor(load=0)
  ; on crée le cursor
  With OptionsIE
    
    FreeImage2(\CursorImgId)
    FreeSprite2(\CursorSpriteId)
    
    \CursorImgId = CopyImage(#BrushOriginal,#PB_Any)
    \CursorW = ImageWidth(#BrushCopy)
    \CursorH = ImageHeight(#BrushCopy)
    ResizeImage(\CursorImgId,\CursorW,\CursorH)
    \CursorSpriteId = CreateSprite(#PB_Any,\CurSorW,\CursorH)
    
    If StartDrawing(SpriteOutput(\CursorSpriteId))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      Box(0,0,\CursorW,\CursorH,RGBA(0,0,0,255))
      DrawAlphaImage(ImageID(\CursorImgId),0,0,50)
      DrawingMode(#PB_2DDrawing_AlphaClip)
      ;DrawImage(ImageID(\CursorImgId),1,1,\CursorW-2,\Cursorh-2)
      StopDrawing()
    EndIf
    
  EndWith

EndProcedure
Procedure InitScreen()
  
  Shared PanelToolsW_IE
  
  ; needed to have the screen centered
  PanelLayerW_IE  = 175
  ScreenX = PanelLayerW_IE +10
  
  If OpenPreferences("Pref.ini")
    
    PreferenceGroup("General")
    
    PanelLayerW_IE  = ReadPreferenceInteger("PanelLayerW", 175)
    ScreenX = PanelLayerW_IE +10
    
    ClosePreferences()
    
  EndIf

EndProcedure

; options
Procedure OpenOptions()
  
  Shared PanelToolsW_IE, PanelToolsH_IE, PanelLayerW_IE, PanelLayerH_IE, BarAnimH_IE 

  If OpenPreferences("Pref.ini")
    
    PreferenceGroup("General")
    
    ;{ options
    
    With OptionsIE
      
      ; theme and color
      \Theme$         = ReadPreferenceString("Theme","data\Themes\Animatoon")
      c = -1; RGB(100,100,100)
      \ThemeColor     = c; ReadPreferenceInteger("ThemeColor",RGB(150,150,150))
      \ThemeGadCol    = c; ReadPreferenceInteger("ThemeColor",RGB(150,150,150))
      \ThemeMenuCol   = c; ReadPreferenceInteger("ThemeColor",RGB(150,150,150))
      \ThemeStaCol    = c; ReadPreferenceInteger("ThemeColor",RGB(150,150,150))
      \ThemeTBCol     = c; ReadPreferenceInteger("ThemeColor",RGB(150,150,150))
      
      ; set the UI color      
      SetWindowColor(#WinMain, OptionsIE\ThemeColor)
      

      ; Options
      \zoom           = ReadPreferenceInteger("Zoom",       100)
      \autosave       = ReadPreferenceInteger("autosave",   1)
      \AutosaveTime   = ReadPreferenceInteger("autosaveTime",   10)
      If \AutosaveTime <= 0
        \AutosaveTime = 1
      EndIf
      
      \Maxundo        = ReadPreferenceInteger("Maxundo",    16)
      If \Maxundo > 32
        \Maxundo = 32
      EndIf
      \SaveImageRT = 1
      
      \SpriteQuality  = ReadPreferenceInteger("Filtering",  1)
      
      ; view
      \Statusbar      = ReadPreferenceInteger("Statusbar",  1)
      
      \Grid           = ReadPreferenceInteger("Grid",       1)
      \GridW          = ReadPreferenceInteger("GridW",      32)
      \GridH          = ReadPreferenceInteger("GridH",      32)
      \GridColor      = ReadPreferenceInteger("GridColor",  0)
      
      
      ; UI
      \AreaBGColor    = ReadPreferenceInteger("AreaBGColor",  RGB(120,120,120))
      PanelLayerW_IE  = ReadPreferenceInteger("PanelLayerW", 150)
      ScreenX = PanelLayerW_IE +10
      PanelLayerH_IE  = ReadPreferenceInteger("PanelLayerH", 400)
      PanelToolsW_IE  = ReadPreferenceInteger("PanelToolsW", 160)
      PanelToolsH_IE  = ReadPreferenceInteger("PanelToolsH", 300)
      
      
      ; optimisation, realtime, fps
      \DelayMax         = ReadPreferenceInteger("DelayMax", 15) 
      \Delay            = \DelayMax
      
      ; toolbar
      \ToolbarH       = ReadPreferenceInteger("ToolbarH",     36)
      \ToolInfoH      = ReadPreferenceInteger("ToolInfoH",    36)
      \ToolbarFileY   = ReadPreferenceInteger("ToolbarFileY",  0)
      \ToolbarFileX   = ReadPreferenceInteger("ToolbarFileX",  -2)
      \ToolbarFile    = ReadPreferenceInteger("ToolbarFile",   1)
      
      \ToolbarToolY   = ReadPreferenceInteger("ToolbarToolY",  36)
      \ToolbarToolX   = ReadPreferenceInteger("ToolbarToolX",  -2)
      \ToolbarTool    = ReadPreferenceInteger("ToolbarTool",    1)
      
      If \ToolbarToolY > 36
        \ToolbarToolY = 36        
      EndIf
      If \ToolbarFileY > 36
        \ToolbarFileY = 36        
      EndIf
      
      If \ToolbarFileY < \ToolbarH And \ToolbarToolY < OptionsIE\ToolbarH
        
        \ToolInfoH = 0        
                
      Else
        
        \ToolInfoH = OptionsIE\ToolbarH
        
      EndIf
      
      ; bordure
      \BordureX  = ReadPreferenceInteger("BordureX",      50)
      \BordureY  = ReadPreferenceInteger("BordureY",      50)
      BarAnimH_IE         = ReadPreferenceInteger("BarAnimH",     80)
      
      ; options
      \paper$       = ReadPreferenceString("Paper", "paper1.png")
      paper\alpha   = ReadPreferenceInteger("PaperAlpha", 255)
      paper\scale   = ReadPreferenceInteger("PaperScale", 10)
      paper\intensity   = ReadPreferenceInteger("PaperIntensity", 10)
      
      ; Document by default ?
      \ImageW       = ReadPreferenceInteger("ImageW", 1024)
      \ImageH       = ReadPreferenceInteger("ImageH", 768)
      
      
      ; directories
      \DirPattern$  = ReadPreferenceString("DirPattern", "data\Presets\Patterns\")
      \DirPreset$   = ReadPreferenceString("DirPresets", "data\Presets\Bank\Blendman\")
      \DirBrush$    = ReadPreferenceString("DirBrush", "blendman")
      \RB_Img$      = ReadPreferenceString("RB_img", GetCurrentDirectory() + "data\Presets\RoughBoard\rb.png") 
      \Swatch$      = ReadPreferenceString("Swatch", GetCurrentDirectory() + "data\Presets\Swatch\Tango.gpl") 
      \SwatchColumns = ReadPreferenceInteger("SwatchColumns", 7) 
      If \SwatchColumns < 3
        \SwatchColumns = 6
      EndIf
      
      \PathOpen$  = ReadPreferenceString("PathOpen", GetCurrentDirectory() +"save\")
      \PathSave$  = ReadPreferenceString("PathSave", GetCurrentDirectory() + "save\")

      
      \Version$ = "6"
      ; GM = 1, Construct = 2, PB-canvas = 3, pb_teo = 4, agk = 5, pb_screen = 6, pb_openGL = 7
      
    EndWith
    doc\w = OptionsIE\ImageW
    doc\h = OptionsIE\ImageH
    ;}
    
        
    ;{ brush
    
    For i = 0 To 2 
      ; on réouvre les tools brush, eraser et pen, 
      ; pour les autres, je les sauvegarder plus tard, lorsque j'aurai créer leur propres paramètres
      Select  i 
          
        Case 0
          theaction = #action_brush
          PreferenceGroup("Brush")

        Case 1 ; eraser
          theaction = #Action_Eraser
          PreferenceGroup("Eraser")
          
        Case 2 ; pen
          theaction = #Action_Pen
          PreferenceGroup("Pen")
          
      EndSelect
      
      With Brush(theaction)
        
        
        \Id  = ReadPreferenceInteger("BrushImage", 1)
        If \Id <=0
          \Id=1
        EndIf
        \BrushNum  = ReadPreferenceInteger("BrushNum", 0)
        \BrushForm = ReadPreferenceInteger("BrushForm", 0)
        
        \BrushDir$ = ReadPreferenceString("BrushDir", "data\Presets\Brush\blendman\")
        If ExamineDirectory(0, \brushDir$, "*.png")
          
          While NextDirectoryEntry(0)
            If DirectoryEntryType(0) = #PB_DirectoryEntry_File
              \BrushNumMax +1
            EndIf
          Wend        
          FinishDirectory(0)        
          \BrushNumMax -1 
          
        EndIf
        
        ; size
        \Size      = ReadPreferenceInteger("size",     15)
        \SizeW     = ReadPreferenceInteger("sizeW",     100)
        \SizeH     = ReadPreferenceInteger("sizeH",     100)
        \SizeMin   = ReadPreferenceInteger("sizeMin",   0)
        \Sizepressure = ReadPreferenceInteger("sizePressure",1)
        
        ; dynamincs
        \Scatter   = ReadPreferenceInteger("Scatter",  0)
        \rotate    = ReadPreferenceInteger("rotate",   0)
        \randRot   = ReadPreferenceInteger("randrotate", 360)
        \RotateParAngle   = ReadPreferenceInteger("rotateangle", 1)
        
        ; alpha
        \Alpha     = ReadPreferenceInteger("alpha",    255)
        \alphaMax = \Alpha
        \AlphaBlend= ReadPreferenceInteger("alphablend",255)
        \AlphaFG   = ReadPreferenceInteger("alphaFG",  255)
        \AlphaPressure   = ReadPreferenceInteger("alphaPressure",  0)
        \AlphaRand = ReadPreferenceInteger("alpharand",  0)
        
        ; color
        \Color    = ReadPreferenceInteger("color",    1)
        Brush(Action)\ColorBG\R = Red(Brush(Action)\Color)
        Brush(Action)\ColorBG\G = Green(Brush(Action)\Color)
        Brush(Action)\ColorBG\B = Blue(Brush(Action)\Color)
        
        ;If \color  = 0
          ;\Color   = 1
        ;EndIf 
        \ColorFG    = ReadPreferenceInteger("colorFG",    1)
        ;If \ColorFG = 0
          ; \ColorFG   = 1
        ;EndIf 
        
        \mix      = ReadPreferenceInteger("mixing",  50)
        \MixType  = ReadPreferenceInteger("mixtyp",  0)
        \MixLayer = ReadPreferenceInteger("mixlayer",  0)
        
        ; \Mix       = \mixing/100
        \Visco    = ReadPreferenceInteger("visco",  3)
        \Lavage   = ReadPreferenceInteger("lavage", 1)
        \Water    = ReadPreferenceInteger("water",  0)
        
        
        ; parameters
        \pas      = ReadPreferenceInteger("pas",      50)
        \Type     = ReadPreferenceInteger("type",     0)
        \Trait    = ReadPreferenceInteger("trait",    1)
        \Smooth   = ReadPreferenceInteger("smooth",   0)
        \Hardness = ReadPreferenceInteger("hardness", 0)
        
        
        ; shape
        \ShapeOutline = ReadPreferenceInteger("ShapeOutline",  0)
        \ShapeOutSize = ReadPreferenceInteger("ShapeOutSize",  1)
        \ShapePlain   = ReadPreferenceInteger("ShapePlain",    1)
        \ShapeType    = ReadPreferenceInteger("ShapeType",     0)
        \RoundX       = ReadPreferenceInteger("RoundX",        5)
        \RoundY       = ReadPreferenceInteger("RoundY",        5)
        
        ; spray
        \Spray        = ReadPreferenceInteger("Spray",        10)
        \NbSpray      = ReadPreferenceInteger("NbSpray",      15)
        
        
      EndWith
      
    Next i
   
    ; temporary !!
    For i = #Action_Spray To #Action_Text
      brush(i)\Alpha = 255
      brush(i)\AlphaFG = 255
    Next i
    ;}
        
    
    ClosePreferences()
    
  Else
    
    ; MessageRequester(Lang("Info"),"Unable to load the pref file")
    
  EndIf
  
  
EndProcedure
Procedure WriteDefaultOption()
  
    Shared PanelToolsW_IE, PanelToolsH_IE, PanelLayerW_IE, PanelLayerH_IE, BarAnimH_IE 
     
  PreferenceGroup("General")
     
  With OptionsIE
    
    WritePreferenceString("Paper",          \Paper$)
    WritePreferenceInteger("SwatchColumns",  \SwatchColumns)
    
    WritePreferenceString("Theme",  \Theme$)
    WritePreferenceString("ThemeColor",  Str(\ThemeColor))
    
    ; Paths & directories
    WritePreferenceString("DirPattern",  RemoveString(\DirPattern$, GetCurrentDirectory()))
    WritePreferenceString("RB_img",       RemoveString(\RB_Img$, GetCurrentDirectory()))
    WritePreferenceString("Swatch",       RemoveString(\Swatch$, GetCurrentDirectory()))
    If \PathOpen$ = ""
      \PathOpen$ = "save\"
    EndIf
    WritePreferenceString("PathOpen",  RemoveString(\PathOpen$, GetCurrentDirectory()))
    If \PathSave$ = ""
      \PathSave$ = "save\"
    EndIf
    WritePreferenceString("PathSave", RemoveString(\PathSave$, GetCurrentDirectory()))
    WritePreferenceString("DirPresets", RemoveString(\DirPreset$, GetCurrentDirectory()))
    
    ; Grid
    WritePreferenceInteger("Grid",    \Grid)
    WritePreferenceInteger("ToolbarFileY",  \ToolbarFileY)
    WritePreferenceInteger("ToolbarFileX",  \ToolbarFileX)
    WritePreferenceInteger("ToolbarToolY",  \ToolbarToolY)
    WritePreferenceInteger("ToolbarToolX",  \ToolbarToolX)
    WritePreferenceInteger("Statusbar",     \Statusbar)
    
    WritePreferenceInteger("DelayMax",      \DelayMax)
    
    WritePreferenceInteger("Maxundo",       \Maxundo)
    WritePreferenceInteger("autosave",      \Autosave)
    WritePreferenceInteger("autosaveTime",  \AutosaveTime)
    WritePreferenceInteger("Filtering",     \SpriteQuality)

    
    
  EndWith
  
  ; on sauve ensuite les positions et tailles de certains gagets
    WritePreferenceInteger("PanelLayerH", PanelLayerH_IE)
    WritePreferenceInteger("PanelToolsH", PanelToolsH_IE)
;       PanelLayerW_IE  = ReadPreferenceInteger("PanelLayerW", 150)
;       PanelLayerH_IE  = ReadPreferenceInteger("PanelLayerH", 400)
;       PanelToolsW_IE  = ReadPreferenceInteger("PanelToolsW", 150)
;       PanelToolsH_IE  = ReadPreferenceInteger("PanelToolsH", 300)
  

    ;puis on sauve les outils (brush, eraser et pen pour le moment, plus tard les autres
    For i = 0 To 2
      
      Select  i 
        Case 0
          theaction = #action_brush
          PreferenceGroup("Brush")
          
        Case 1 ;  eraser
          theaction = #Action_Eraser
          PreferenceGroup("Eraser")
          
        Case 2 ;  pen
          theaction = #Action_Pen
          PreferenceGroup("Pen")
            
       EndSelect
       
       With brush(theaction)
         
         
         WritePreferenceInteger("BrushImage",\Id)
         WritePreferenceInteger("BrushNum",  \BrushNum)
         WritePreferenceInteger("BrushForm", \BrushForm)
         WritePreferenceString("BrushDir",   RemoveString(\BrushDir$, GetCurrentDirectory()))
         
         ; size
         WritePreferenceInteger("size",    \Size)
         WritePreferenceInteger("sizeW",   \SizeW)
         WritePreferenceInteger("sizeH",   \SizeH)
         WritePreferenceInteger("sizeMin", \SizeMin)
         WritePreferenceInteger("sizePressure", \Sizepressure)
         
         ; alpha
         WritePreferenceInteger("alpha",     \Alpha)
         WritePreferenceInteger("alphablend",\AlphaBlend)
         WritePreferenceInteger("alphaFG",   \AlphaFG)
         WritePreferenceInteger("alphaPressure", \AlphaPressure)
         WritePreferenceInteger("alpharand", \AlphaRand)
         
         ; colors
         WritePreferenceInteger("visco",   \Visco)
         WritePreferenceInteger("mixing",  \Mix)
         WritePreferenceInteger("mixtyp",  \MixType)
         WritePreferenceInteger("mixlayer",  \MixLayer)
         WritePreferenceInteger("lavage",  \Lavage)
         WritePreferenceInteger("water",   \Water)
         WritePreferenceInteger("color",   \Color)
         WritePreferenceInteger("colorFG", \ColorFG)
         
         ; dynamnics
         WritePreferenceInteger("scatter",   \Scatter)
         WritePreferenceInteger("randrotate",\randRot)
         WritePreferenceInteger("rotate",    \Rotate)
         WritePreferenceInteger("rotateangle",\RotateParAngle)
         
         ; parameters
         WritePreferenceInteger("pas",       \pas)
         WritePreferenceInteger("type",      \Type)
         WritePreferenceInteger("trait",     \Trait)
         WritePreferenceInteger("smooth",    \Smooth)
         WritePreferenceInteger("hardness",  \Hardness)
         
         ; shape
         WritePreferenceInteger("ShapeOutline", \ShapeOutline)
         WritePreferenceInteger("ShapeOutSize", \ShapeOutSize)
         WritePreferenceInteger("ShapePlain",   \ShapePlain)
         WritePreferenceInteger("ShapeType",    \ShapeType)
         WritePreferenceInteger("RoundX",       \RoundX)
         WritePreferenceInteger("RoundY",       \RoundY)
         
       EndWith
       
     Next i
     
     
     
     
EndProcedure
Procedure SaveOptions()
    
   If OpenPreferences("Pref.ini")
     
     WriteDefaultOption()
     
    ClosePreferences()
           
  Else
    
    If CreatePreferences("Pref.ini")
      
      WriteDefaultOption() 
      
      ClosePreferences()  
      
    EndIf
    
  EndIf
   
EndProcedure


; OPEN
Procedure Doc_openOld()
  
EndProcedure
Procedure Doc_Open()
  
  ; procedure pour ouvrir un document (animatoon old (abi), new, teo=, c'est à dire avec tous les calques, les paramètres, etc..
  
  ; d'abord, on va chercher le fichier à ouvrir
  
  ; File$ = OpenFileRequester(Lang("Open Teo"), "", "Teo (*.teo)|*.teo|Abi (*.abi)|*.abi",0)
  ; Pattern$ = "All |*.jpg;*.png;*.bmp;*.ani;*.teo;*.abi"
  
  ; Pattern$ = "Files |*.txt;*.bat;*.pb;*.doc;*.png"
  
  Pattern$ ="All Images format|*.jpg;*.png;*.bmp;*.abi;*.teo|JPG|*.jpg|PNG|*.png|BMP|*.bmp|"+
            "Ani (Animatoon document)|*.ani|Ani (Animatoon - Old version)|*.ani|Abi (old animatoon file)|*.abi|Teo (Tile editor organisation)|*.teo"
  
  
  File$ = OpenFileRequester("Open an image or an animatoon document", OptionsIE\PathOpen$,Pattern$,4) 
  Index = SelectedFilePattern()
  
  Debug "index :"+ Str(Index)
  
  If File$ <> ""
    
    OptionsIE\PathOpen$ = GetPathPart(file$)
    
    Layer_FreeAll()
    ; ClearGadgetItems(#G_LayerList)

    DocName$  = GetFilePart(File$, #PB_FileSystem_NoExtension)
    DocPath$  = GetPathPart(File$)
    Ext$      = LCase(GetExtensionPart(File$))
    Filemain$ = DocName$ + ".txt"
    NewName$ = RemoveString(File$,".ani")+".zip"
    OldName$ = File$
    
    Select Ext$
        
        
      Case "ani","abi","teo"
        
        If Ext$ = "abi"
          MessageRequester("Info", "Not implemented yet")
        Else
          
          If Index  = 4 ; new file format : *.ani
            ;{ ; new file format : *.ani
            Debug "on dépacke le fichier " +  File$
                        
            UseZipPacker()
                        
            ZipFile$ = File$
            Debug ZipFile$
            ;Ne gérant pas la destination de la décompression on va créer un dossier de destination
            ;Ce dossier sera un sous dossier du dossier courrant de l'application
            ;Il portera le nom du fichier en cours de décompression
            
            ;Mémorisation du dossier à créer et sur lequel on se positionnera pour la décompression
            path$ = GetPathPart(ZipFile$)
            dirname$ = Mid(GetFilePart(ZipFile$), 1, Len(GetFilePart(ZipFile$))-Len(GetExtensionPart(ZipFile$))-1) + "_tmp_"
            Directory$ = path$ + dirname$
            Debug  "le répertoire dans lequel on va copier les éléments du zip : "+Directory$
            
            ;Création  du dossier de destination de la décompression
            Resultat=CreateDirectory(Directory$)
            
            If resultat = 1 
              Debug "on crée le répertoire "   
            EndIf
            
            ;Mémorisation du dossier de destination de la décompression
            ; CurrentDirectory$ = GetCurrentDirectory() + Directory$ + "\"
            CurrentDirectory$ = Directory$ + "\"
            
            
            Pack = OpenPack(#ZipFile, ZipFile$, #PB_PackerPlugin_Zip)
            Dim nom$(n)
            
            
            CurentDir$ = GetCurrentDirectory()
            
            ;Lecture séquentielle des entrées du fichier compressé
            If ExaminePack(#ZipFile) 
              
              While NextPackEntry(#ZipFile)
                
                PackEntryName$ = PackEntryName(#ZipFile)
                Debug PackEntryName$
                
                Select PackEntryType(#ZipFile)
                    
                  Case #PB_Packer_File
                    SetCurrentDirectory(CurrentDirectory$)
                    
                    ;Création du/des dossiers si inexistant
                    For i=1 To CountString(PackEntryName$, "/")
                      Directory$ = StringField(PackEntryName$, i, "/")
                      CreateDirectory(Directory$)
                      SetCurrentDirectory(CurrentDirectory$ + Directory$)
                    Next 
                    
                    SetCurrentDirectory(CurrentDirectory$)
                    ReDim nom$(n)
                    ; nom$(n) = PackEntryName$
                    UncompressPackFile(#ZipFile, PackEntryName$)
                    
                  Case #PB_Packer_Directory ;C'est un dossier contenant des sous dossiers
                    SetCurrentDirectory(CurrentDirectory$)
                    
                    ;Création du/des dossiers si inexistant
                    For i=1 To CountString(PackEntryName$, "/")
                      Directory$ = StringField(PackEntryName$, i, "/")
                      CreateDirectory(Directory$)
                      SetCurrentDirectory(CurrentDirectory$ + Directory$)
                    Next
                    
                EndSelect
              Wend 
            EndIf
            
            SetCurrentDirectory(CurentDir$)
            ; puis On ouvre le fichier texte
            Filemain$ = Directory$ + "/"+Filemain$
      ;}
          Else
            pack = 2
            Filemain$ = File$
          EndIf
          
          
          
          If ReadFile(0, Filemain$) 
            
            If pack >=1 
              Debug "pack : "+Str(pack)
              
              Debug "on va lire le fichier"
              
              ; then we open the file
              While Eof(0) = 0
                
                line$ = ReadString(0)
                info$ = StringField(line$, 1, "|")
                Debug info$
                Select info$
                    
                  Case "Version"; la version du logiciel
                    
                    versionDoc = Val(StringField(line$, 2, "|")) 
                    VersionTeo = Val(OptionsIE\Version$) 
                    If VersionTeo > versionDoc  
                      ; MessageRequester(Lang("Info"), Lang("File outdated"))
                    EndIf
                    
                    
                    
                  Case "Image"; les informations liées à l'image
                    
                    doc\W = Val(StringField(line$, 2, "|"))
                    doc\H = Val(StringField(line$, 3, "|"))
                    
                    ; les calques
                    NB = Val(StringField(line$, 4, "|")) ; nbre de layers
                    LayerNb = 0
                    LayerIdMax = 0
                    OptionsIE\Zoom = Val(StringField(line$, 5, "|"))
                    If OptionsIE\Zoom <=0
                      OptionsIE\Zoom = 100
                    EndIf
                    canvasX = Val(StringField(line$, 6, "|"))
                    canvasY = Val(StringField(line$, 7, "|"))
                    
                  Case "LayerVecto" 
                    
                  Case "Layer"  
                    
                    OptionsIE\LayerTyp = Val(StringField(line$, 17, "|"))
                    
                    Layer_Add()
                    
                    ; on redéfinit les infos des calques
                    With Layer(LayerId)
                      
                      \Name$     = StringField(line$, 2, "|")
                      \Alpha     = Val(StringField(line$, 3, "|"))
                      \BM        = Val(StringField(line$, 4, "|"))
                      \LockAlpha = Val(StringField(line$, 5, "|"))
                      \locked    = Val(StringField(line$, 6, "|"))
                      \LockMove  = Val(StringField(line$, 7, "|"))
                      \LockPaint = Val(StringField(line$, 8, "|"))
                      \ordre     = Val(StringField(line$, 9, "|"))
                      \View      = Val(StringField(line$, 10, "|"))                    
                      
                      \X         = Val(StringField(line$, 11, "|"))
                      \Y         = Val(StringField(line$, 12, "|"))                    
                      \W         = Val(StringField(line$, 13, "|"))                    
                      \H         = Val(StringField(line$, 14, "|"))                    
                      \Group     = Val(StringField(line$, 15, "|"))
                      \Link      = Val(StringField(line$, 16, "|"))
                      \Typ       = Val(StringField(line$, 17, "|"))
                      \Text$     = StringField(line$, 18, "|")
                      \CenterX   = Val(StringField(line$, 19, "|"))
                      \CenterY   = Val(StringField(line$, 20, "|"))                    
                      \MaskAlpha = Val(StringField(line$, 21, "|"))                    
                      \FontColor = Val(StringField(line$, 22, "|"))
                      \FontName$ = StringField(line$, 23, "|")
                      \FontSize  = Val(StringField(line$, 24, "|"))
                      \FontStyle = Val(StringField(line$, 25, "|"))
                      
                      \FontID = LoadFont(#PB_Any,\FontName$,\FontSize,\FontStyle)
                    
                    
                      If VersionDoc < VersionTeo 
                        imageloaded$ = DocPath$+DocName$+"_"+\name$+".png"         
                      Else                        
                        imageloaded$ = DocPath$+dirname$+"/"+DocName$+"_Layer"+Str(ArraySize(layer()))+".png"
                      EndIf
                      
                      temp =  LoadImage(#PB_Any, imageloaded$)
;                       If pack <> 2 And pack >=1
;                         Debug "on supprime le fichier : "+imageloaded$
;                         ;DeleteFile(imageloaded$)
;                       EndIf
                      
                     
                      
                      If temp = 0
                        reponse = MessageRequester("Error", "unable to load the image " + imageloaded$ + ".png. Do you want To open by yourself ?",#PB_MessageRequester_YesNo)     
                        If reponse = 6
                          Layer_importImage(0)
                        EndIf                  
                      EndIf
                      
                      If temp
                        If StartDrawing(ImageOutput(layer(LayerId)\Image))
                          DrawingMode(#PB_2DDrawing_AlphaBlend)
                          DrawAlphaImage(ImageID(temp),0,0)
                          StopDrawing()
                        EndIf                  
                        FreeImage(temp)                 
                      EndIf
                      
                      If \w =0 Or \h =0
                        \w =ImageWidth(layer(LayerId)\Image)
                        \h =ImageHeight(layer(LayerId)\Image)
                      EndIf
                      
                    EndWith
                    NewPainting = 1
                    ;Layer_Update(LayerId)
                    ScreenUpdate(1)
                    
                EndSelect
                
              Wend
             
              
            EndIf
             ; on ferme le fichier
            CloseFile(0)
            ; supprime le dossier temporaire
            If pack >= 1 And pack <> 2
              ;DeleteFile(Filemain$)
              DeleteDirectory(Directory$,"",#PB_FileSystem_Recursive)
            EndIf
            
            ; on update la liste des calques
            Layer_UpdateList()
            
            ; on update le screen
            NewPainting =1
            ScreenUpdate(0)
            
          Else
            Debug "pas de fichier à lire : " +Filemain$
            MessageRequester(lang("Error"),lang("No file to open. Please with the old .ani format."))
            Layer_Add()
          EndIf
          
          
        EndIf
        
      Case "jpg","png","bmp"
        ;{ on ouver une image 
        tmp = LoadImage(#PB_Any, File$)
        Doc\w = ImageWidth(tmp)
        Doc\h = ImageHeight(tmp)
        Layer_Add()
        If StartDrawing(ImageOutput(Layer(layerId)\Image))
          DrawingMode(#PB_2DDrawing_AlphaBlend)
          DrawAlphaImage(ImageID(tmp),0,0)
          StopDrawing()
        EndIf        
        FreeImage2(tmp)
        
        ; on update la liste des calques
        Layer_UpdateList()
        ; on update le screen
        NewPainting =1
        ScreenUpdate(0)
        ;}
        
    EndSelect
    
    
  EndIf 
  
  IE_StatusBarUpdate()
  
EndProcedure


; saving
Procedure SelectFormat(file$)
  
  Select GetExtensionPart(file$) 
    Case"png"
      format = #PB_ImagePlugin_PNG
    Case "jpg"
      format = #PB_ImagePlugin_JPEG
    Case "bmp"
      format = #PB_ImagePlugin_BMP 
  EndSelect
  
  ProcedureReturn format
EndProcedure
Procedure Doc_Save()
  
  ;p$ = SaveFileRequester(Lang("Save Document"),"","Teo (*.teo)",0)
  p$ = SaveFileRequester("Save Document", OptionsIE\PathSave$,"Ani (*.ani)",0)
  
  If p$<>"" 
    
    
   
    If GetFileExist(p$) = #True
      rep = MessageRequester(Lang("Info"), Lang("The file exist. Save over it ?"), #PB_MessageRequester_YesNo)
      If rep = 6
        ok = 1
      EndIf
    Else
      ok = 1
    EndIf 
    
    If ok
      
      zip$  = RemoveString(p$, ".ani")
      p$    = RemoveString(p$, ".ani")  + ".ani"    
      Name$ = GetFilePart(p$, #PB_FileSystem_NoExtension)    
      Path$ = GetPathPart(p$) 
      ; Dir$  = path$ + Name$
      
      Nb = ArraySize(Layer())
      
      ; If CreateDirectory(Dir$) : EndIf
      
      ;dir$ + "\"
      
      Dim FileToDelete$(0)
      
      UseZipPacker()   
      If CreatePack(0, p$)
        
        w_exp = Doc\W
        h_exp = Doc\H
        
      
        temp = CreateImage(#PB_Any, w_exp, h_exp, 32, #PB_Image_Transparent)
        
        ; je dois convertir les calques pour prendre en comte les blendmodes 
        For i =0 To Nb
          Layer_ConvertToBm(i)
        Next i
        
        
        ; puis, je dessine tout sur une image temporaire, avant de la sauver et de la supprimer en mémoire.
        If StartDrawing(ImageOutput(temp))
          
          DrawingMode(#PB_2DDrawing_AlphaChannel)
          Box(0, 0, w_exp, h_exp,RGBA(0,0,0,0))
          DrawingMode(#PB_2DDrawing_AlphaBlend)
          
          For i = 0 To nb
            
            If Layer(i)\View
              Layer_Bm2(i) ; pour définir le drawingmode / blendmode
              ; j'utilise layer()\Imagetemp et non layer()\image car je dois prendre en comtpe le blendmode.
              DrawAlphaImage(ImageID(Layer(i)\ImageTemp), 0, 0,Layer(i)\Alpha ) 
            EndIf
            
          Next
          
          StopDrawing()
          
        EndIf 
        
        File$ = RemoveString(p$,".ani")
        
        nom$ = Name$ +".png"
        SaveImage(temp, nom$, #PB_ImagePlugin_PNG)
        AddPackFile(0, nom$, nom$)
        
        ; puis, on supprime les images créées, pour libérer de la mémoire.
        FreeImage2(temp)
        ; result = DeleteFile(nom$,#PB_FileSystem_Force)
        FileToDelete$(0) = nom$
        
        ; puis, on supprime les images temporaire
        For i =0 To ArraySize(layer())
          FreeImage2(layer(i)\ImageTemp)
        Next i
        
        ; on sauvegarde tous les layers
        For i = 0 To nb
          
          If IsImage(Layer(i)\Image)
            nom$ = Name$ + "_Layer"+ Str(i)+".png"
            SaveImage(Layer(i)\Image, nom$, #PB_ImagePlugin_PNG)
            AddPackFile(0, nom$, nom$)
            ;DeleteFile(nom$,#PB_FileSystem_Force)
            ;DeleteFile(GetCurrentDirectory()+nom$)
            ;MessageRequester("",GetCurrentDirectory()+nom$)
            n = ArraySize(FileToDelete$())+1
            ReDim FileToDelete$(n)
            FileToDelete$(n) = nom$
          EndIf
          
        Next
        
        ; enfin, On sauvegarde le fichier texte
        nom$ = Name$ + ".txt"
        If OpenFile(0, Nom$)
          
          WriteStringN(0, "; Made By Animatoon ")
          WriteStringN(0, "Version|"+ OptionsIE\Version$+ "|")
          
          image$ = "Image|"+Str(Doc\W)+"|"+Str(Doc\H)+"|"+Str(Nb)+"|"+Str(OptionsIE\Zoom)+"|"+Str(CanvasX)+"|"+Str(CanvasY)+"|"
          WriteStringN(0, Image$)
          
          For i = 0 To Nb
            
            With Layer(i)
              
              Label$ = "Layer|"
              
              Select \Typ
                  ;                 Case #Layer_TypBitmap
                  ;                   Typ$ = "Layer|"
                  ;                   
                  ;                 Case #Layer_TypText
                  ;                   Typ$ = "LayerText|"
                  ;                   
                Case #Layer_TypVecto
                  Label$ = "LayerVecto|"
                  
                Default
                  info$ = Label$  +  \Name$ + "|" + Str(\Alpha) + "|" + Str(\BM) + "|"
                  info$ + Str(\LockAlpha) + "|" + Str(\Locked) + "|" + Str(\LockMove)+ "|" + Str(\LockPaint)
                  info$ + "|" + Str(\ordre) + "|" + Str(\View) + "|" + Str(\X) + "|" + Str(\Y)+ "|"+ Str(\W) + "|" + Str(\H)+ "|"
                  info$ + Str(\Group)+"|"+Str(\Link)+"|"+Str(\Typ)+"|"+\Text$+"|"+Str(\CenterX)+"|"+Str(\CenterY)+"|"+Str(\MaskAlpha)+"|"
                  info$ + Str(\FontColor)+"|"+\FontName$+"|"+Str(\FontSize)+"|"+Str(\FontStyle)+"|"
                  
              EndSelect
              
              WriteStringN(0, info$)
              
            EndWith
            
          Next i
          
          CloseFile(0)
          
        EndIf
        
        AddPackFile(0, nom$, nom$)
        ClosePack(0)
        
        DeleteFile(nom$,#PB_FileSystem_Force)
        For i =0 To n
          DeleteFile(FileToDelete$(i))
        Next 
        FreeArray(FileToDelete$())
        
      EndIf 
      
    EndIf 
    
    
    
  EndIf 
    
 
EndProcedure
Procedure ExportImage(auto=0)
  
  ; pour exporter l'image, le calque actif
  If auto = 0
    filename$ = SaveFileRequester("Save Image","","png|*.png",0)
  EndIf
  
  If filename$ <>"" Or auto = 1
    If auto = 1
      filename$ = "save\autosav"+Str(Random(1000000))
    EndIf    
    For i=0 To ArraySize(layer())
      name$=filename$+"_Layer"+Str(i)+ ".png"
      If OptionsIE\SaveImageRT
        If IsImage(layer(i)\Image)
          SaveImage(Layer(i)\image, name$,#PB_ImagePlugin_PNG)
        EndIf 
      Else
        If IsSprite(layer(i)\Sprite)
          CopySprite(Layer(LayerId)\Sprite,#Sp_CopyForsave, #PB_Sprite_AlphaBlending)
          SaveSprite(#Sp_CopyForsave, name$,#PB_ImagePlugin_PNG)
          FreeSprite2(#Sp_CopyForsave)
        EndIf 
      EndIf
    
    Next i  
  EndIf
  
EndProcedure
Procedure.s ExportOnImage()
  
  filename$ = SaveFileRequester("Save Image","","jpg|*.jpg|png|*.png|bmp|*.bmp",0)
  
  If filename$ <>""      
    
    ; d'abord, on doit modifier l'image en fonction du blendmode
    For i = 0 To ArraySize(layer())
      With layer(i)
        If IsImage(\Image)
          If \view
            Layer_convertToBm(i)
          EndIf
        EndIf
      EndWith
    Next i
    
    If IsImage(#ImageExport)=0
      CreateImage(#ImageExport,doc\w,doc\h,32,#PB_Image_Transparent)
    EndIf
    
    If StartDrawing(ImageOutput(#ImageExport))                
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      Box(0,0,canvasW,canvasH,RGBA(0,0,0,0))                
      DrawingMode(#PB_2DDrawing_AlphaBlend)                
      For i=0 To ArraySize(layer())
        If layer(i)\view = 1
          Layer_bm2(i)
          DrawAlphaImage(ImageID(layer(i)\ImageTemp),0,0,layer(i)\alpha)
        EndIf
      Next i
      StopDrawing()
    EndIf
    
    ; on sauve ensuite l'image obtenue    
    Filtre = SelectedFilePattern() ; 0 = jpg, 1 = png, 2 = bmp
    
    Ext$ = GetExtensionPart(filename$)
    If Ext$ <> "jpg" And filtre = 0
      filename$ + ".jpg"
      Ext$ = ".jpg"
      format = #PB_ImagePlugin_JPEG
    EndIf  
    If Ext$ <> "png" And filtre = 1
      filename$ + ".png"
      Ext$ = ".png"
      format = #PB_ImagePlugin_PNG
    EndIf     
    If Ext$ <> "bmp" And filtre = 2
      filename$ + ".bmp"
      format = #PB_ImagePlugin_BMP
    EndIf   
    
    result$ = RemoveString(filename$,ext$)
    SaveImage(#ImageExport, filename$,format)
        
    ; puis, on supprime les images temporaire
    For i =0 To ArraySize(layer())
      FreeImage2(layer(i)\ImageTemp)
    Next i
    
    
  EndIf
  
  ProcedureReturn filename$ ; result$
EndProcedure

Procedure.i CaptureScreenToImage(x.i, y.i, width.i, height.i)
  Protected TmpImage.i, srcDC.i, trgDC.i
  Protected BMPHandle.i, dm.Devmode
  
  ; Attention, windows only !!! :(
  
  srcDC = CreateDC_("DISPLAY", "", "", dm)
  trgDC = CreateCompatibleDC_(srcDC)
  BMPHandle = CreateCompatibleBitmap_(srcDC, width, height)
 
  RedrawWindow_(#Null,#Null,#Null,#RDW_INVALIDATE)
 
  SelectObject_( trgDC, BMPHandle)
  BitBlt_( trgDC, 0, 0, width, height, srcDC, x, y, #SRCCOPY)
 
  DeleteDC_( trgDC)
  ReleaseDC_( BMPHandle, srcDC)
 
  TmpImage.i = CreateImage(#PB_Any, width, height)
  If StartDrawing(ImageOutput(TmpImage))
    DrawImage(BMPHandle, 0, 0)
    StopDrawing()
  EndIf

  DeleteDC_(trgDC)
  ReleaseDC_(BMPHandle, srcDC)
 
  ProcedureReturn TmpImage
 
EndProcedure
Procedure MakeScreenshot(x,y,Width,Height,File.s) 
  hImage = CreateImage(#PB_Any,Width,Height,32)
  If hImage
    hDC    = StartDrawing(ImageOutput(hImage))
    If hDc
      DeskDC = GetDC_(GetDesktopWindow_()) 
      BitBlt_(hDC,0,0,Width,Height,DeskDC,x,y,#SRCCOPY) 
      ReleaseDC_(GetDesktopWindow_(),DeskDC)
      DrawImage(hImage,0,0)
      StopDrawing()
      If SaveImage(hImage, File) :EndIf
      FreeImage(hImage)
    EndIf
  EndIf
EndProcedure

Procedure File_SaveImage()
  
  ; d'abord, on sauvegarde l'image normal, avec les blendemode
  
  ; on va ensuite sauvegarder toutes les parties de l'image, en décalant les calques pour capturer 
  ; ce qu'on voit à l'écran, puis tout coller ensuite en une seule grosse image 
  ; si c'est plus gros que la taille de l'écran ^^
  name$ = ExportOnImage()

  If name$ = ""
    name$ = "Img_"+Str(Random(1000000))+"_"
  Else
    ext$ = GetExtensionPart(name$)
    name$ = RemoveString(name$,ext$)
    name$ = RemoveString(name$,".")
  EndIf
  
  If doc\w>CanvasW
    NbPartX = Round(doc\w/CanvasW,#PB_Round_Up)-1 
  Else
    NbPartX = 0
  EndIf
  If doc\h > CanvasH
    NbPartY = Round(doc\h/CanvasH,#PB_Round_Up)-1 
  Else
    NbPartY = 0
  EndIf
  
  OldCanvasX = CanvasX
  OldCanvasY = CanvasY
 
  OldZoom = OptionsIE\Zoom
  OptionsIE\Zoom = 100
  
  ;Debug "on va sauver l'image issue du screen"
  
  ; on crée des sprites temporaires de la taille des écrans
  NbPart = (NbPartX+1) * (NbPartY+1)
  Dim TempoImg.i(NbPart)
  
  
  ;Debug "nbre de partie : "+Str(NbPartX)+"*"+Str(NbPartY)+"="+Str(NbPart)

  u=0
  For i = 0 To NbPartX
    For j = 0 To NbPartY
      
      W = ScreenWidth()
      H = ScreenHeight()
      CheckIfInf2(doc\w,w)
      CheckIfInf2(doc\h,h)

      ; on va déplacer tous les calques en même temps, pour avoir toutes les parties de l'écran au complet :)
      CanvasX = - i*W
      CanvasY = - j*H
      
      ;Debug "position du canvas : "+Str(CanvasX)+"/"+Str(CanvasY)
      ; puis, j'update le screen
      ClearScreen(RGB(120,120,120)) ; on efface tout
      ; the paper
      PaperDraw() ; je met le paper ?
            
      Layer_DrawAll(); tous les calques
      FlipBuffers(): ; affiche l'ecran
      
;       If IsImage(#Img_saveImage) = 0
;         CreateImage(#Img_saveImage, W,H,32,#PB_Image_Transparent)
;       EndIf
      
      
      GrabSprite(#Sp_ToSaveImage,0,0,w,h)
      SaveSprite(#Sp_ToSaveImage,"sprite__0__0.png",#PB_ImagePlugin_PNG)
      LoadImage(#Img_saveImage, "sprite__0__0.png") 
      ; CatchImage(#Img_saveImage, @tmpSprite) 
      ;Debug "U : "+Str(u) + " sprite : "+Str(#Sp_ToSaveImage)+ "- Image : "+Str(#Img_saveImage)
      ; TempoImg(u) = CatchImage(#PB_Any, @tmpSprite) 
      TempoImg(u) = CopyImage(#Img_saveImage,#PB_Any)
      FreeImage(#Img_saveImage)
      FreeSprite(#Sp_ToSaveImage)
      u+1
      
    Next j
  Next i
  
  
  ; on créé l'image finale et on dessine dessus les bout d'image)  
  If CreateImage(#Img_saveImage,doc\w,doc\h,32,#PB_Image_Transparent)
    u=0
    If StartDrawing(ImageOutput(#Img_saveImage))
      DrawingMode(#PB_2DDrawing_AllChannels)
      Box(0,0,doc\w,doc\h,RGBA(0,0,0,255))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      For i = 0 To NbPartX
        For j = 0 To NbPartY
          If IsImage(TempoImg(u))
            DrawAlphaImage(ImageID(TempoImg(u)),i*w,j*h)
          Else
            ;Debug "pas d'image en :"+Str(u)
          EndIf
          u+1
        Next j
      Next i
      StopDrawing()
    EndIf
    
    ; on sauve l'image
    ;Debug "on sauve l'image"
    savefile$ = name$+"_Screen."+ext$
    format = SelectFormat(savefile$)
    
    If SaveImage(#Img_saveImage,savefile$,format)=0
      MessageRequester("error","unable to save the part of the image screen !"+savefile$)
    EndIf
    
   ; puis on libère la mémoire
    FreeImage(#Img_saveImage)

    
  Else
    MessageRequester("Error", "unable to create the final image")
  
  EndIf

  For i = 0 To NbPart
     FreeImage2(TempoImg(i))
  Next i
  
  FreeArray(TempoImg())
  
  ; on supprime l'image temporaire
  DeleteFile("sprite__0__0.png")

  
  ; et on rétablit le screen tel qu'il était
  CanvasX = OldCanvasX
  CanvasY = OldCanvasY
  
 
  OptionsIE\Zoom = OldZoom
  ScreenUpdate()

  
EndProcedure

; Autosave (thread or not threaded)


Procedure AutoSave(Parameter) ; with thread
  
  Repeat
    
    
    If OptionsIE\ImageHasChanged
      OptionsIE\ImageHasChanged = 0
      For i= 0 To ArraySize(layer())
        If layer(i)\Haschanged
          layer(i)\Haschanged = 0 
          Date$ = FormatDate("%yyyy_%mm_%dd", Date()) 
          ;Debug "save\AutoSave_"+Date$+"_"+layer(i)\Name$+"_"+Str(i)+".png"
          If SaveImage(layer(i)\Image, GetCurrentDirectory() + "save\AutoSave_"+Date$+"_"+layer(i)\Name$+"_"+Str(i)+".png",#PB_ImagePlugin_PNG)
          EndIf
        EndIf      
      Next i
      Delay(40000); toutes les minutes, on sauvegarde l'image, uniquement si elle a changée
    EndIf
    
    ; si elle n'a pas changé, on revérifie toutes les 10 s
    Delay(10000) ; mettre un délai ici pour éviter de bouffer le tps processeur
    ;Debug "autosave"
    
  ForEver

EndProcedure

Procedure AutoSave_NoThread()
  
  Shared AutosaveTimeStart
  
  ; autosave, not in a thread, there is an autosave function with thread if needed (in procedures.pb)
  If  OptionsIE\Autosave = 1
    
    autosavetime = ElapsedMilliseconds() - AutosaveTimeStart
    
    If autosavetime >= AutosaveTimeStart + OptionsIE\AutosaveTime * 60000
      AutosaveTimeStart = ElapsedMilliseconds()
      
      If OptionsIE\ImageHasChanged
        
        OptionsIE\ImageHasChanged = 0
        
        ; First, examine if directories exists // d'abord on vérifie que le dossier "save existe
        saveDir$ = GetCurrentDirectory()+"save\"
        If ExamineDirectory(0, GetCurrentDirectory(), "")
;           If IsDirectory(0) = 0
;             If CreateDirectory(saveDir$) = 0
;               MessageRequester(LAng("Error"), lang("Unable to create the 'save' directory."))
;               saveDir$ = GetCurrentDirectory()
;             EndIf
;           EndIf
            While NextDirectoryEntry(0)
              If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory
                If DirectoryEntryName(0) = "save";"autosave"
                  trouve = 1
                EndIf
              EndIf
            Wend 

          FinishDirectory(0)
        EndIf
        
        If trouve = 0
          If CreateDirectory(saveDir$) = 0
              MessageRequester(Lang("Error"), lang("Unable to create the 'save' directory."))
              saveDir$ = GetCurrentDirectory()
            EndIf
         EndIf
        
        ;Debug GetCurrentDirectory()
        ;Debug saveDir$
        
        ; create autosave if needed
        autosaveDir$ = saveDir$;+"autosave\"
         ;Debug autosaveDir$
;         If ExamineDirectory(0, autosaveDir$, "")
;           If IsDirectory(0) = 0
;             If CreateDirectory(autosaveDir$) = 0
;               MessageRequester(LAng("Error"), lang("Unable to create the 'autosave' directory."))
;               autosaveDir$ =  GetCurrentDirectory()
;             
;             EndIf
;           Else
;             While NextDirectoryEntry(0)
;               If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory
;                 If
;                 EndIf
;               EndIf
;             Wend 
;           EndIf
;           FinishDirectory(0)
;         Else
;           Debug "erreur examinedirectory "+
;         EndIf
        
        
        ; Debug autosaveDir$
        
        ; the save the image from layers
        For i= 0 To ArraySize(layer())
          
          If layer(i)\Haschanged
            layer(i)\Haschanged = 0 
            ; Debug "autosave !!! "
            Date$ = FormatDate("%yyyy%mm%dd%hh%ii%ss", Date()) 
            
            ;Debug "save\AutoSave_"+Date$+"_"+layer(i)\Name$+"_"+Str(i)+".png"
            
            theAutosavedir$ = autosaveDir$ ; GetCurrentDirectory() + "save\autosave\"
            If SaveImage(layer(i)\Image,  theAutosavedir$+"AutoSave_"+Date$+"_"+layer(i)\Name$+"_"+Str(i)+".png",#PB_ImagePlugin_PNG)
             ; Debug LAng("ok save image layer "+layer(i)\Name$)
            Else
             ; Debug LAng("Error") +" /"+ lang("Unable To save the 'autosave' image layer : "+layer(i)\Name$)
             ; add a log error !!
              AddLogError(1, lang("Unable To save the 'autosave' image layer : "+layer(i)\Name$))
            EndIf
            AddLogError(1, lang("Unable To save the 'autosave' image layer : "+layer(i)\Name$))
          EndIf
          
        Next i
        
        ; Debug Str(AutosaveTimeStart)+"/"+ Str(autosavetime)+"/"+ElapsedMilliseconds()+"/"+Str(AutosaveTimeStart + OptionsIE\AutosaveTime * 60000)
        
        ; Delay(40000 * OptionsIE\AutosaveTime); toutes les 5 minutes, on sauvegarde l'image, uniquement si elle a changée
        
      EndIf
      
    EndIf
    
  EndIf
  
EndProcedure

;}

;{ editions
Procedure Edit_Copy()
  
  x = OptionsIE\SelectionX
  y = OptionsIE\SelectionY
  w = OptionsIE\SelectionW
  h = OptionsIE\SelectionH
  If w=0 Or h=0
    w= ImageWidth(layer(layerid)\Image)
    h= ImageHeight(layer(layerid)\Image)
  EndIf
  
  tmp = GrabImage(layer(layerid)\Image, #PB_Any,X,Y,W,H)
  
  SetClipboardImage(tmp)
  
  FreeImage2(tmp)
  
EndProcedure
Procedure Edit_Paste()
  
  tmp = GetClipboardImage(#PB_Any,32)
  
  If tmp
    
    If StartDrawing(ImageOutput(layer(LayerId)\Image))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      
      DrawAlphaImage(ImageID(tmp),0,0)
      
      StopDrawing()
    EndIf
    
    Newpainting = 1
    ScreenUpdate()
    
    FreeImage(tmp)
    
  EndIf
  
EndProcedure

Procedure Edit_Select(selectAll=1)
  
  OptionsIE\Selection = selectAll
  
  OptionsIE\SelectAlpha = 0
                         
  OptionsIE\SelectionX = 0
  OptionsIE\SelectionY = 0
  OptionsIE\SelectionW = doc\w
  OptionsIE\SelectionH = doc\h
  
  ScreenUpdate()
  
EndProcedure

Procedure ResizeDoc(canvas=0)
  
  ; If OpenWindow(#Win_ResizeDoc,
    w = Val(InputRequester("Width","New Width of the Document", ""))
    h = Val(InputRequester("Height","New Height of the Document", ""))
    oldW = doc\w
    oldH = doc\h
  
  If w*h >= 3000*3000
    rep = MessageRequester("Info","The new size will be big. Continue ?",#PB_MessageRequester_YesNo)
  Else 
    ok = 1
  EndIf
   
  If rep = #PB_MessageRequester_Yes Or ok =1
    
    ok =0
    
    If w >= 1
      ok = 1
      doc\w = w
    EndIf
    If  h >= 1
      ok = 1
      doc\h = h
    EndIf
    
    If oldW > doc\w Or oldH > doc\h
      
      rep = MessageRequester("Info","The new size is smaller than the original, The image will be cropped. Continue ?",#PB_MessageRequester_YesNo)
      
      If rep = #PB_MessageRequester_Yes     
        ok = 1
      Else
        ok = 0
      EndIf
      
    EndIf
    
    If ok
      
      
      ;Debug "On va redimensionner. New size : "+Str(doc\w)+"/"+Str(doc\h)
      
      
      n = ArraySize(layer())
      n1 = (n+1)*10 +20
      ;Debug "nb layer : "+Str(n)
      StatusBarProgress(#Statusbar,3,5,5,0,n1)
      
      If canvas = 0  ; on agrandit le document, on redimensionne 
        
        For i=0 To n
          
          StatusBarProgress(#Statusbar, 3, (i+1)*10,0,0,n1)
          
          ; on redimensionne nos calques (images et bm)
          If IsImage(layer(i)\ImageTemp)
            ResizeImage(layer(i)\ImageTemp,doc\w,doc\h)
          EndIf
          ResizeImage(layer(i)\Image,doc\w,doc\h)
          If IsImage(layer(i)\ImageBM)
            ResizeImage(layer(i)\ImageBM,doc\w,doc\h)
          EndIf
          
          FreeSprite(layer(i)\Sprite)
          Layer(i)\Sprite = CreateSprite(#PB_Any,doc\w,doc\h,#PB_Sprite_AlphaBlending)
          Layer(i)\w = doc\w
          Layer(i)\h = doc\h
          Layer(i)\NewW = doc\w
          Layer(i)\NewH = doc\h
          Layer_Update(i)
        Next i 
        
      Else 
        ;{ on agrandit/diminue la surface de travail 
        
        ;Debug "canvas resize ! "
        
        StatusBarProgress(#Statusbar, 3, 5)
        
        ; on crée des images temporaires, on va dessiner dessus chaque calque image et calque BM
        ; puis, on effacera les calque (image et bm) et on redessinera l'image orginal 
        ; (non agrandie, car on ne fait qu'agrandir le canvas, pas l'image complète
        
        Tmp = CreateImage(#PB_Any,doc\w,doc\h,32,#PB_Image_Transparent)
        TmpBm = CreateImage(#PB_Any,doc\w,doc\h,32,#PB_Image_Transparent)
        
        If Tmp > 0 And TmpBm > 0
          
          For i=0 To n
            
            ;Debug i
            
            StatusBarProgress(#Statusbar, 3, (i+1)*10,0,0,n1)
            
            ; d'abord, on sauve les images et imageBm
            If StartDrawing(ImageOutput(Tmp))
              DrawingMode(#PB_2DDrawing_AllChannels)
              Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
              DrawingMode(#PB_2DDrawing_AlphaBlend)
              DrawAlphaImage(ImageID(layer(i)\Image),0,0)
              StopDrawing()          
            EndIf
            If StartDrawing(ImageOutput(TmpBm))
              DrawingMode(#PB_2DDrawing_AllChannels)
              Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
              DrawingMode(#PB_2DDrawing_AlphaBlend)
              DrawAlphaImage(ImageID(layer(i)\ImageBM),0,0)
              StopDrawing()          
            EndIf
            
            ; puis, on redimensionne nos calques (images et bm)
            ResizeImage(layer(i)\Image,doc\w,doc\h)
            ResizeImage(layer(i)\ImageBM,doc\w,doc\h)
            
            ; puis, on les efface et on redessine dessus
            If StartDrawing(ImageOutput(layer(i)\Image))
              DrawingMode(#PB_2DDrawing_AllChannels)
              Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
              DrawingMode(#PB_2DDrawing_AlphaBlend)
              DrawAlphaImage(ImageID(Tmp),0,0)
              StopDrawing()          
            EndIf
            If StartDrawing(ImageOutput(layer(i)\ImageBM))
              DrawingMode(#PB_2DDrawing_AllChannels)
              Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
              DrawingMode(#PB_2DDrawing_AlphaBlend)
              DrawAlphaImage(ImageID(TmpBm),0,0)
              StopDrawing()          
            EndIf
            
            FreeSprite2(layer(i)\Sprite)
            layer(i)\Sprite = CreateSprite(#PB_Any,doc\w,doc\h,#PB_Sprite_AlphaBlending)
            
            Layer(i)\w = doc\w
            Layer(i)\h = doc\h
            
            Layer_Update(i)
            ;Debug "size : " +Str(ImageWidth(layer(layerid)\Image))+"/"+Str(layer(layerId)\Image)
          Next i 
          
          ; on supprime les images temporaires
          
          FreeImage2(Tmp)
          FreeImage2(TmpBm)
          
        EndIf  
        
        ;}
        
      EndIf  
      
      
    EndIf
    
    NewPainting = 1
    StatusBarProgress(#Statusbar, 3, n1-10,0,0,n1)
    ScreenUpdate(1)
    StatusBarProgress(#Statusbar, 3, n1,0,0,n1)
    IE_StatusBarUpdate()
    
    ;Debug "New size : "+Str(doc\w)+"/"+Str(doc\h)
    
  EndIf

EndProcedure
Procedure CropDoc()
  
  x = OptionsIE\SelectionX
  y = OptionsIE\SelectionY
  w = OptionsIE\SelectionW
  h = OptionsIE\SelectionH
  
  If w > 0 And h > 0 And w-x>0 And h-y>0
    
    Doc\w = w ; - x
    Doc\h = h ; - y
    
    ;Debug Str(x)+"/"+Str(y)
    
    ;x - canvasX
    ;y - canvasY
    
    w1 = doc\w
    h1 = doc\h
    
    n = ArraySize(layer())
    n1 = (n+1)*10 +20
    StatusBarProgress(#Statusbar,3,5,5,0,n1)
    
    StatusBarProgress(#Statusbar, 3, 5)
    
    ; on crée des images temporaires, on va dessiner dessus chaque calque image et calque BM
      
      For i=0 To n
        
        StatusBarProgress(#Statusbar, 3, (i+1)*10,0,0,n1)
        
        tmp = GrabImage(layer(i)\Image,#PB_Any,x,y,w1,h1)
        tmpBM = GrabImage(layer(i)\ImageBM,#PB_Any,x,y,w1,h1)
        
        If Tmp > 0 And TmpBm > 0
        FreeImage2(layer(i)\Image)
        FreeImage2(layer(i)\ImageBM)
        
        layer(i)\Image = GrabImage(tmp,#PB_Any,0,0,w1,h1)
        layer(i)\ImageBM = GrabImage(tmpBM,#PB_Any,0,0,w1,h1)
        
        ;{ old
        ;             ; d'abord, on sauve les images et imageBm
        ;             If StartDrawing(ImageOutput(Tmp))
        ;               DrawingMode(#PB_2DDrawing_AllChannels)
        ;               Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
        ;               DrawingMode(#PB_2DDrawing_AlphaBlend)
        ;               DrawAlphaImage(ImageID(layer(i)\Image),x,y)
        ;               StopDrawing()          
        ;             EndIf
        ;             If StartDrawing(ImageOutput(TmpBm))
        ;               DrawingMode(#PB_2DDrawing_AllChannels)
        ;               Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
        ;               DrawingMode(#PB_2DDrawing_AlphaBlend)
        ;               DrawAlphaImage(ImageID(layer(i)\ImageBM),x,y)
        ;               StopDrawing()          
        ;             EndIf
        ;             
        ;             ; puis, on redimensionne nos calques (images et bm)
        ;             ResizeImage(layer(i)\Image,doc\w,doc\h)
        ;             ResizeImage(layer(i)\ImageBM,doc\w,doc\h)
        ;             
        ;             ; puis, on les efface et on redessine dessus
        ;             If StartDrawing(ImageOutput(layer(i)\Image))
        ;               DrawingMode(#PB_2DDrawing_AllChannels)
        ;               Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
        ;               DrawingMode(#PB_2DDrawing_AlphaBlend)
        ;               DrawAlphaImage(ImageID(Tmp),0,0)
        ;               StopDrawing()          
        ;             EndIf
        ;             If StartDrawing(ImageOutput(layer(i)\ImageBM))
        ;               DrawingMode(#PB_2DDrawing_AllChannels)
        ;               Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
        ;               DrawingMode(#PB_2DDrawing_AlphaBlend)
        ;               DrawAlphaImage(ImageID(TmpBm),0,0)
        ;               StopDrawing()          
        ;             EndIf
        ;             
        ;}
        
        
        FreeSprite2(layer(i)\Sprite)
        layer(i)\Sprite = CreateSprite(#PB_Any,w1,h1,#PB_Sprite_AlphaBlending)
        
        Layer(i)\w = doc\w
        Layer(i)\h = doc\h
        
        Layer_Update(i)
        ;Debug "size : " +Str(ImageWidth(layer(layerid)\Image))+"/"+Str(ImageHeight(layer(layerId)\Image))
         ; on supprime les images temporaires
        FreeImage2(Tmp)
        FreeImage2(TmpBm)
        EndIf
        
      Next i 
    
    ; puis, on met à jour
    NewPainting = 1
    StatusBarProgress(#Statusbar, 3, n1-10,0,0,n1)
    ScreenUpdate(1)
    StatusBarProgress(#Statusbar, 3, n1,0,0,n1)
    IE_StatusBarUpdate()

    
  EndIf
  
  
   OptionsIE\SelectionX =0
   OptionsIE\SelectionY =0
   OptionsIE\Selection =0
   OptionsIE\SelectionW =0
   OptionsIE\SelectionH =0
   DisableMenuItem(0, #menu_Crop, 1)
   
  
EndProcedure

Procedure TrimDoc(img,crop=0)
  
  w=ImageWidth(img)
  h=ImageHeight(img)
  
  Dim x(3)
  x(0) = w
  x(1) = h
  
  If StartDrawing(ImageOutput(img))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
  ; on calcule x et Y et W et H pour recadrer l'image avec en enlevant les bordures alpha.
  For u=0 To 3    
    For i =0 To w-1
      For j=0 To h-1
        
        col=Point(i,j)        
        If Alpha(col) >0
          
          Select u 
              
            Case 0 ; x
              If i < x(0)
                x(0) = i
                If i=0
                  Break
                EndIf
              EndIf 
              
            Case 1 ; y
              If j < x(1)
                x(1) = j
                If j=0
                  Break
                EndIf
              EndIf 
              
            Case 2 ; w
              If i > x(2)
                x(2) = i
                If i=w-1
                  Break
                EndIf                
              EndIf 
              
            Case 3 ; h
              If j > x(3)
                x(3) = j
                If j=h-1
                  Break
                EndIf                
              EndIf 
              
          EndSelect
        EndIf
        
      Next
    Next
  Next
  StopDrawing()
EndIf

  If crop=0
    tempimg = GrabImage(img,#PB_Any,x(0),x(1),x(2)-x(0),x(3)-x(1))  
    ProcedureReturn tempimg 
  Else     
    OptionsIE\SelectionX = x(0)
    OptionsIE\SelectionY = x(1)
    OptionsIE\SelectionW = x(2)-x(0)
    OptionsIE\SelectionH = x(3)-x(1)
    CropDoc()    
  EndIf
  
  
 
EndProcedure
;}

;{ selection

Procedure SelectionSet()
  
  
  If StartDrawing(ImageOutput(layer(layerId)\Image))
    
    
    
    
    StopDrawing()
  EndIf
  
    
EndProcedure


;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 596
; FirstLine = 16
; Folding = AABYAAAAAAAAAAAAgAAeAAAAAAAA9
; EnableXP
; Executable = ..\..\animatoon0.52.exe
; EnableUnicode