

#ProgramName = "Drawer"
#ProgramDate = "11 june 2015"
#ProgramVersion = "0.14"

#Statusbar = 0

Enumeration ; windows
  #Window_imageEditor 
EndEnumeration

Enumeration ; gadgets
  
  #Imagegadget
  #canvas  
  #textinfo
  
  
  ; canvas et scrollarea
  #G_SA_forcanvas
  
  
  ; pour des tests
  #G_ImageDessus1
  #G_ImageDessus2
  #G_ImageDessus3
  
  
  ; tools
  #G_PanelTool
    
  #G_BrushPas
  #G_BrushAlpha
  #G_BrushAlphaPressure
  #G_BrushSize
  #G_BrushSizePressure
  #G_BrushScatter
  #G_BrushColor
  #G_BrushTransition
  
  #G_Preview
  
  ; layer
  #G_PanelLayer
  #G_LayerList
  #G_LayerAdd
  #G_LayerDel
  #G_LayerDuplicate
  #G_LayerAlpha
  #G_LayerView
  
  ; toolbar
  #G_ToolBar
  
  ; Buttons tools
  #G_IE_Pen
  #G_IE_Brush
  #G_IE_Spray
  #G_IE_Tampon
  #G_IE_Particles
  #G_IE_Line
  #G_IE_Box
  #G_IE_Circle
  #G_IE_Shape
  #G_IE_Fill
  #G_IE_Pipette
  #G_IE_Gradient
  #G_IE_Eraser
  #G_IE_Select
  #G_IE_Move
  #G_IE_Hand
  #G_IE_Zoom
  #G_IE_Clear
  
  ; le type de Tools
  #G_IE_Type
    
EndEnumeration

Enumeration ; menu
  
  ; file
  #menu_New
  #Menu_Open
  #menu_Save
  #menu_SaveAs
  #Menu_Export
  #Menu_ExportAll
  #Menu_ExportAllZip
  #Menu_Import
  #Menu_Exit
  
  ; edition
  #Menu_Undo
  #Menu_Redo
  #Menu_Clear
  
  ; layer
  #Menu_LayerAdd
  #Menu_LayerDel
  #Menu_LayerDuplicate
  #Menu_LayerMoveDown
  #Menu_LayerMoveUp
  #Menu_LayerMergeDown
  #Menu_LayerMergeAllVisible
  
  ; Help
  #Menu_about
  
EndEnumeration

Enumeration ; image
  
  #ImageTablet 
  #ImageColor 
  #ImageLayer
  #ImageLayerUnder
  #ImageLayerOver

  #ImageExport
  #ImagePreview
  
  #IMAGE_BrushPreview
  
  ;{ icone
  #ico_New
  #ico_Open
  #ico_Save
  #ico_Ok
  
  #ico_IE_Pen
  #ico_IE_Brush
  #ico_IE_Line
  #ico_IE_Box
  #ico_IE_Circle
  #ico_IE_Fill
  #ico_IE_Clear
  #ico_IE_Pipette
  #ico_IE_Spray
  #ico_IE_Tampon
  #ico_IE_Eraser
  #ico_IE_Move
  #ico_IE_Shape  
  #ico_IE_Zoom  
  #ico_IE_Hand  
  #ico_IE_Select  
  #ico_IE_MagicWind  
  #ico_IE_Particles  
  #ico_IE_Gradient
  
  
  ; layer icone
  #ico_LayerLocked
  #ico_LayerView
  #ico_LayerLockPaint
  #ico_LayerLockMove
  #ico_LayerLockAlpha
  #ico_LayerDown
  #ico_LayerUp
  
  ;toolbar spriteeditor
  #ico_OpenIE
  #ico_AddSubImg
  #ico_DelSubImg
  #ico_NextSubImg
  #ico_PreviousSubImg
  
  ;}
  
  
  ; test
  #Img_dessus1
  #Img_dessus2
  #Img_dessus3
  
EndEnumeration

Enumeration ; ToolType
  
  ; pour les outils, le type d'outil
  ; attention, ça doit être dans le même ordre que sur le combobox "caractéristique de l'outil" 
  ; ou type de l'outil, dans AddtoolbarIE()
  #ToolType_Brush
  #ToolType_Pen
  #ToolType_Eraser
  #ToolType_Shape
  #ToolType_Water
  #ToolType_Smudge
  #ToolType_Glass
  #ToolType_Noise
  #ToolType_Pixel
  #ToolType_Blur
    
EndEnumeration

Enumeration ; BlendMode
  
  ; must be in the same order as the gadget of blendmode layer
  #Bm_Normal  
  #Bm_Multiply
  #Bm_Add
  #Bm_Screen 
  #Bm_Overlay
  #Bm_Inverse  
  #Bm_ColorBurn
  #Bm_Dissolve
  #bm_Difference
  #bm_Exclusion
  #Bm_Darken
  #Bm_Lighten
  #Bm_Hardlight
  #Bm_Clearlight
  #Bm_Colorlight
  
  
  
  ; Not used yet
  #Bm_Saturation
  #Bm_Color  
  #Bm_VividLight
  #Bm_ColorDodge  
  #Bm_LinearBurn
  


EndEnumeration


; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 5
; Folding = A+
; EnableUnicode
; EnableXP