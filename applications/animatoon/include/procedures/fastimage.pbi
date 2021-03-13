;- Structures

Structure FASTIMAGEINFO
  ptrImageBuffer.l
  imgWidth.w
  imgHeight.w
  imgDepth.b
EndStructure

;- Macros

Macro FastRGB(r, g, b)

  ; Faster equivalent of RGB(), although only suitable for integers

  (((r << 8 + g) << 8 ) + b)
 
EndMacro

Macro FastRed(color)
 
  ; Faster equivalent of Red(), although only suitable for integers

  ((color & $FF0000) >> 16)
 
EndMacro

Macro FastGreen(color)

  ; Faster equivalent of Green(), although only suitable for integers

  ((color & $FF00) >> 8)
 
EndMacro

Macro FastBlue(color)

  ; Faster equivalent of Blue(), although only suitable for integers

  (color & $FF)
 
EndMacro

Macro ReverseRGB(color)

  ; Changes RGB to BGR or vice versa

  ((color & $FF) << 16 | (color & $FF00) | (color & $FF0000) >> 16)
 
EndMacro

Macro FastPlot(image_info, x, y, color)
  PokeL(image_info\ptrImageBuffer + (image_info\imgWidth * (y) + x) << 2, color)
EndMacro

Macro FastPoint(image_info, x, y)
  (PeekL(image_info\ptrImageBuffer + (image_info\imgWidth * (y) + x) << 2) & $FFFFFF<<24)
EndMacro

;- Procedures

Procedure CopyImageToMemory(image_no.l, *mem)
  CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    Protected TemporaryDC.l, TemporaryBitmap.BITMAP, TemporaryBitmapInfo.BITMAPINFO
    TemporaryDC = CreateDC_("DISPLAY", #Null, #Null, #Null)
    GetObject_(ImageID(image_no), SizeOf(BITMAP), TemporaryBitmap.BITMAP)
    TemporaryBitmapInfo\bmiHeader\biSize        = SizeOf(BITMAPINFOHEADER)
    TemporaryBitmapInfo\bmiHeader\biWidth       = TemporaryBitmap\bmWidth
    TemporaryBitmapInfo\bmiHeader\biHeight      = -TemporaryBitmap\bmHeight
    TemporaryBitmapInfo\bmiHeader\biPlanes      = 1
    TemporaryBitmapInfo\bmiHeader\biBitCount    = 32
    TemporaryBitmapInfo\bmiHeader\biCompression = #BI_RGB
    GetDIBits_(TemporaryDC, ImageID(image_no), 0, TemporaryBitmap\bmHeight, *mem, TemporaryBitmapInfo, #DIB_RGB_COLORS)
    DeleteDC_(TemporaryDC)
  CompilerElse
    Protected x.l, y.l, mem_pos.l
    mem_pos = 0
    StartDrawing(ImageOutput(image_no))
    For y = 0 To ImageHeight(image_no) - 1
      For x = 0 To ImageWidth(image_no) - 1
        PokeL(*mem + mem_pos, ReverseRGB(Point(x, y)))
        mem_pos + 4
      Next
    Next
    StopDrawing()
  CompilerEndIf
EndProcedure

Procedure CopyMemoryToImage(*mem, image_no.l)
  CompilerIf #PB_Compiler_OS = #PB_OS_Windows
    Protected TemporaryDC.l, TemporaryBitmap.BITMAP, TemporaryBitmapInfo.BITMAPINFO
    TemporaryDC = CreateDC_("DISPLAY", #Null, #Null, #Null)
    GetObject_(ImageID(image_no), SizeOf(BITMAP), TemporaryBitmap.BITMAP)
    TemporaryBitmapInfo\bmiHeader\biSize        = SizeOf(BITMAPINFOHEADER)
    TemporaryBitmapInfo\bmiHeader\biWidth       = TemporaryBitmap\bmWidth
    TemporaryBitmapInfo\bmiHeader\biHeight      = -TemporaryBitmap\bmHeight
    TemporaryBitmapInfo\bmiHeader\biPlanes      = 1
    TemporaryBitmapInfo\bmiHeader\biBitCount    = 32
    TemporaryBitmapInfo\bmiHeader\biCompression = #BI_RGB
    SetDIBits_(TemporaryDC, ImageID(image_no), 0, TemporaryBitmap\bmHeight, *mem, TemporaryBitmapInfo, #DIB_RGB_COLORS)
    DeleteDC_(TemporaryDC)
  CompilerElse
    Protected x.l, y.l, mem_pos.l
    mem_pos = 0
    StartDrawing(ImageOutput(image_no))
    For y = 0 To ImageHeight(image_no) - 1
      For x = 0 To ImageWidth(image_no) - 1
        Plot(x, y, ReverseRGB(PeekL(*mem + mem_pos)))
        mem_pos + 4
      Next
    Next   
    StopDrawing()
  CompilerEndIf
EndProcedure
; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 56
; Folding = CCw
; EnableUnicode
; EnableXP