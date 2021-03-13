
XIncludeFile "include\infos.pb" ; infos

;{ *** constante
XIncludeFile "include\enumeration.pb"
#ProgramVersion   = "0.588"
#ProgramRevision  = 4
#ProgramDate      = #PB_Compiler_Date ; "23/07/2015", 02/2021
#ProgramNbLine    = "19560"
;}

;{ *** structure
XIncludeFile "include\structures.pb"
;}

XIncludeFile "include\lang.pbi" ; for langages
Declare AddLogError(error, info$) ; needed for error with initsprite/initkeyboard...

;{ *** init (Screen & image)
XIncludeFile "include\initscreen.pb" ; just initkeyboard and initscreen, we use the screen for the view (and save screen as image)

XIncludeFile "include\init.pb" ; init image encoder/decord, load images for GUI

;}


;{ *** prototypes
XIncludeFile "include\prototypes.pb" ; for tablet (wacom)
                                     ;}

;{ *** Variable
XIncludeFile "include\variables.pb"
;}

;{ *** macro & utiles
XIncludeFile "include\macros.pb"
;}

;{ *** procedure 
XIncludeFile "include\procedures.pb" ;  screen et sprite

; Contient :
; XIncludeFile "include\procedures\declare.pbi" 
; XIncludeFile "include\procedures\menu.pbi" ; menu, file, edition..
; XIncludeFile "include\procedures\history.pbi" ; script, history
; XIncludeFile "include\procedures\swatch.pbi" 
; XIncludeFile "include\procedures\roughboard.pbi"
; XIncludeFile "include\procedures\gadgets.pbi"
; XIncludeFile "include\procedures\brush.pbi"
; XIncludeFile "include\procedures\image.pbi" ; image réglages, blendmode
; XIncludeFile "include\procedures\imgfilters.pbi"
; XIncludeFile "include\procedures\paint.pbi"
; XIncludeFile "include\procedures\layer.pbi"
; XIncludeFile "include\procedures\window.pbi"

;}

;{ *** Open window 

; fenêtre d'introduction (pour faire patienter pendant le chargement des images par exemple
w= 500
h= 250
If ImageLoad2(#Img_Intro,"data\animatoon.jpg",500,250)
  w = ImageWidth(#img_intro)
  h = ImageHeight(#img_intro)
EndIf

If OpenWindow(#Win_Intro,0,0,w,h,#ProgramName, #PB_Window_BorderLess|#PB_Window_ScreenCentered)
  
  tmp=ImageGadget(#PB_Any,0,0,w,h,ImageID(#img_intro))
  
  Repeat
    event = WindowEvent()
    
  Until quit = 0
  
  ; Create the image for UI
  ColW =48
  CreateImage2(#ImageColorBG,ColW,ColW,"Image color Background")
  CreateImage2(#ImageColorFG,ColW,ColW,"Image color Foreground")
  CreateImage2(#Img_PreviewBrush,100,100,"Image Preview Brush")
  
  ; Icone layers
  ImageLoad2(#Img_LayerCenter,  OptionsIE\Theme$ +"\layer.jpg",254,25)  
  ImageLoad2(#ico_LayerEye,   OptionsIE\Theme$ +"\layereye.jpg",11,9)  
  ;ImageLoad2(#Img_Pan_LayerLock,  OptionsIE\Theme$ +"\layerlocked.jpg",12,12)  
  ImageLoad2(#Img_LayerCenterSel,OptionsIE\Theme$ +"\layersel.jpg",254,25)  
  
EndIf

; for the moment, tablet only works on windows, I don't know how to use tablet on other system.
CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  
  errortablet$ = "Unable to load Wintab32.dll. Is your Tablet ready ?"+Chr(10)+
                 "You can try To copy the wintab32.Dll from your windows system To the directory of animatoon."
  If OpenLibrary(0, "Wintab32.dll")
    
    WTInfo.WTInfo_     = GetFunction(0, "WTInfoA")
    WTOpen.WTOpen_     = GetFunction(0, "WTOpenA")
    WTPacket.WTPacket_ = GetFunction(0, "WTPacket")
    WTClose.WTClose_   = GetFunction(0, "WTClose")
    WTQueueSizeSet.WTQueueSizeSet_ = GetFunction(0, "WTQueueSizeSet")
    
    
    If WTInfo(0, 0, 0)
      
      Tablet = 1
      
    Else
      MessageRequester("ERROR","(WTInfo = 0)"+Chr(10)+errortablet$)
      CloseLibrary(0)
      
    EndIf
    
    
  Else
    MessageRequester("ERROR", Errortablet$)
  EndIf
  
  
CompilerElseIf #PB_Compiler_OS = #PB_OS_Linux
  
  
CompilerElseIf #PB_Compiler_OS = #PB_OS_MacOS
  
CompilerEndIf

; fenêtre principale
If ExamineDesktops()
  WinW = DesktopWidth(0)
  WinH = DesktopHeight(0)
Else
  WinW = 1024
  WinH = 768
EndIf
If OpenWindow(#WinMain, -2000, -2000, winW, WinH,#ProgramName+#ProgramVersion+" - "+doc\name$,  
              #PB_Window_SystemMenu|#PB_Window_MaximizeGadget|#PB_Window_Maximize|#PB_Window_MinimizeGadget|
              #PB_Window_SizeGadget)= 0
  MessageRequester(Lang("Error"), Lang("Impossible to open the main window !"))
  End
EndIf

HideWindow(#WinMain,1)
Clear = 1

AddMenu(clear)

If tablet ; pour tablet
  
  ;{ info for tablet
  info.LOGCONTEXTA
  WTInfo(#WTI_DEFSYSCTX,0,@info)
  
  #PACKETDATA = #PK_X | #PK_Y | #PK_Z | #PK_BUTTONS | #PK_NORMAL_PRESSURE | #PK_TANGENT_PRESSURE
  ;#PACKETMODE = #PK_BUTTONS | #PK_NORMAL_PRESSURE | #PK_TANGENT_PRESSURE
  #PACKETMODE = 0
  
  info\lcOptions  | #CXO_MESSAGES
  info\lcMsgBase  = #WT_DEFBASE
  info\lcPktData  = #PACKETDATA
  info\lcPktMode  = #PACKETMODE
  info\lcMoveMask = #PACKETDATA
  info\lcBtnUpMask = info\lcBtnDnMask
  ;info\lcPktRate = 25
  
  info\lcOutOrgX = 0
  info\lcOutOrgY = 0
  info\lcOutExtX = 10000
  info\lcOutExtY = 10000
  
  
  hCtx = WTOpen(WindowID(0),@info,1)
  
  WTQueueSizeSet(hCtx,300)
  ;}
  
EndIf

InitScreen()
OpenOptions()
IE_StatusBarAdd()


ScreenY = OptionsIE\ToolbarH -6
CanvasW = WinW-ScreenX*2
CanvasH = WinH-StatusBarHeight(#Statusbar) - OptionsIE\ToolbarH
If ContainerGadget(#G_ContScreen,ScreenX,ScreenY,CanvasW,CanvasH,#PB_Container_Single )
  If OpenWindowedScreen(GadgetID(#G_ContScreen),0,0,CanvasW,CanvasH) = 0
    MessageRequester(lang("Error"),lang("Unable to open the screen (openwindowedscreen))"))
    End
  EndIf
  CloseGadgetList()
EndIf

KeyboardMode(#PB_Keyboard_International)  

CompilerIf  #PB_Compiler_OS <> #PB_OS_Windows 
  
  CompilerIf #PB_Compiler_OS = #PB_OS_Linux
    
    gdk_x11_drawable_get_xid_(#G_ContScreen) ; pour utiliser l'écran dans un container
    
  CompilerEndIf
  
  
  If InitMouse() =0
    MessageRequester("Error", "cant init the mouse for the screen")
    End
  EndIf
  
CompilerEndIf

; à remplacer par un sprite du brush ?
; CompilerIf  #PB_Compiler_OS <> #PB_OS_Windows 
ShowCursor_(1) ; montre le curseur sur le screen
               ; CompilerEndIf

; PaperChange()
PaperInit()
BrushUpdateImage(2)
; ChangeCursor()

Action = #Action_Brush
;{ gadgets
IE_GadgetAdd()
BrushUpdateColor()
;}

;{ autres

; we add a layer (because we need at least 1 layer :)
Layer_Add()

; For the tablet
CreateImage(#ImageTablet,CanvasW,CanvasH,32, #PB_Image_Transparent)
SetWindowCallback(@MyWindowCallback()) ; tablet windows only ! 

; for the window
SmartWindowRefresh(#WinMain,1)
ResizeWindow(#WinMain, 0, 0, winW, winH)
SetWindowState(#WinMain,#PB_Window_Maximize)
HideWindow(#WinMain,0)

; puis on supprime ce qui a rapport avec la fenêtre intro
FreeGadget(tmp)
FreeImage(#Img_Intro)
CloseWindow(#Win_Intro)


CanvasX = (ScreenWidth() - doc\w)/2
CanvasY = (ScreenHeight() - doc\h)/2

ScreenUpdate()
size.d = 0

; on créé le thread autosave
If OptionsIE\Autosave
  ; CreateThread(@Autosave(), 10)
EndIf

;}

;}

;{ ************ loop ******
XIncludeFile "include\loop.pb"
;}

;; XIncludeFile "include\datasection.pb" ; No more used (I keep the file , I don't know why :)) // n'est plus utilisé


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 16
; FirstLine = 1
; Folding = AAAA5
; EnableXP
; EnableUser
; UseIcon = teo.ico
; Executable = animatoon0.57.exe
; Warnings = Display
; EnablePurifier
; IncludeVersionInfo
; VersionField0 = 0,3,8
; VersionField1 = 0,3,8
; VersionField2 = Dracaena studio - blendman
; VersionField3 = Animatoon
; VersionField6 = 2D painting and animation software
; VersionField7 = animatoon
; VersionField8 = animatoon
; VersionField9 = blendman
; EnableUnicode