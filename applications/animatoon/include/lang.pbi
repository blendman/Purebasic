
CompilerIf #PB_Compiler_IsIncludeFile = 1

  ; Lang and menu
  
If OpenPreferences("Pref.ini")
  OptionsIE\Lang$ = ReadPreferenceString("Lang","eng")
  ClosePreferences()
EndIf

; Debug "lang " + OptionsIE\Lang$

; on créé la map() pour le fichier  de lang
Global NewMap Lang0.s()

Procedure.s Lang(keyword$)
  
  Define word$
  
  ; pour définir le mot par défaut, si le fichier ini de langue ne le contient pas.
  word$ = Lang0(keyword$)
  If word$ <> ""
    keyword$ = word$
  EndIf
  
  ProcedureReturn keyword$
  
EndProcedure

Procedure ReadLang(keyword$,m=0)
  Define word$
  
  Lang0(keyword$)= keyword$
  
  If m = 0
    word$= ReadPreferenceString(keyword$,keyword$)
    If word$ <> ""
      Lang0(keyword$) = ReplaceString(word$,"#",Chr(13))
    EndIf
  EndIf 
  
EndProcedure

; Debug "data\Lang\"+OptionsIE\Lang$+".ini"

If OpenPreferences("data\Lang\"+OptionsIE\Lang$+".ini")
  
  
  ;{*** menu
  
  ;{ window main
  
  ;{ menu main
  
  ; files
  ReadLang("File")
  ReadLang("New")
  ReadLang("Open")
  ReadLang("Save")
  ReadLang("Save As")
  ReadLang("Save image")
  ReadLang("Import")
  ReadLang("Export")
  ReadLang("Export layer image")
  ReadLang("Export layers (in png)")
  ReadLang("Export layers (zip)")
  ReadLang("Preferences")
  ReadLang("Close")
  ReadLang("Exit")
  
  
  ; edition
  ReadLang("Edit")
  ReadLang("Undo")
  ReadLang("Redo")
  ReadLang("UndoLimit")
  ReadLang("Copy")
  ReadLang("Cut")   
  ReadLang("Paste")
  ReadLang("Duplicate")
  ReadLang("Clear")
  ReadLang("Fill with pattern")
  ReadLang("Fill the transparent pixel with BG color")
  ReadLang("Fill with BG color")
  ReadLang("Fill")
  
  ; view
  ReadLang("View")
  ReadLang("Zoom +")
  ReadLang("Zoom -")
  ReadLang("Zoom")
  ReadLang("Reset view")
  ReadLang("Center view")
  ReadLang("Screen")
  ReadLang("Update the screen (Real Time)")
  ReadLang("Change the Center")
  ReadLang("Refresh the screen")
  ReadLang("Screen Filtering")
  
  ReadLang("StatusBar")
  ReadLang("Preview")
  
  ; selection
  ReadLang("Selection")
  ReadLang("Extend")
  ReadLang("Contract")
  ReadLang("Select All")  
  ReadLang("Deselect")  

  
  ; Image
  ReadLang("Image")
  ReadLang("Canvas Size")
  ReadLang("Image Size")
  ReadLang("Crop")
  ReadLang("Adjustement")
  ReadLang("Inverse Color")
  ReadLang("Desaturate")
  ReadLang("Brightness/constrast")
  ReadLang("Color balance")
  ReadLang("Level")
  ReadLang("Posterize")
  ReadLang("Enhance edge")
  ReadLang("Define angle")
  ReadLang("Rotation")
  ReadLang("Rotation free")
  ReadLang("Rotation 90")
  ReadLang("Rotation 180")
  ReadLang("Rotation 270")
  
    ; layers
  ReadLang("Layer")
  ReadLang("Add a layer")
  ReadLang("Delete the layer")
  ReadLang("Duplicate the layer")
  ReadLang("Move layer down")
  ReadLang("Move layer up")
  ReadLang("Merge layer down")
  ReadLang("Merge all layers")
  ReadLang("Flip layer horizontaly")
  ReadLang("Flip layer verticaly")
  ReadLang("Rotate the layer")
  
  ; FILTERS
  ReadLang("Filters")
  Readlang("Plugins")
  ReadLang("Noise")
  ReadLang("Clouds")
  ReadLang("Blur")
  ReadLang("Sharpen")
  ReadLang("Sharpen alpha")
  ReadLang("Offset")
  
  ; actions
  ReadLang("Actions")
  ReadLang("Save action")
  ReadLang("Stop action")
  ReadLang("Run action")
  

  ; Window
;   ReadLang("Windows")
;   ReadLang("Cascade")
;   ReadLang("Close all windows")
  
  ; Mode
;   Readlang("Mode")
;   Readlang("ModeText")
  
  
  ; Tools
;   ReadLang("Tools")
;   ReadLang("PageProperties")
  
  ; Help
  ReadLang("Help")
  ReadLang("About")
  ReadLang("Made in")
  ReadLang("by")
  ReadLang("Thanks to :")
  ReadLang("Date")
  
  ;}
  
  ;{ popup menu layer
  ReadLang("Layer bitmap")
  ReadLang("Layer text")
  ReadLang("Layer background")
  ReadLang("Layer group")
  ReadLang("Layer shape")
  ReadLang("Layer vecto")
  ;}
  
  ;}
  
  ; divers / misc
  ReadLang("Insert")
  ReadLang("Add")
  ReadLang("Delete")
  ReadLang("Merge")
  ;}
  
  
  ;{*** status bar
  Readlang("Position")
  
  ;}
  
  
  ;{*** gadgets
  
  ; boutons generaux
  ReadLang("Parameters")
  Readlang("Ok")
  Readlang("Cancel")
  ReadLang("Options")
  ReadLang("Name")
  Readlang("Templates")  
  Readlang("Resolution")  
  
  ;{--------- window main
  
  ;{ Toolbar
  ReadLang("Filter of the brush.")
  ReadLang("Light")
  ReadLang("Dark")
  ReadLang("Color")
  ReadLang("Pixel")
  ReadLang("Noise")
  ReadLang("Water")
  ReadLang("Glass")
  ReadLang("Smudge")
  ReadLang("Blur")
  ReadLang("Ground")
  ReadLang("Line")
  
  ReadLang("Pen")
  ReadLang("Brush")
  ReadLang("Particles")
  ReadLang("Eraser")
  ReadLang("Spray")
  ReadLang("Fill bucket")
  ReadLang("Clone stamp tool")
  ReadLang("Pick color")
  ReadLang("Line")
  ReadLang("Box")
  ReadLang("Ellipse")
  ReadLang("Shape")
  ReadLang("Gradient")
  ReadLang("Selection tool")
  ReadLang("Move tool")
  ReadLang("Transform tool")
  ReadLang("Rotate tool")
  ReadLang("Hand tool")
  ReadLang("Text")
  ;}
  
  
  ;** PANEL TOOL
  
  ;{ -- Tool brush, eraser, pen
  ; gen
  ReadLang("Gen")
  ReadLang("Stroke")
  ReadLang("Aspect")
  ReadLang("Trim")
  Readlang("Crop the image of the brush")
  
  ; tra
  ReadLang("Tra")
  ReadLang("Transparency")
  
  ; dyn
  ReadLang("Dyn")
  ReadLang("Scatter")
  ReadLang("Angle")
  
  ; col
  ReadLang("Col")
  ReadLang("Water")  
  ReadLang("Add water")  
  ReadLang("Wash")
  ReadLang("Viscosity")
  ReadLang("Mixing color")
  
  ReadLang("Misc")
  
  ReadLang("Pressure")
  ReadLang("R")
  
  ReadLang("Misc")
  ReadLang("Symetry")
  ;}
  
  ;{ -- Tool Move, transform, rotate
  ReadLang("Lock X")
  ReadLang("Lock Y")
  ReadLang("Proportion")
  ReadLang("Confirm action")
  ;}
  
  ;{ -- Tool Box, ellipse, gradient, line
  ;ReadLang("Lock X")
  ;ReadLang("Lock Y")
  ReadLang("Outlined")
  ;}
  
  ;{ -- Tool Text
  ReadLang("Text")
  ReadLang("New text")
  ;}
  
  
  
  ;** OTHER PANELS  
  
  ReadLang("Color")
  
  
   ; layers
  ReadLang("Layers")
  ReadLang("Layer Opacity")
  ReadLang("Lock Alpha")
  ReadLang("Lock Move")
  ReadLang("Lock Paint")
  ReadLang("Lock Layer")
  ReadLang("Move the layer up")
  ReadLang("Move the layer down")
  ReadLang("Add A mask alpha")
  ReadLang("Layer Properties")
  ReadLang("Blending Mode")
  
  ; preset
  ReadLang("Presets")
  ReadLang("Refresh the bank presets")
  ReadLang("Open a bank presets")
  ReadLang("Save the current preset")
  ReadLang("Export the current preset")
  ReadLang("Brush name")
  
  ; options
  ReadLang("Options")
  ReadLang("Paper")
  
  ; swatch
  ReadLang("Swatch")
  ReadLang("Save Swatch")
  ReadLang("Create a new swatch")
  ReadLang("Open a swatch")
  ReadLang("Merge a swatch")
  ReadLang("Save the swatch")
  ReadLang("Export the swatch")
  ReadLang("Edit the swatch")
  ReadLang("From Image")
  ReadLang("Merge")
  ReadLang("Insert")
  ReadLang("Add")
  ReadLang("Sort")
  ReadLang("Delete")
  
  ; rough
  ReadLang("Rough")
  ReadLang("Draw or pick the color (on the roughboard)")
  ReadLang("Open an image on the roughboard")
  ReadLang("Create a new roughboard")
  ReadLang("Save the roughboard")
  ReadLang("Export the roughboard")
  ReadLang("Save Roughboard Image")
  
  ; degradé
  ReadLang("Gradient")
 
  ; pattern (tampon)
  
  
  ;}
 
  
  ;{--------- Other window
  
  
  
  ;{ window preference
  ReadLang("General")
  ReadLang("Interface")
  ReadLang("Debugging")
  ReadLang("Langage")
  ReadLang("DelTempFile")
  ReadLang("Debug")
  ReadLang("UseDebugger")
  ReadLang("Colors")
  ReadLang("BGcolor")
  ReadLang("Animation")

  ;}
  
  ;{ window Help
  ReadLang("Release Log")
  ReadLang("Todo List")
  ReadLang("Licence")
  
  ;}
  
  ;{ Window swatch edit
  
  ReadLang("Swatch properties")
  ReadLang("Swatch Global name")
  ReadLang("Swatch name")
  ReadLang("Swatch Column")
  ReadLang("Number of Columns for the swatch")
  
  ;}
  
  ;{ window layer
  
  ReadLang("Layer Properties")
  ReadLang("Drop shadow")
  ReadLang("Inner shadow")
  ReadLang("Outer glow")
  ReadLang("Inner glow")
  ReadLang("Border")
  ReadLang("Style")
  ReadLang("New Style")
  ;}
  
  
  ; a effacer
  ;{ Image editor : window, menu, tooltip
  
  ; panel
  ReadLang("Color") 
  ReadLang("Brush") 
  ReadLang("Presets") 
  ReadLang("Swatch") 
  ReadLang("RoughBoard") 
  ReadLang("Pattern")
  ReadLang("Layers")
  ReadLang("Tools")

  
  ; Files
  ReadLang("New Image") 
  ReadLang("Open Image") 
  ReadLang("Open Teo Document") 
  ReadLang("File outdated") 
  ReadLang("Import image") 
  ReadLang("Save image")
  ReadLang("Save Teo")
  ReadLang("Export image")
  
  ; Edition
   ReadLang("Select all")
   ReadLang("Deselect")
 
  
   ; View
   ReadLang("Show ToolBar File")
   ReadLang("Show ToolBar Tool")
   ReadLang("view")
   ReadLang("Grid")
   ReadLang("Zoom")
   ReadLang("Zoom -")
   ReadLang("Zoom +")
   ReadLang("Zoom 50%")
   ReadLang("Zoom 100%")
   ReadLang("Zoom 200%")
   ReadLang("Zoom 300%")
   ReadLang("Zoom 400%")
   ReadLang("Zoom 500%")
   
   ; Filters
   ReadLang("Filters")
   ReadLang("Noise")
   ReadLang("Clouds")

   
   ; Toolbar / tooltip
   ReadLang("Brush form")
   
   ; panel tools options / Tooltip
   ReadLang("Scatter")
   ReadLang("Pas")
   ReadLang("Size")
   ReadLang("Mix")
   ReadLang("Visco")
   
   
   ReadLang("Brush mix")
   ReadLang("Brush visco")
   ReadLang("Brush size")
   ReadLang("Brush alpha")
   ReadLang("Brush rotation")
   ReadLang("Opacity color2")
   
   ReadLang("Brush previous")
   ReadLang("Brush next")
   ReadLang("Brush preview")

   
   ReadLang("Outline")
   ReadLang("Outline Size")
   ReadLang("Plain")
   ReadLang("All layers")
   ReadLang("Use all layers")
   ReadLang("Custom")
   ReadLang("Image")
   ReadLang("Circle")
   ReadLang("Square")
   
   ReadLang("Set font")
   ReadLang("Font")
   ReadLang("Set text")
   ReadLang("Text")
   
   ; Tooltips
   ReadLang("FGColor")
   
   
   ; transformation
   ReadLang("Transform")
   ReadLang("CanvasSize")
   ReadLang("ImageSize")
   
   ReadLang("New size")
   ReadLang("Interpolation")
   ReadLang("Width")
   ReadLang("Height")
   ReadLang("Smooth")
   ReadLang("Hard")
   
   ReadLang("Crop")
   ReadLang("KeepProportion")
   ReadLang("ImageChangeColor")
   ReadLang("Inverse Color")
   ReadLang("Desaturation")
   ReadLang("Contrast")
   ReadLang("Balance Color")
   ReadLang("Brightness")
   
   
   ; layers
   
   ReadLang("Add layer")
   ReadLang("Del layer")
   ReadLang("Duplicate layer")
   ReadLang("Merge layer")
   ReadLang("Merge all")
   ReadLang("Merge visible")
   ReadLang("Layer Up")
   ReadLang("Layer Down")
   ReadLang("Adjust Layer to image")
   
   
   ReadLang("View layer")
   ReadLang("Alpha layer")
   
   ReadLang("Lock Alpha")
   ReadLang("Lock Move")
   ReadLang("Lock Paint")
   ReadLang("Lock Layer")
   
   ReadLang("Layer is Locked")
   ReadLang("Paint mode locked")
   ReadLang("Layer is masked")
  
  ; blendmode
  ReadLang("Blending Mode")
  
  ReadLang("Multiply")
  ReadLang("Additive")
  ReadLang("Screen")
  ReadLang("Overlay")
  ReadLang("Inverse")
  ReadLang("ColorBurn")
  ReadLang("Dissolve")
  ReadLang("Difference")
  ReadLang("Exclusion")
  ReadLang("Darken")
  ReadLang("Lighten")
  ReadLang("Hardlight")
  ReadLang("Clearlight")
  ReadLang("Colorlight")
  
  ; Panel interface
  Readlang("Paper")
  
  ; message   
  Readlang("Bad Format") 
  ReadLang("Cannot load image") 
  ReadLang("Overwrite this file?")
  
  ; IE preference
  Readlang("Delay RT") 

   
  
  
  ;}
  
  
  
  ;}
  
  ;}
  
  
  ;{*** message
  Readlang("Not implemented")
  Readlang("Attention")
  ReadLang("Loose Format")
  
  ReadLang("Action Permanent")
  ReadLang("The file exist. Save over it ?")
  Readlang("No file to open. Please with the old .ani format.")
  
  ReadLang("The layer mask is hiden")
  ReadLang("Move all viewed layers")
  ReadLang("Transform all viewed layers")
  ReadLang("Rotate all viewed layers")
  
  ReadLang("Confirm Exit") 
  Readlang("Can't find")
  Readlang("Can't open file")
  Readlang("File is open")
  Readlang("Unable to update the temp file")
  ReadLang("Unable to load the dll")
  ReadLang("Info")
  ReadLang("Error") 
  ReadLang("Date") 
  ReadLang("Version") 
  ReadLang("Logo by") 
  ReadLang("Icon by") 
  ReadLang("Thanks to") 
  
  

  ;}
  
  
  ClosePreferences()

EndIf

CompilerEndIf

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 20
; FirstLine = 7
; Folding = 0dAA5
; EnableXP