; PB : 5.22 / 5.31
; june 2015
; by Blendman


InitSprite()
InitMouse()
InitKeyboard()

screenwidth = 1024
screenheight = 768
ScreenX = 50
ScreenY = 50
If OpenWindow(0, 0, 0, screenwidth, screenheight, "Antialiased Line Demo", #PB_Window_SystemMenu | #PB_Window_ScreenCentered) : EndIf

If OpenWindowedScreen(WindowID(0),ScreenX,ScreenY,screenwidth-100, screenheight-100)=0
  MessageRequester("Error", "Can't Open Screen!", 0)
  End
EndIf

ShowCursor_(1)

Repeat

  mx = WindowMouseX(0) - ScreenX
  my = WindowMouseY(0) - ScreenY
  
  ; first, verify the events

  Repeat
    ; needed to not freeze the window !
    Event       = WaitWindowEvent(1)
    EventMenu   = EventMenu()
    EventGadget = EventGadget()
    EventType   = EventType()
    EventWindow = EventWindow()
   
    If Event >0
     
      Select Event
         
        Case #PB_Event_Menu ; event menu
         
        Case #PB_Event_Gadget ;  event gadgets to test
         
        Case #WM_LBUTTONDOWN
          MouseClic = 1
         
        Case #WM_LBUTTONUP
          MouseClic = 0
         
        Case #PB_Event_CloseWindow
          quit = 1
         
      EndSelect
     
    EndIf
   
  Until Event = 0 Or event = #WM_LBUTTONDOWN Or Event = #WM_LBUTTONUP

  ; we need to test what we are doing on the screen surface
  If Mx>0 And My>0 And Mx<ScreenWidth()-1 And My<ScreenHeight()-1
   
    If Inscreen = 0
      Inscreen = 1
      ReleaseMouse(0)
      MouseLocate(mx-canvasX, My-canvasY)
    EndIf
   
    If MouseClic ; on a cliqué, on peut faire des actions sur le screen.
     
      ReleaseMouse(0)
      Inscreen = 1
     
      MouseLocate(mx-canvasX, My-canvasY)
      ExamineMouse()
      x = MouseX()
      y = MouseY()
      Debug Str(x)+"/"+Str(y)
     
      ClearScreen(0)           
      ;  display sprites here
      FlipBuffers()
     
    Else ; other actions/event // ou d'autres actions ne nécessitant pas de rester cliqué
         ; If needed, release the mouse // si besoin, on release la souris
      ReleaseMouse(1)
     
      ClearScreen(0)           
      ; here, we can display the sprites
      FlipBuffers()
     
    EndIf
   
  Else
    
    If inscreen = 1
      Inscreen = 0
      ReleaseMouse(1)
    EndIf
   
  EndIf

  ; event keyboard
  If ExamineKeyboard()
   
  EndIf

Until quit = 1
