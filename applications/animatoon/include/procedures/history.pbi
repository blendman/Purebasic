
; animatoon 
; by blendman
; pb 5.22/5.31
; date : 01/07/2015
; modified : 02/07/2015



; Scripts (actions)

Procedure ExportScript()
  
  
  
EndProcedure

Procedure SaveScript(Event)  
    
  Shared Nscript
  
  If OptionsIE\DoScript = 1
    
    Nscript = ArraySize(Script())
    Debug "on crée le script N° "+Str(Nscript)
    OptionsIE\DoScript = 2
    
  EndIf
  
  
  If OptionsIE\DoScript = 2
    
    If event = #PB_Event_Menu Or event =#PB_Event_Gadget
      
      If EventMenu() <> #Menu_ActionStop And EventMenu() <>#Menu_ActionRun And EventMenu() <>#Menu_ActionSave
        
        n = ArraySize(Script(Nscript)\event())
        
        Debug "on ajoute 1 event "+Str(n)
        
        Script(Nscript)\event(n)\Event = event
        
        Select event 
            
          Case #PB_Event_Menu
            id = EventMenu()
            Debug "on a ouvert le menu "+Str(id)
            
          Case  #PB_Event_Gadget
            id = EventGadget()
            Debug "on a utilisé le gadget "+Str(id)
        EndSelect  
        Script(Nscript)\event(n)\id = id
        ReDim Script(Nscript)\event(n+1)
        
        
      EndIf
      
    EndIf
    
  EndIf
  
EndProcedure
Macro RunScript(sc)
  
  If OptionsIE\DoScript = 5
    
    If OptionsIE\NbScript < ArraySize(Script(sc)\event())
      sc_ev = OptionsIE\NbScript
      event = Script(sc)\event(sc_ev)\Event
      
      Select event 
          
        Case #PB_Event_Menu
          EventMenu = Script(sc)\event(sc_ev)\id 
          
        Case  #PB_Event_Gadget
          EventGadget = Script(sc)\event(sc_ev)\id 
          
      EndSelect
      Debug "on run le script "+Str(ev) +" et l'event "+Str(sc_ev)
      OptionsIE\NbScript +1
    Else
      OptionsIE\DoScript = 0
      OptionsIE\NbScript = 0
    EndIf
    
  EndIf
  
EndMacro
Procedure StopScript()
  
  OptionsIE\DoScript = 0
  
EndProcedure



; History
Procedure SaveHistory(event)
  
EndProcedure
Procedure UndoHistory(event,sens=1)
  
EndProcedure


; proce 
Procedure ImageForUndo(save=1)
  
  
  If save = 1 ; on sauve l'image pour l'undo
    If OptionsIE\ImageHasChanged = 1
      OptionsIE\ImageHasChanged = 2
      CopySprite(Layer(layerid)\sprite,#Sp_CopyForsave,#PB_Sprite_AlphaBlending)
      SaveSprite(#Sp_CopyForsave,"save_"+Str(layerId)+"_"+Str(OptionsIE\UndoState)+".png",#PB_ImagePlugin_PNG)
      FreeSprite2(#Sp_CopyForsave)
      If OptionsIE\UndoState < OptionsIE\Maxundo
        OptionsIE\UndoState +1
      Else
        OptionsIE\UndoState = 0
      EndIf      
    EndIf
    
  Else ; load
    
    
    
  EndIf
  
  
EndProcedure


; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 13
; Folding = -A-
; EnableUnicode
; EnableXP