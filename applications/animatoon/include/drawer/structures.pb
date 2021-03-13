
;{ tablet 
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


Structure sDoc
  name$
  w.w
  h.w  
EndStructure
Global doc.sDoc
With doc
  \name$ = "Untitled"
  \w = 5000
  \h = 5000
EndWith 



Structure Brush
  
  Type.a
  Brush.w

  alpha.a
  alphaPressure.a
  
  size.w
  sizepressure.a
  transition.a
  
  scatter.w
  pas.w
  x.w : y.w
  
  Color.i : ColR.a : ColG.a : ColB.a
  
EndStructure
Global brush.brush
With brush
  \alpha = 255
  \alphaPressure = 0
  \size = 50
  \sizepressure = 1
  \pas = 40
  \transition = 1
EndWith


;{ les tiles
  
  ; taille des tiles
  Global Nx,Ny,Tw,NbTile
  
  Tw = 128
  
  Nx = Round(Doc\W/Tw,#PB_Round_Up)
  Ny = Round(Doc\H/Tw,#PB_Round_Up)
  NbTile = Nx * Ny
  Debug NbTile
  
  ; Debug "tile : "+Str(NbTile)+"-"+Str(nx)+"/"+Str(ny)

  
Structure stile
  x.w
  y.w
  image.i
EndStructure

; Global Dim tile.sTile(NbTile)

; For i = 0 To NbTile
;   With tile(i)
;     \image = CreateImage(#PB_Any,Tw,Tw,32,#PB_Image_Transparent)
;     \x = Mod(i,Nx)* Tw    
;     \y = (i/Ny)* Tw
;     Debug Str(\x)+"/"+Str(\y)
;   EndWith
; Next i
;}

Structure sLayer
  
  Image.i
  ImageAlpha.i
  
  Alpha.a
  Bm.a
  Name$
  
  View.a
  
  Paint.a
  Blocked.a
  LockAlpha.a
  
  Array tile.stile(0)
  
EndStructure
Global Dim Layer.sLayer(0)


Structure sDot
  x.w
  y.w
  size.a
EndStructure

Structure sStroke
  
  Array dot.sDot(0)
  
EndStructure
Global Dim Stroke.sStroke(0)
Global StrokeId.a
; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 216
; FirstLine = 162
; Folding = ---
; EnableUnicode
; EnableXP