; selection contour
; by  Alter Mann



#BIT0 = 1
#BIT1 = 2
#BIT2 = 4
#BIT3 = 8

;===========
; Strukturen
;===========
Structure STRECKE  ; Umrissstrecke
  wX1.w
  wY1.w
  wX2.w
  wY2.w
  wK.w
EndStructure

Structure PIXEL ; Pixel
  bRed.b
  bGreen.b
  bBlue.b
  bAlpha.b
EndStructure

Structure PIXELIDX ; Pixelindex
  wX.w
  wY.w
EndStructure

Structure PIXELKONTUR ; Umrisskontur
  wAnz.w
  List sPixel.PIXELIDX()
EndStructure

Structure PIXELBEREICH ; alle Umrisskonturen
  wAnz.w
  List sKontur.PIXELKONTUR()
EndStructure

;==============================================================
; Prototyp für Pixeltest - Funktion, ob Pixel zum Gebiet gehört
Prototype.i fPixelTest(wPosX.w,wPosY.w,wAnzX.w,wAnzY.w,*lBild.PIXEL)
;==============================================================

Global sBereich.PIXELBEREICH

;==========================
; Integer-Absolutwert
;==========================
Procedure.i iAbs (iWert.i)
  If iWert < 0
    ProcedureReturn -iWert
  EndIf
  ProcedureReturn iWert
EndProcedure

; ===================================================
; Linie mit Liniendicke zeichnen mit Hilfe von Circle
; ===================================================
Procedure DrawLine(lX1.l,lY1.l,lX2.l,lY2.l,lR.l,lF.l)
  ; ----------------------------------
  ; Eingabe
  ; lX1,lY1    : Startpunkt
  ; lX2,lY2    : Endpunkt
  ; lR         : halbe Linienstärke
  ; lF         : Farbe
  ; ----------------------------------
  Protected lX.l, lY.l, lH.l, lT.l, lA.l, lD.l
  Circle(lX1,lY1,lR,lF)   ; Kreis um Startpunkt
  If lX1=lX2 And lY1=lY2 
    ProcedureReturn      ; Anfangspunkt = Endpunkt
  EndIf
  If iAbs(lX1-lX2) > iAbs(lY1-lY2) ; X-Differenz > Y-Differenz
    lD = lX2-lX1
    If lX1>lX2
      For lX=lX1-1 To lX2 Step -1 ; für jedes Pixel
        lH = (lX-lX1)*(lY2-lY1)
        lT = (lH % lD) << 1
        If lT<lD                   ; Y-Wert ausrechnen
          lY = lY1 + lH / lD - 1
        Else
          lY = lY1 + lH / lD
        EndIf
        Circle(lX,lY,lR,lF)
      Next lX
    Else
      For lX=lX1+1 To lX2 Step 1
        lH = (lX-lX1)*(lY2-lY1)
        lT = (lH % lD) << 1
        If lT>lD
          lY = lY1 + lH / lD + 1
        Else
          lY = lY1 + lH / lD
        EndIf
        Circle(lX,lY,lR,lF)
      Next lX
    EndIf
  Else                          ; Y-Differenz <= X-Differenz
    lD = lY2-lY1
    If lY1>lY2
      For lY=lY1-1 To lY2 Step -1 ; für jedes Pixel
        lH = (lY-lY1)*(lX2-lX1)
        lT = (lH % lD) << 1
        If lT<lD                   ; X-Wert ausrechnen
          lX = lX1 + lH / lD - 1 
        Else
          lX = lX1 + lH / lD
        EndIf
        Circle(lX,lY,lR,lF)
      Next lY
    Else
      For lY=lY1+1 To lY2 Step 1
        lH = (lY-lY1)*(lX2-lX1)
        lT = (lH % lD) << 1
        If lT>lD
          lX = lX1 + lH / lD + 1
        Else
          lX = lX1 + lH / lD
        EndIf
        Circle(lX,lY,lR,lF)
      Next lY
    EndIf
  EndIf
EndProcedure

;========================================
; Umriss um einen Grafikbereich berechnen
;========================================
Procedure Umriss(wAnzX.w, wAnzY.w, *lBild, *pFunction.fPixelTest)
  ; --------------------------------------------------------------------------------
  ; Eingabe
  ; wAnzX      : Anzahl Pixel in X-Richtung
  ; wAnzY      : Anzahl Pixel in Y-Richtung
  ; *lBild     : Pointer auf Farbwerte des Bildes
  ; *pFunction : Userdefinierte Funktion zur Bestimmung, ob Pixel zum Bereich gehört
  ; --------------------------------------------------------------------------------
  Protected i.w,j.w
  Protected iAnzP.i = 0
  Protected Dim bRand.b(wAnzX,wAnzY) ; Feld für Randkennung
 
  For i=0 To wAnzY-1 Step 1
    For j=0 To wAnzX-1 Step 1
      If *pFunction(j,i,wAnzX,wAnzY,*lBild) = #True  ; Pixel gehört zum Bereich
        bRand(j,i) = (#BIT0|#BIT1|#BIT2|#BIT3)       ; alle Randkennungen setzen
        iAnzP + 1
        If j>0 And (bRand(j-1,i) & #BIT1) = #BIT1    ; je nach Nachbar entsprechende Randkennungen streichen
          bRand(j  ,i) & ~#BIT3
          bRand(j-1,i) & ~#BIT1
        EndIf
        If i>0 And (bRand(j,i-1) & #BIT2) = #BIT2
          bRand(j,i  ) & ~#BIT0
          bRand(j,i-1) & ~#BIT2
        EndIf
      EndIf
    Next j
  Next i
 
  Protected iMaxS = 1000
  Protected Dim sStr.STRECKE(iMaxS)
  Protected iAnzS.i = 0
  ; je nach Kennung Strecken eintagen 
  For i=0 To wAnzY-1 Step 1
    For j=0 To wAnzX-1 Step 1
      If (bRand(j,i) & #BIT0) = #BIT0
        If iAnzS+1 > iMaxS
          iMaxS + 1000
          ReDim sStr.STRECKE(iMaxS)
        EndIf
        sStr(iAnzS)\wX1 = j
        sStr(iAnzS)\wY1 = i
        sStr(iAnzS)\wX2 = j+1
        sStr(iAnzS)\wY2 = i
        sStr(iAnzS)\wK  = 0
        iAnzS + 1
      EndIf
      If (bRand(j,i) & #BIT1) = #BIT1
        If iAnzS+1 > iMaxS
          iMaxS + 1000
          ReDim sStr.STRECKE(iMaxS)
        EndIf
        sStr(iAnzS)\wX1 = j+1
        sStr(iAnzS)\wY1 = i
        sStr(iAnzS)\wX2 = j+1
        sStr(iAnzS)\wY2 = i+1     
        sStr(iAnzS)\wK  = 0
        iAnzS + 1
      EndIf
      If (bRand(j,i) & #BIT2) = #BIT2
        If iAnzS+1 > iMaxS
          iMaxS + 1000
          ReDim sStr.STRECKE(iMaxS)
        EndIf
        sStr(iAnzS)\wX1 = j+1
        sStr(iAnzS)\wY1 = i+1
        sStr(iAnzS)\wX2 = j
        sStr(iAnzS)\wY2 = i+1       
        sStr(iAnzS)\wK  = 0
        iAnzS + 1
      EndIf
      If (bRand(j,i) & #BIT3) = #BIT3
        If iAnzS+1 > iMaxS
          iMaxS + 1000
          ReDim sStr.STRECKE(iMaxS)
        EndIf
        sStr(iAnzS)\wX1 = j
        sStr(iAnzS)\wY1 = i+1
        sStr(iAnzS)\wX2 = j
        sStr(iAnzS)\wY2 = i       
        sStr(iAnzS)\wK  = 0
        iAnzS + 1
      EndIf
    Next j
  Next i
  ; Feld sortieren
  SortStructuredArray(sStr(),#PB_Sort_Ascending,OffsetOf(STRECKE\wX1),#PB_Word,0,iAnzS-1)
 
  Protected Dim sStr1.STRECKE(iAnzS)
  Protected k.i,iS.i=-1,iE.i, iAnz.i=1, iFind.i=0, iIdx.i=0
  Protected wX0.w = sStr(0)\wX2
  Protected wDx1.w=sStr(0)\wX2-sStr(0)\wX1,wDy1.w=sStr(0)\wY2-sStr(0)\wY1
  Protected wDx2.w,wDy2.w,wDx3.w,wDy3.w,wW2.w,wW3.w
 
  ; erste Strecke ist Startstrecke
  For k=0 To iAnzS Step 1
    If sStr(k)\wX1 = wX0 And iS = -1
      iS = k
    ElseIf sStr(k)\wX1 > wX0
      iE = k
      Break
    EndIf
  Next k
  sStr(0)\wK = 1
  sStr1(0) = sStr(0)
  ; Strecken sortieren
  While iFind < iAnzS
    If sStr1(iAnz-1)\wX2 > wX0
      iS = iE
      While iE<iAnzS And sStr(iE)\wX1 = sStr1(iAnz-1)\wX2
        iE + 1
      Wend
      wX0 = sStr1(iAnz-1)\wX2
    ElseIf sStr1(iAnz-1)\wX2 < wX0
      iE = iS
      iS - 1
      While iS>=0 And sStr(iS)\wX1 = sStr1(iAnz-1)\wX2
        iS - 1
      Wend
      iS + 1
      wX0 = sStr1(iAnz-1)\wX2
    EndIf
    iIdx = -1
    wW2  =  4
    For k=iS To iE-1
      If sStr(k)\wK = 1
        Continue
      EndIf
      If sStr(k)\wX1 = sStr1(iAnz-1)\wX2 And sStr(k)\wY1 = sStr1(iAnz-1)\wY2
        wDx3 = sStr(k)\wX2 - sStr(k)\wX1
        wDy3 = sStr(k)\wY2 - sStr(k)\wY1
        wW3  = wDx1 * wDy3 - wDy1 * wDx3
        If wW3 < wW2
          iIdx = k
          wW2  = wW3
          wDx2 = wDx3
          wDy2 = wDy3
        EndIf
      EndIf
    Next k
    If iIdx = -1 And sStr1(0)\wX1 = sStr1(iAnz-1)\wX2 And sStr1(0)\wY1 = sStr1(iAnz-1)\wY2 ; geschlossene Kontur übernehmen
      sBereich\wAnz + 1
      AddElement(sBereich\sKontur())
      For k=0 To iAnz-1 Step 1
        wDx1 = sStr1(k)\wX2 - sStr1(k)\wX1
        wDy1 = sStr1(k)\wY2 - sStr1(k)\wY1
        If     wDx1 =  1 And wDy1 =  0
          wDx2 = sStr1(k)\wX1
          wDy2 = sStr1(k)\wY1
        ElseIf wDx1 =  0 And wDy1 =  1
          wDx2 = sStr1(k)\wX1-1
          wDy2 = sStr1(k)\wY1
        ElseIf wDx1 = -1 And wDy1 =  0
          wDx2 = sStr1(k)\wX2
          wDy2 = sStr1(k)\wY1-1
        ElseIf wDx1 =  0 And wDy1 = -1
          wDx2 = sStr1(k)\wX2
          wDy2 = sStr1(k)\wY2
        Else
        EndIf
        If sBereich\sKontur()\wAnz > 0 And sBereich\sKontur()\sPixel()\wX = wDx2 And sBereich\sKontur()\sPixel()\wY = wDy2
          Continue
        EndIf
        sBereich\sKontur()\wAnz + 1
        AddElement(sBereich\sKontur()\sPixel())
        sBereich\sKontur()\sPixel()\wX = wDx2
        sBereich\sKontur()\sPixel()\wY = wDy2       
      Next k
      iAnz = 0 ; neue Startstrecke suchen
      For k=0 To iAnzS-1 Step 1
        If sStr(k)\wK = 0
          sStr1(iAnz) = sStr(k)
          sStr(k)\wK = 1
          wX0 = sStr1(0)\wX2
          iAnz + 1
          iFind + 1
          iS = -1
          For j=0 To iAnzS-1 Step 1
            If sStr(j)\wX1 = wX0 And iS = -1
              iS = j
              iE = iAnzS
            ElseIf sStr(j)\wX1 > wX0
              iE = j
              Break
            EndIf
          Next j
          Break
        EndIf
      Next k
      If iAnz = 0
        Break
      EndIf
      wDx1 = sStr1(0)\wX2 - sStr1(0)\wX1
      wDy1 = sStr1(0)\wY2 - sStr1(0)\wY1
    ElseIf iIdx >-1
      sStr1(iAnz) = sStr(iIdx)
      sStr(iIdx)\wK = 1
      iAnz + 1
      iFind + 1
      wDx1 = wDx2
      wDy1 = wDy2
    Else
      Break ; Fehler
    EndIf
  Wend
  k = 0
EndProcedure

;=======================
; Bild in Speicher laden
;=======================
Procedure.i GetPixelFromImage (iImage.i, *sPixel.PIXEL)
  ; ---------------------
  ; Eingabe
  ; iImage     : Imagegadgetnummer
  ; *sPixel    : Speicher für Bild
  ; -------------
  If StartDrawing(ImageOutput(iImage))
    Protected *bBuffer = DrawingBuffer()
    Protected iPitch.i = DrawingBufferPitch()
    Protected iPixelFormat.i = DrawingBufferPixelFormat()
    Protected iWidth.i = ImageWidth(iImage)
    Protected iHeight.i = ImageHeight(iImage)
    Protected iByte.i,iRev.i
    Protected *bBuffer2, bL.b
    Protected i.i,j.i
    Protected sPixel.PIXEL, *sPixel1.PIXEL = *sPixel
   
    If iPixelFormat & #PB_PixelFormat_24Bits_RGB
      iByte = 3
      iRev  = 1
    ElseIf iPixelFormat & #PB_PixelFormat_24Bits_BGR
      iByte = 3
      iRev  = -1
    ElseIf iPixelFormat & #PB_PixelFormat_32Bits_RGB
      iByte = 4
      iRev  = 1
    ElseIf iPixelFormat & #PB_PixelFormat_32Bits_BGR
      iByte = 4
      iRev  = -1
    Else
      StopDrawing()
      ProcedureReturn 1
    EndIf
    iPitch / iByte
   
    If iPitch < iWidth
      StopDrawing()
      ProcedureReturn 2
    EndIf
    If iByte < SizeOf(PIXEL)                                ; Imagefarbe an PIXEL-Struktur anpassen
      sPixel\bAlpha = 255
      If iPixelFormat & #PB_PixelFormat_ReversedY
        For i=0 To iHeight-1
          For j=0 To iWidth-1
            CopyMemory (*bBuffer,@sPixel,iByte)
            *bBuffer + iByte
            CopyMemory(@sPixel,*sPixel,SizeOf(PIXEL))
            *sPixel + SizeOf(PIXEL)
          Next j
          *bBuffer + iByte*(iPitch-iWidth)
        Next i
      Else     
        For i=iHeight-1 To 0 Step -1
          *bBuffer2 = *bBuffer + iPitch * i * iByte
          For j=0 To iWidth-1
            CopyMemory (*bBuffer2,@sPixel,iByte)
            *bBuffer2 + iByte
            CopyMemory(@sPixel,*sPixel,SizeOf(PIXEL))
            *sPixel + SizeOf(PIXEL)
          Next j
        Next i
      EndIf
    ElseIf iAbs(i) = SizeOf(PIXEL)                           ; selbe Größe
      If iPixelFormat & #PB_PixelFormat_ReversedY
        If iPitch = iWidth
          CopyMemory (*bBuffer,*sPixel,iWidth*iHeight*SizeOf(PIXEL))
        ElseIf iPitch > iWidth
          For i=0 To iHeight-1
            CopyMemory (*bBuffer,*sPixel,iWidth*SizeOf(PIXEL))
            *bBuffer + iPitch*SizeOf(PIXEL)
            *sPixel + iWidth*SizeOf(PIXEL)
          Next i
        EndIf
      Else     
        *bBuffer2 = *bBuffer + iPitch * (iHeight-1) * SizeOf(PIXEL)
        For i=iHeight-1 To 0 Step -1
          CopyMemory (*bBuffer2,*sPixel,iWidth*SizeOf(PIXEL))
          *bBuffer2 - iPitch*SizeOf(PIXEL)
          *sPixel + iWidth*SizeOf(PIXEL)
        Next i
      EndIf
    Else
      ProcedureReturn 2
    EndIf
    StopDrawing()
    ;SetGadgetState(#ImageGad,ImageID(iImage))
    If iRev = -1                               ; Blau und Rot tauschen
      j = iHeight*iWidth - 1
      For i=0 To j Step 1
        Swap *sPixel1\bBlue,*sPixel1\bRed
        *sPixel1 + SizeOf(PIXEL)
      Next i
    EndIf
  Else
    ProcedureReturn 3
  EndIf
  ProcedureReturn 0
EndProcedure

;============================
; Benutzerdefinierte Funktion
; hier : rote Pixel
;============================
Procedure.i TestePixel (wX.w, wY.w, wAX.w, wAY.w, *sPix.PIXEL)
  ; ---------------------------------------
  ; Eingabe
  ; wX,wY       : Pixelindex
  ; wAX         : Anzahl Pixel in X im Bild
  ; wAY         : Anzahl Pixel in Y im Bild
  ; *lPix       : Bildspeicher
  ; ---------------------------------------
  Protected lX.l = wX, lY.l = wY, lAX.l = wAX
  *sPix + (lX + lY*lAX) * SizeOf(PIXEL)
  If (*sPix\bGreen & $FF) = 0 And (*sPix\bRed & $FF) = 255 And (*sPix\bBlue & $FF) = 0
    ProcedureReturn 1
  EndIf
  ProcedureReturn 0
EndProcedure

InitializeStructure(@sBereich,PIXELBEREICH)

; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 428
; FirstLine = 32
; Folding = AAAAAAAAAGAA-
; EnableUnicode
; EnableXP