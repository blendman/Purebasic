

;{ for tablet

Structure LOGCONTEXTA
  lcName.b[40];
  lcOptions.l;
  lcStatus.l;
  lcLocks.l;
  lcMsgBase.l;
  lcDevice.l;
  lcPktRate.l;
  lcPktData.l;
  lcPktMode.l;
  lcMoveMask.l;
  lcBtnDnMask.l;
  lcBtnUpMask.l;
  lcInOrgX.l;
  lcInOrgY.l;
  lcInOrgZ.l;
  lcInExtX.l;
  lcInExtY.l;
  lcInExtZ.l;
  lcOutOrgX.l;
  lcOutOrgY.l;
  lcOutOrgZ.l;
  lcOutExtX.l;
  lcOutExtY.l;
  lcOutExtZ.l;
  lcSensX.l;
  
  lcSensY.l;
  lcSensZ.l;
  lcSysMode.l;
  lcSysOrgX.l;
  lcSysOrgY.l;
  lcSysExtX.l;
  lcSysExtY.l;
  lcSysSensX.l;
  lcSysSensY.l;
EndStructure

Structure PACKET
  pkButtons.l
  pkX.l
  pkY.l
  pkZ.l
  pkNormalPressure.l
  pkTangentPressure.l
EndStructure

;{ Constantes tablet
#WTI_DEFCTX    = 3
#WTI_DEFSYSCTX = 4


#CTX_NAME          = 1
#CTX_OPTIONS      = 2
#CTX_STATUS        = 3
#CTX_LOCKS        = 4
#CTX_MSGBASE      = 5
#CTX_DEVICE        = 6
#CTX_PKTRATE      = 7
#CTX_PKTDATA      = 8
#CTX_PKTMODE      = 9
#CTX_MOVEMASK     = 10
#CTX_BTNDNMASK   = 11
#CTX_BTNUPMASK   = 12
#CTX_INORGX        = 13
#CTX_INORGY        = 14
#CTX_INORGZ        = 15
#CTX_INEXTX        = 16
#CTX_INEXTY        = 17
#CTX_INEXTZ        = 18
#CTX_OUTORGX      = 19
#CTX_OUTORGY      = 20
#CTX_OUTORGZ      = 21
#CTX_OUTEXTX      = 22
#CTX_OUTEXTY      = 23
#CTX_OUTEXTZ      = 24
#CTX_SENSX        = 25
#CTX_SENSY        = 26
#CTX_SENSZ        = 27
#CTX_SYSMODE      = 28
#CTX_SYSORGX      = 29
#CTX_SYSORGY      = 30
#CTX_SYSEXTX      = 31
#CTX_SYSEXTY      = 32
#CTX_SYSSENSX     = 33
#CTX_SYSSENSY     = 34
#CTX_MAX           = 34

#CXO_MESSAGES  = 4

#WT_DEFBASE    = $7FF0
#WT_PACKET     = #WT_DEFBASE + 0
#WT_INFOCHANGE = #WT_DEFBASE + 6

#PK_BUTTONS           = $0040 ;/* button information */
#PK_X                 = $0080 ;/* x axis */
#PK_Y                 = $0100 ;/* y axis */
#PK_Z                 = $0200 ;/* z axis */
#PK_NORMAL_PRESSURE   = $0400 ;/* normal Or tip pressure */
#PK_TANGENT_PRESSURE  = $0800 ;/* tangential Or barrel pressure */
;}

;}

;utile
Structure Vector2f
  x.f : y.f
EndStructure




; Script
Structure sEvent
  
  Event.i
  id.i
  Array param.i(0)
  
EndStructure 
Structure sScript ; les actions ou script
  
  Array event.sEvent(0)
  
EndStructure
Global Dim script.sScript(0)


; the options
Structure sOptions
  
  ; cursor
  CursorImgId.i
  CursorSpriteId.i
  CursorX.w
  CursorY.w
  CurSorW.w
  CursorH.w
  
  ; theme
  Lang$
  Theme$
  ThemeColor.i
  ThemeGadCol.i
  ThemeMenuCol.i
  ThemeTBCol.i
  ThemeStaCol.i
  
  
  Debbug.a
  Beta.a ; if we set beta= 1, we have acces to the beta features ?
  SpriteQuality.a
  SaveImageRT.a ; to use the save image in RealTime (screen)
  
  X.w
  Y.W
  
  
  ;{  Options for tools
  LockX.a
  LockY.a
  Proportion.a
  
  ; selection
  Selection.a
  SelectionX.w
  SelectionY.w
  SelectionW.w
  SelectionH.w
    
  ; shapes (box, circle...)
  Shape.a
  ShapeX.w
  ShapeY.w
  ShapeW.w
  ShapeH.w
  ShapeTyp.a
  ShapeParam.a
  ShapeFullLayer.a
  ;}
  
  ; general
  Name$
  Version$
  ModeAdvanced.a
  ConfirmAction.a
  ConfirmExit.a
  
  DoScript.a ; 1 = save, 2 = run
  NbScript.w
  
  ; save
  Autosave.a
  AutosaveTime.i
  ImageHasChanged.a
  
  ; Undo
  Maxundo.w
  UndoState.a ; max = 32
  
  ;{ UI 
  Statusbar.a
  
  ; toolbar
  ToolbarH.a
  ToolInfoH.a
  ToolbarFileY.a
  ToolbarFileX.w
  ToolBarFile.a
  ToolbarToolY.a
  ToolbarToolX.w
  ToolbarTool.a
  
  
  ; RB
  RB_Action.a
  RB_Img$
  
  ; swatch
  Swatch$
  SwatchName$
  SwatchColumns.a
  SwatchNbColumns.a
  
  ; bordure
  BordureX.w
  BordureY.w
  
  ; TOOLs
  PanelToolsW.w
  PanelToolsH.w
  NbTools.a
  
   ; animation, frame...
  SizeFrameW.w
  AnimBarre.a
    
  ; color  
  selectColor.a ; what is the selector color used ?
  
  
  ; Tools options

    
  ; PANEL LAYERS 
  ; PanelLayerW.w ; Panel Layer W
  ; PanelLayerH.w ; Panel Layer H
  
  ; PANEL colors
  ; PanelColorH.w
  
  
  ; PANEL OPTIOPNS
  AreaBGColor.i
  Paper$ ; the paper of the canvas
    
  ; Directory  
  DirPattern$
  DirPreset$
  DirBrush$
  
  ;}
  
  
   ; delays  
  Delay.w
  DelayMax.w
  
  
  ; view
  Grid.a
  GridW.w
  GridH.w
  GridColor.i
  
  ; Zoom
  Zoom.w
    
  
  ; layers
  AdjustLayerToImage.a
  LayerTyp.a ; the type of the layer we will create.
  ActionForAllLayers.a
  SelectAlpha.a ; si on a sélectionné l'alpha du calque
  
  ; Filtre
  NoiseDesat.a
  
  ; Document  
  ImageW.w
  ImageH.w
  RealTime.a
  UpdateScreenDelay.w
  
  ; path et file
  PathSave$
  PathOpen$
 
  
EndStructure
Global OptionsIE.sOptions


; template
Structure sTemplate ;  template de document
  nom$
  format$
  w.w
  h.w
  dpi.w
EndStructure


;{ the document
Structure sDoc
  ; par defaut
  w_def.w
  h_def.w 
  w.w 
  h.w
  name$
  dpi.w
EndStructure
Global Doc.sDoc
With doc
  \w = 1024
  \h = 768
  \w_def = 1024
  \h_def = 768 
  \name$ = "Untitled"
EndWith
;}


; for the presets
Structure sBrushGroup
  ; pour la Treegadget des presets
  group$
EndStructure
Global NewList BrushGroup.sBrushGroup()

Structure sColor1
  Color.i
  Alpha.a
EndStructure
Structure sColor
  R.a
  G.a
  B.a
  A.a
  H.l ; hue
  S.l ; saturation
  L.l ; luminence 
EndStructure

;{ brush - the brush structures
Structure Brush
  
  Name$
  Version.a ; la version d'animatoon 
  
  Type.a
  Brush.w
  Id.w ; le numero de l'image
  Image$
  Group$
  
  ; alpha
  Alpha.a : AlphaOld.a : alphaMax.a
  AlphaFG.a : AlphaBlend.w
  AlphaPressure.a
  AlphaFactorVsTime.w : AlphaVsTime.w
  AlphaRand.a : AlphaMin.a
  
  ; size
  Size.w 
  Sizepressure.a : SizeRand.w
  SizeW.w : sizeH.w
  SizeRndFactor.w : SizeMin.w
  SizeOld.w : SizeNew.w ; to see if the size has changed, if yes : I resize the image and set sizeOld = sizeNew.
  FinalSize.w ; needed for some action with pressure tablet
  
  
  Transition.a
  
  ; dynamics
  Scatter.w : ScatterMin.w
  
  Rotate.w : RotateMin.w
  RandRot.w : RotateParAngle.a
  
  ; rendu
  Hardness.a : Softness.a
  Intensity.w : Smooth.a
  Trim.a
  
  ; trait
  Pas.w : Trait.a
  StrokeTyp.a : Stroke.a

  
  ; position et taille
  X.w : Y.w
  W.w : H.w ; taille final après transformation, ne pas confondre avec SizeW et SizeH
  OldW.w : OldH.w ; nécessaire pour vérifier si on doit resize le brush
  
  ; le centre
  CenterX.w : CenterY.w
  CenterSpriteX.w : CenterSpriteY.w
  
  ; couleur
  Mix.w
  MixType.a ; le type de mélange : 1 = vers notre couleur à nouveau, 0= vers la couleur du fond
  MixFade.w ; pour le fade du mix
  Visco.w : ViscoCur.w
  Water.a
  Lavage.a ; lave-t-on le brush chaque fois qu'on relève la souris (il reprend la couleur originale)
  MixLayer.a
  
  ; pour le mixtype = 0
  Col.sColor
  ColorBG.sColor ; couleur qu'on a pris sur le couleur selector
  NewCol.sColor
  OldCol.sColor
  ColTmp.sColor ; couleur temporaire pas utilisé ?
  
  ColRnd.sColor ; random color
  
  ;on garde, car je m'en sers pour le mixtype = 1
  ColorOld.i ; pour le fade vers le mix
  ColorNext.i ; pour le fade vers le mix
  Color.i
  ColorQ.i ; couleur temporaire, avec mixing
  Randcolor.w
  
  ColorFG.i
  
  
  ; autres paramètres
  symetry.a
  Filter.a
  
  
  ; les actions et type d'outil
  Tool.a ; si brush = pinceau =>
  ; Action.a ; on peint, on déplace un calque, etc...
  
  
  ; l'image utilisé pour le brush
  BrushNum.w    ; le numéro du brush utilisé dans le dossier "data\brush..."
  BrushNumMax.w ; le nombre max de brush dans le dossier "data\brush..."
  BrushDir$     ; directory des brush
  BrushForm.a   ; circle, square

  KeepAlpha.a
  
  
  
  ; Spray
  Spray.w
  SprayForm.w
  NbSpray.a

  ; Particle
  
  ; pickers
  PickerAllLayers.a
  
  ;{ Box, circle
  ShapeOutSize.a
  ShapeOutline.a
  ShapePlain.a
  ShapeType.a     ; normal, round
  RoundX.w
  RoundY.w
  ;}
  
  ; Gradient
  GradientType.a

  
EndStructure
Global Dim brush.brush(#Action_Zoom)
Global Action.a = #Action_Brush  

With Brush(Action) ; define some parameters (no more used ?)
  \Id = 62
  \alpha = 100
  \alphaPressure = 0
  \size = 50
  \sizepressure = 1
  \pas = 30
  \transition = 1
  ;\Action = #Action_Brush
  \trait = 1
  \mix = 80
  \version = 6 ; 6th version ,  c'est la sixième version : GM/PB/teo/agk/pb2-optimised/pb_screen
EndWith
;}


; color, swatch
Structure sSwatch
  col.sColor
  Color.i
  x.w
  y.w
  name$
  img.i
  gadImg.i
EndStructure
Global Dim SwatchColor.sSwatch(0)


Structure sHsv
  h.f
  s.f
  v.f  
EndStructure
Structure Colour
  R.f
  G.f
  B.f  
EndStructure
Global HSV.sHsv



;{ les tiles
  
  ; taille des tiles
  Global Nx,Ny,Tw,NbTile
  Tw = 128
  Nx = Round(Doc\W/Tw,#PB_Round_Up)
  Ny = Round(Doc\H/Tw,#PB_Round_Up)
  NbTile = Nx * Ny
    
Structure stile
  x.w
  y.w
  image.i
EndStructure


;}


;{ for the layers
Structure sStyle
  
  Name$
  
  DropShadow.a
  DSColor.sColor1
  
  InnerShadow.a
  ISColor.sColor1
  
  OuterGlow.a
  
  InnerGlow.a
  
  Border.a
  BColor.sColor1
  
EndStructure

Structure sLayer
  
  Name$
  id.a ;  c'est l'id unique, défini lorsque le calque est créé, pour la sauvegarde des images (undo)
  X.w : Y.w
  W.w : H.w
  NewW.w : NewH.w
  ImageTemp.i ; nécessaire lors d'opération comme saveimage, merge, etc...
  Image.i
  ImageBM.i ; l'image supplémentaire nécessaire pour certains blendmode. 
            ; Ex multiply a besoin d'une box() entièrement de l'intensité de l'aplha du layer 
            ; (RGBA(layer(id)\alpha,layer(id)\alpha,layer(id)\alpha,255)
  
  ImageAlpha.i ; le canal alpha
  ImageStyle.i ; image pour le style
  Sprite.i
  Ordre.w ; l'ordre du calque 0 = tout en bas, 100+ = tout en haut
  
  ImgLayer.i
  IG_LayerMenu.i
  
  Typ.a ;normal(bitmap) = 0, texte = 1, background = 2, vecto = 3
  Repeated.a
  W_Repeat.w
  H_Repeat.w
  ;RepeatY.w
  
  ;layer text
  FontName$
  FontSize.w
  FontStyle.w
  FontColor.i
  FontID.i
  Text$
  
  
  ; alphas
  MaskAlpha.a ; a-t-on un calque alpha ?
  Link.a
  
  
  Bm.a
  View.a
  Alpha.a
  
  Group.a
  Locked.a
  LockAlpha.a
  LockMove.a
  LockPaint.a
  
  Style.sStyle
  
  ; autres
  Selected.a ; si on le bouge, affiche un cadre
  ToDelete.a ; on va supprimer le calque
  
  Haschanged.a ; pour vérifier s'il a changé, c'est pour l'autosave par exemple
    
  OkForColorPick.a ; on peut l'utiliser pour prendre la couleur (avec le mode mixtyp en custom
  
  ; transform
  CenterX.w
  CenterY.w
  AngleStartX.w
  AngleStartY.w
  AngleX.w
  AngleY.w
  Angle.w
  
  ; tiles
  Array Tile.stile(0)
  
EndStructure
Global Dim Layer.sLayer(0)
Global LayerNb.w,LayerIdMax.w
;}


;{ paper : the papers are in data\paper // il y a le papier qu'on utilise et les images dans le dossier data/paper/
Structure sPaper
  nom$
  alpha.a
  scale.w
  intensity.w ; intensity
  imageId.i
  imageIdTexture.i
  Color.i
EndStructure
Global Paper.sPaper
Global Dim Thepaper.sPaper(0) ; for the paper editor
;}



;{ stroke and dots
Structure sDot
  ; ce sont les variables finales, après tous les calculs de chaque paramètres
  X.w ; x+ scatter
  Y.w
  W.w
  H.w
  Alpha.a
  ; scatter.w
  Rot.w ; rot+randrot
  Size.w
  SizeW.a ; taille en W et H
  SizeH.a
  Colo.a
  Sprite.i
  
EndStructure


Structure sStroke
  
  ; quand on dessine, on pose des "points". 
  ; Moi, je calcule un trait entre ces points posées par la souris (dans la boucle avec b, dist, etc...
  ; au lieu d'ensuite dessiner, je vais calculer une seule fois tous les points du trait et stocké ce calcul (donc le trait opbtenu)
  ; dans un tableau de stroke.
  ; je m'en servirai pour le undo/redo
  ; je garderai uniquement les calculs finaux, comme si j'allais afficher chaque brush (sur le screen puis l'image
  ; j'ai donc un tableau de trait (stroke) et chaque trait a un tableau de points (par rapport au brush\pas)
  ; à chaque undo, je reviendrai de 1 en arrière dans le tableau et si je suis à l'élément 0 , je reviens au max puis, max-1, etc...
  Layer.a ; ?
  Array dot.sDot(0)
  
EndStructure
Global Dim Stroke.sStroke(0)
Global StrokeId.a

;}




; plugins
Structure sPlugins
  
  menuId.w
  lib.i
  name$
  
EndStructure
Global NewList Ani_Plugins.sPlugins()







; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 197
; FirstLine = 2
; Folding = AAAAA5
; Markers = 351
; EnableXP
; EnableUnicode