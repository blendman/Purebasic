
; Application
#ProgramName      = "Animatoon"
#ProgramAuteur    = "Blendman"

#Statusbar = 0

;{ divers et numero unique
#ZipFile = 0
#thickness = 6
;}

;{ colors
#COLOR_SPECTRUM_SIZE_MAX = 255

#White2 = 16777215
#Black2 = 0
;}

;{ police & texte
Enumeration 
  
  #fnt_Arial8
  #fnt_Arial10  
  #fnt_Arial8Bold
  #fnt_Arial12
  #fnt_Arial10BoldItalic
  #fnt_Arial12Italic
  #fnt_Arial11
  
  #Font_last
EndEnumeration

LoadFont(#fnt_Arial8, "Arial.ttf", 8)
LoadFont(#fnt_Arial8Bold, "Arial.ttf", 8,#PB_Font_Bold)
LoadFont(#fnt_Arial10, "Arial.ttf", 10)
LoadFont(#fnt_Arial12, "Arial.ttf", 12)
LoadFont(#fnt_Arial10BoldItalic, "Arial.ttf", 10,#PB_Font_Bold|#PB_Font_Italic)
LoadFont(#fnt_Arial12Italic, "Arial.ttf", 12,#PB_Font_Italic)
LoadFont(#fnt_Arial11, "Arial.ttf", 11)



#MaxTxt=500
;}

Enumeration ; windows
  
  #WinMain
  #Win_Intro
  
  ; autre
  #Win_New
  #winNewTileset
  #Win_Pref
    
  
  #Win_Layer
  #Win_Swatch
  
  ; reglages images
  #Win_Contrast
  #Win_BalCol
  #Win_Level
  
  
  #Win_Exit
  #Win_About
  
EndEnumeration

Enumeration ; images
  
  ; on garde 100 images pour les 100 calques ?
  
  #Img_Zero
  ; = 100
  
  #BrushOriginal  = 10
  #BrushCopy
  #BrushCopyRot
  #BrushCopyRot2
  #BrushCopyResiz
  
  #Img_Intro
  
  #Img_Paper
  #ImageTablet
  #ImageExport
  #Img_Checker
  
  ; image pour les couleurs
  #ImageColorBG
  #ImageColorFG
  #Image_ColorArcEnCiel
  #IMAGE_ColorSelector
  #IMAGE_CursorColSeL
  
  
  #Img_PreviewBrush
  
  ; image pour les layers dessus, dessous (pas utilisé ?)
  #Img_dessus1
  #ImageLayerUnder
  #ImageLayerOver
  
  ; ui
  ;#Img_Pan_FondLayer
  ;#Img_Pan_layerVue
  ;#Img_Pan_LayerLock
  ;#Img_Pan_FondLayerSel
  
  #Img_LayerCenterSel
  #Img_LayerCenter
  #ico_LayerEye
  
  ; panel
  #image_RB
  
  
    ;{ icone
  #ico_New
  #ico_Open
  #ico_Save
  #ico_saveAs
  #ico_Merge
  #ico_Export
  #ico_Ok
  #ico_Prop
  
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
  #ico_IE_Scale
  #ico_IE_Shape  
  #ico_IE_Zoom  
  #ico_IE_Hand  
  #ico_IE_Select  
  #ico_IE_MagicWind  
  #ico_IE_Particles  
  #ico_IE_Gradient
  #ico_IE_Rotate
  #ico_IE_Text
  
  ; animation
  #ico_IE_Oignon
  #ico_IE_Add
  #ico_IE_Del
  #ico_IE_Play
  #ico_IE_Stop
  
  ; layer icone
  #ico_LayerLocked
  #ico_LayerView
  #ico_LayerLockPaint
  #ico_LayerLockMove
  #ico_LayerLockAlpha
  #ico_LayerDown
  #ico_LayerUp
  #ico_LayerMask
  ;}
  
  #Img_saveImage
  
  
  
  
  ; window new
;   #ImgAboutCredit
   #Img_About
  
   
   #Img_AlphaSel
   
  #Img_Max
  
EndEnumeration

Enumeration ; sprite
  
  #Layeractif = 50
  
  ; les sprites pour les brushs
  #Sp_BrushOriginal = 100
  #Sp_BrushCopy
  
  ; les sprites pour l'affichage : paper, texture, grid, selection, repère, marker, perspective, cadre, etc..
  #Sp_Paper
  #Sp_PaperColor
  ;#Sp_Texture
  #Sp_Grid
  ;#Sp_Repere
  ;#Sp_Marker
  #Sp_Select
  #Sp_Center
  
  
  ; les sprites que j'utilise ensuite pour les images par exemple
  #Sp_ToSaveImage
  
  #Sp_LayerTempo
  
  #Sp_CopyForsave
  
  
  #sp_max = 1000
  
EndEnumeration

Enumeration ; Menu
  
  #Menu_Main
  #Menu_Layer
  #Menu_LayerBM
  
EndEnumeration

Enumeration ; menuItem
  
  ;{ Window Main
  
  ; file
  #menu_New
  #Menu_Open
  #Menu_OpenImage
  #menu_Save
  #menu_SaveAs
  #Menu_SaveImage
  #Menu_Export
  #Menu_ExportAll
  #Menu_ExportAllZip
  #Menu_Import
  #Menu_Pref
  #Menu_Exit
  
  ; edition
  #Menu_Undo
  #Menu_Redo
  #Menu_Clear
  #Menu_Paste
  #Menu_Cut
  #Menu_Copy
  #Menu_Fill
  #Menu_FillPatern
  #Menu_FillAll
  #Menu_MirorH
  #Menu_MirorV
  
  ; view
  #menu_IE_Grid
  #menu_Marker
  #menu_Rules  
  #menu_IE_ZoomPlus
  #menu_IE_ZoomMoins
  #menu_IE_Zoom50
  #menu_IE_Zoom100
  #menu_IE_Zoom200
  #menu_IE_Zoom300
  #menu_IE_Zoom400
  #menu_IE_Zoom500
  #menu_IE_Zoom1000
  #Menu_RealTime
  #Menu_ResetCenter
  #Menu_CenterView
  #menu_ChangeCenter
  #menu_ScreenRedraw
  #menu_ScreenQuality
  #menu_ShowStatus
  #menu_ShowLayer

  
  ; Selection
  #Menu_SelectAll
  #Menu_DeSelect
  #Menu_SelExtend
  #Menu_SelContract
  #Menu_SelInverse
  
  ; image
  #Menu_ResizeDoc
  #Menu_ResizeCanvas
  ;#menu_IE_ImageSize
  ;#menu_IE_CanvasSize
  #menu_Crop  
  #menu_Trim
  #menu_Rotate90
  #menu_Rotate180
  #menu_Rotate270
  #menu_RotateFree
  #menu_ColorBalance
  #menu_InverseColor
  #menu_Desaturation
  #menu_Constrast
  #menu_Level
  #menu_Posterize
  #menu_Edge
  
  ; layer
  #Menu_LayerAdd
  #Menu_LayerDel
  #Menu_LayerDuplicate
  #Menu_LayerMoveDown
  #Menu_LayerMoveUp
  #Menu_LayerMergeDown
  #Menu_LayerMergeAllVisible
  #Menu_LayerMergeAll
  #Menu_LayerMergeLinked
  #Menu_LayerRotate
  
  
  ; Actions
  #Menu_ActionSave
  #Menu_ActionStop
  #Menu_ActionRun
  
  
  ; filters
  #menu_IE_Noise
  #menu_IE_Clouds
  #Menu_IE_Blur
  #Menu_IE_Sharpen
  #Menu_IE_SharpenAlpha
  #menu_IE_Offset

  ; Help
  #Menu_about
  #Menu_Infos
  
  ;}
  
  ;{  popmenu layer ; comme layer type
  #Menu_Layer_Normal
  #Menu_Layer_Text
  #Menu_Layer_BG
  #Menu_Layer_Shape
  #Menu_Layer_Group
  ;}
  
  
  #Menu_Last ; the last meni id !
EndEnumeration

Enumeration ; gadgets
  
  #G_0
  #G_1
  
  ;{-- Window main
    
  ;{ toolbar
  #G_ToolBar
  ; le type de Tools
  #G_IE_Type

  ;{ Buttons tools (sur toolbar)
  
  #G_IE_Pen ; toujours premier des outils
  #G_IE_Brush
  #G_IE_Spray
  #G_IE_Tampon
  #G_IE_Particles
  
  #G_IE_Line
  #G_IE_Box
  #G_IE_Circle
  #G_IE_Shape
  #G_IE_Gradient
  #G_IE_Fill
  
  #G_IE_Text
  
  #G_IE_Eraser
  #G_IE_Clear
  
  #G_IE_Pipette  
  
  #G_IE_Select
  #G_IE_Move
  #G_IE_Transform  
  #G_IE_Rotate
  
  
  
  #G_IE_Hand
  #G_IE_Zoom ; toujours dernier des outils
             ;}
  
  ;}
  
  ; canvas, si version canvas
  #G_SA_forcanvas
  #G_CanvasMain
  
  ; container pour le screen
  #G_ContScreen
  
  ; splitters
  #G_SplitLayerRB ; roughboard/layer
  #G_SplitToolCol ; tool/color
  #G_SplitToolScreen ; tool-color/screen
  #G_SplitScreenLayer ; screen/Layer-swatch
    
  
  
  
  ;{ les paramètres des outils
  ; tools
  #G_PanelTool
  
  #G_BrushTool
  
  ;--- By TOOL
  
  #G_ConfirmAction ; for all action, if needed
  
  ;{ Tool brush, eraser, pen
  #G_Cont_Brush ; container pour les parametres de l'outil brush, eraser, pen
  
  
  #G_FirstParamBrush ; attention, toujours le garde en premier pour les paramètres des brush
    
    ;size
  #G_FrameSize
  #G_BrushSize
  #G_BrushSizeMin
  #G_BrushSizeW
  #G_BrushSizeH
  #G_BrushSizeRand
  #G_BrushSizePressure
  #G_BrushSizeVsTime
  #G_BrushSizeTransition
  
  ; alpha
  #G_FrameAlpha
  #G_BrushAlpha 
  #G_BrushAlphaMin
  #G_BrushAlphaPressure
  #G_BrushAlphaFactorVsTime
  #G_BrushTraVsTime
  #G_BrushAlphaRand
  
  ; aspect 
  #G_FrameAspect
  #G_brushHardness
  #G_brushSoftness
  #G_brushIntensity
  #G_brushSmooth
  
  ; stroke (trait)
  #G_FrameStroke
  #G_brushTrait
  #G_BrushPas
  #G_BrushType
  #G_BrushTransition
  #G_BrushLineType ; normal, droite
  #G_BrushStroke
  #G_BrushStyle
  #G_BrushCurve
  #G_BrushStrokeTyp
  
    ; image
  #G_FrameBrushImage
  #G_BrushPrevious
  #G_BrushNext
  #G_BrushPreview
  #G_BrushTrim
    
  ; dyn (rot, scatter)
  #G_FrameRot
  #G_BrushRotate
  #G_BrushRandRotate
  #G_BrushRotateAngle
  #G_FrameScatter  
  #G_BrushScatter
  
    ; misc
  #G_FrameMisc
  #G_BrushSymetry

  
  ; color
  #G_FrameWater
  #G_FrameColor
  #G_BrushMix
  #G_BrushMixTyp
  #G_BrushVisco
  #G_BrushLavage
  #G_BrushWater
  #G_BrushMixLayer
  #G_BrushMixLayerCustom
  
  ; filter
  #G_BrushFilter
  
  
  #G_LastParamBrush ; toujours en dernier pour les paramètres des Tools
  ;}
  
  ;{ Tool Move Layer, Transform, rotate
  #G_ActionX
  #G_ActionY
  #G_ActionAngle
  #G_ActionW
  #G_ActionH
  #G_ActionXLock
  #G_ActionYLock
  ;}
  
  ;{ Tool Box, gradient, line, ellipse, shape
  
  #G_ActionTyp
  #G_ActionFullLayer
  #G_ActionOutlined
  #G_ShapeParam1
  ;}
  
  
  #G_tmpCanvascolor
  
  
  ; autres containers
  #G_Cont_Fill
  #G_Cont_Gradient
  #G_Cont_Box
  #G_Cont_Circle
  #G_Cont_Tampon
  #G_Cont_Particles
  #G_Cont_Select
  #G_Cont_MagicWind
  ;}
  
  ;{ panel color (selector)
    #G_PanelCol
  #G_BrushColorBG
  #G_BrushColorFG
  #G_ColorArcEnCielSelect
  #G_ColorArcEnCiel
  #G_ColorSelector
  #GADGET_ColorTxtR
  #GADGET_ColorTxtG
  #GADGET_ColorTxtB
;}
  
    
  ;{ layer
  #G_PanelLayer
  #G_Layer
  #G_LayerList
  #G_LayerDuplicate
  #G_LayerAlpha
  #G_LayerAlphaSpin
  #G_LayerBM
  
  #G_LayerView
  #G_LayerLocked
  #G_LayerLockMove
  #G_LayerLockPaint
  #G_LayerLockAlpha
  
  #G_LayerAdd
  #G_LayerDel
  #G_LayerMoveup
  #G_LayerMovedown
  #G_LayerMaskAlpha
  #G_LayerGroup
  #G_LayerAdjust
  #G_LayerProp
  
  #G_layerbm1 ; temporaire
  #G_layerbm2 ; temporaire
  
  ;}
  
  ;{ presets
  #G_PresetTG
  #G_PresetReloadBank
  #G_PresetChangeBank
  #G_PresetSavePreset
  #G_PresetSavePresetAs
  #G_PresetName
  ;}
    
  ;{ options
  #G_ListPaper
  #G_PaperAlpha
  #G_PaperAlphaSG ; stringgadget
  #G_PaperAlphaName
  #G_PaperColor
  #G_PaperScale
  #G_PaperScaleSG
  #G_PaperScaleName
  #G_PaperIntensity
  #G_PaperIntensitySG
  #G_PaperIntensityName
  ;}
  
  ;{ swatch, roughboard, gradient
  
  #G_PanelSwatch
  
  ; swatch
  #G_SA_Rb
  #G_RoughtBoard
  #G_RBPaint
  #G_RBNew
  #G_RBOpen
  #G_RBSave
  #G_RBExport
  
  ; Swatch
  #G_SA_Swatch
  #G_Swatch ; scroll area
  #G_SwatchCanvas
  #G_SwatchNew
  #G_SwatchMerge
  #G_SwatchOpen
  #G_SwatchSave
  #G_SwatchExport
  #G_SwatchEdit
  
  ; gradient
  #G_SA_Gradient
  #G_Gradient
  ;}
  
  ;}
    
  ;{-- Window swatch
  #G_WinSwatchScroll
  #G_WinSwatchCanvas
  #G_WinSwatchNbCol
  #G_WinSwatchNameSwatch
  #G_WinSwatchName
  #G_WinSwatchSave
  #G_WinSwatchNew
  #G_WinSwatchOpen
  #G_WinSwatchMerge
  #G_WinSwatchFromImg
  #G_WinSwatchAdd
  #G_WinSwatchDel
  #G_WinSwatchInsert
  #G_WinSwatchSort
  #G_WinSwatchExport
  
  ;}
  
  
  ;{**** window par menu
    
  
  ;{-- MENU FILE
  
  ;{ window newDOC
  #GADGET_WNewTile
  #GADGET_WNewBtnOk
  #GADGET_WNewW
  #GADGET_WNewH
  ;}
    
  ;{ window preference
  #G_PrefPanel
    
  #G_Frame_Lang
  #G_Cob_Lang
  #G_Pref_AutoSave
  #G_Pref_AskWhenExit
  
  ; grille
  #G_GridW
  #G_GridH
  #G_GridColor
  
  ; brush
  #G_BrushPreset_Save_color
  
  ; animation
  #G_WAnim_CoBFrameTimeline
  #G_WAnim_CBTimelineBar
  #G_WPref_SizeFrame

  ;}
  
  ;}  
  
  ;{-- MENU IMAGES
    ; color balance    
    #IE_BalColNormal
    #IE_BalColNew
    #IE_BalColRed
    #IE_BalColGreen
    #IE_BalColBlue
    #IE_BalColOk
    
    ; Constrats
    #IE_ContrastOk
    #IE_ContrastTB
    #IE_ContrastSG
    #IE_BrightnessTB
    #IE_BrightnessSG

  ;}
  
  ;{-- MENU HELP
  
  ;{ window About  
  #GADGET_WAboutImage
  #GADGET_WAboutImageCredit
  #GADGET_WAboutSA
  #GADGET_WAboutBtnOk
  ;}

  
  ;}
  
  
  ;}
  
  
  
  #G_LastGadget
  
EndEnumeration

;{ taille gadgets ; some gadget size
#GetColor_ArcEnCiel_L = 20
#GetColor_ArcEnCiel_W = 128
#GetColor_ArcEnCiel_H = 128
;}

Enumeration ; BlendMode
  
  ; must be in the same order as the gadget of blendmode layer
  #Bm_Normal 
  
  ; dark
  #Bm_Darken
  #Bm_Multiply
  #Bm_ColorBurn
  #Bm_LinearBurn
  
  ; light
  #Bm_Add
  #Bm_Screen 
  #Bm_Lighten
  #Bm_Hardlight
  #Bm_Clearlight
  #Bm_Colorlight
  
  ; medium
  #Bm_Overlay
  #Bm_LinearLight
  
  ; invers
  #Bm_Inverse 
  
  #Bm_Overlay2
  
  #Bm_Dissolve
  #bm_Difference
  #bm_Exclusion
  
  ; color
  #Bm_Saturation
  #Bm_Color
  
  ; Not used yet
  #Bm_VividLight
  #Bm_ColorDodge 
  
  #Bm_Custom ; pour tester les blendmode
  
EndEnumeration

Enumeration ; Layer Set BM
  
  ; ajouter les autres bm qd on les aura
  #SetBm_normal
  
  #SetBm_Darken
  #SetBm_multiply
  #SetBm_ColorBurn
  #SetBm_LinearBurn
  
  #SetBm_Add
  #SetBm_Screen
  #SetBm_Lighten
  #SetBm_ClearLight
  
  #Setbm_Overlay
  #SetBm_LinearLight
  
  #SetBm_Invert
  #SetBm_Overlay2
  
  #SetBm_Custom
  
EndEnumeration

Enumeration ; action qu'on effectue sur le calque
  
  ; doivent être identique à l'organisation des gadgets outils (dans IE_GadgetAdd() (gadgets.pbi)
  ; ainsi que Enumeration gadget/bouton toolbar
  
  #Action_Pen
  #Action_Brush
  #Action_Spray
  #Action_Tampon
  #Action_Particles
  
  #Action_Line
  #Action_Box
  #Action_Circle
  #Action_Shape
  #Action_Gradient  
  #Action_Fill
  
  #Action_Text

  #Action_Eraser
  #Action_Clear
  
  #Action_Pipette  
  
  
  #Action_Select
  #Action_Move
  #Action_Transform
  #Action_Rotate
  
  #Action_Hand
  #Action_Zoom
  
EndEnumeration

Enumeration ; ToolType
  
  ; pour les outils, le type d'outil
  ; attention, ça doit être dans le même ordre que sur le combobox "caractéristique de l'outil" 
  ; ou type de l'outil, dans AddtoolbarIE()
  #ToolType_Brush
  #ToolType_Pen
  #ToolType_Eraser
  #ToolType_Light
  #ToolType_Dark
  #ToolType_Color
  #ToolType_Shape
  #ToolType_Water
  #ToolType_Smudge
  #ToolType_Glass
  #ToolType_Noise
  #ToolType_Pixel
  #ToolType_Blur
  #ToolType_Sol
  #ToolType_Line
  
EndEnumeration

Enumeration ; stroke style
  
  #Stroke_Rough ; blendman line,  not great
  #Stroke_Knife ; LSI thickline
  #Stroke_Dash  ; HB Dashdraw
  #Stroke_LineAA ; by lsi
  
  
  
  #Stroke_Gersam ; Gersam (G-rom & Falsam line)
  
  
EndEnumeration

Enumeration ; layer type
  
  #Layer_TypBitmap ; toujours en premier = 0
  #Layer_TypText
  #Layer_TypBG  
  #Layer_TypShape
  #Layer_TypGroup
  #Layer_TypVecto
  
EndEnumeration

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 66
; FirstLine = 12
; Folding = QAAAAAw
; EnableXP
; EnableUnicode