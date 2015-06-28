InitSprite()
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

Repeat
 
  mx = WindowMouseX(0) - ScreenX
  my = WindowMouseY(0) - ScreenY
  ; event gadgets, menus, mouse, etc..
 
  Repeat
    ; Needed to not freeze the window / il faut ça pour vérifier les events, afin de ne pas bloquer la fenêtre
    Event       = WaitWindowEvent(1)
    EventMenu   = EventMenu()
    EventGadget = EventGadget()
    EventType   = EventType()
    EventWindow = EventWindow()
   
    If Event >0
     
      Select Event
         
        Case #PB_Event_Menu ; menu to test / les events menus à tester
         
        Case #PB_Event_Gadget ; event gadgets to test // les event gadgets à tester
         
        Case #WM_LBUTTONDOWN
          MouseClic = 1
         
        Case #WM_LBUTTONUP
          MouseClic = 0
         
        Case #PB_Event_CloseWindow
          quit = 1
         
      EndSelect
     
    EndIf
   
  Until Event = 0 Or event = #WM_LBUTTONDOWN Or Event = #WM_LBUTTONUP
 
  ; puis je vérifie ce que je fais sur le screen
  If Mx>0 And My>0 And Mx<ScreenWidth()-1 And My<ScreenHeight()-1
   
    If MouseClic ; on a cliqué, on peut faire des actions sur le screen.
     
      ;Debug "on clique sur le screen"     
      ClearScreen(0)           
      ; ici, on display les sprites par exemple       
      FlipBuffers()
     
    Else ; ou d'autres actions ne nécessitant pas de rester cliqué
       
      ;Debug "on est sur le screen, mais on ne clique pas dessus"
      ClearScreen(0)           
      ; ici, on display les sprites par exemple     
      FlipBuffers()
     
    EndIf
   
  Else
    ;Debug "on n'est plus sur le screen, mais l'interface, gadget, etc..)"
       
  EndIf
 
  ; SI besoin, on vérifie les event keyboard
  If ExamineKeyboard()
   
  EndIf
 
Until quit = 1
