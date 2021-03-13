; Dictionnaire : sélection du langage

Global NewMap dico.s()

If OpenPreferences("txt\lang\"+lang$+".ini")

;-- menu - general
PreferenceGroup("menutop")
dico("File")= ReadPreferenceString("0","File")
dico("Edit")= ReadPreferenceString("1","Edit")
dico("View")= ReadPreferenceString("2","View")
dico("Images")=ReadPreferenceString("3","Images")
dico("Layers")=ReadPreferenceString("4","Layers")
dico("Tools")=ReadPreferenceString("5","Tools")
dico("Parameters")=ReadPreferenceString("6","Parameters")
dico("Interface")=ReadPreferenceString("7","Interface")
dico("Window")=ReadPreferenceString("8","Window")
dico("Help")=ReadPreferenceString("9","Help")

;-- menu - File
PreferenceGroup("1")
dico("New")=ReadPreferenceString("1","New")
dico("Open")=ReadPreferenceString("2","Open")
dico("Recent")=ReadPreferenceString("Recent","Recent")
dico("Import")=ReadPreferenceString("3","Import")
dico("Imp_img_layer")=ReadPreferenceString("3_1","Import an Image on the layer")
dico("Imp_preset")=ReadPreferenceString("3_2","Import a brush preset")
dico("Imp_swatch")=ReadPreferenceString("3_3","Import a swatch")

dico("Export")=ReadPreferenceString("6","Export")
dico("Exp_img_jpg") = ReadPreferenceString("6_1","Export the image as jpg")
dico("Exp_img_png") = ReadPreferenceString("6_2","Export the image as png")
dico("Exp_lay_png") = ReadPreferenceString("6_2","Export the layer as png")


dico("Save")=ReadPreferenceString("5","Save")
dico("SaveAs")=ReadPreferenceString("7","Save As..")
dico("Quit")=ReadPreferenceString("8","Quit")

;-- menu - Edit
PreferenceGroup("2")
dico("Undo")=ReadPreferenceString("1","Undo")
dico("Redo")=ReadPreferenceString("2","Redo")
dico("Copy")=ReadPreferenceString("4","Copy")
dico("Past")=ReadPreferenceString("5","Past")
dico("Cut")=ReadPreferenceString("3","Erase")


;-- menu - View
PreferenceGroup("3")
dico("Reset")=ReadPreferenceString("ResetView","Reset The View")
dico("CenterView")=ReadPreferenceString("4","Center The View")
dico("Zoom+")=ReadPreferenceString("2","Zoom +")
dico("Zoom-")=ReadPreferenceString("3","Zoom -")
dico("Zoom50%")=ReadPreferenceString("5","Zoom 50%")
dico("Zoom100%")=ReadPreferenceString("6","Zoom 100%")
dico("Zoom200%")=ReadPreferenceString("7","Zoom 200%")
dico("Zoom400%")=ReadPreferenceString("8","Zoom 400%")
dico("Zoom800%")=ReadPreferenceString("Zoom800","Zoom 800%")
dico("Zoom1600%")=ReadPreferenceString("Zoom1600","Zoom 1600%")
dico("Measure")=ReadPreferenceString("9","Measure")
dico("Mark")=ReadPreferenceString("10","Mark")
dico("Grid")=ReadPreferenceString("11","Grid")

;-- menu - Images
PreferenceGroup("4")
dico("ImageSize")=ReadPreferenceString("ImageSize","Size of the image")
dico("CanvasSize")=ReadPreferenceString("CanvasSize","Size of the canvas")
dico("Mode")=ReadPreferenceString("Mode","Mode")
dico("RGB")=ReadPreferenceString("RGB","RGB")
dico("ResizeImage") = ReadPreferenceString("ResizeImage","Resize the image")

;-- menu - Layers
PreferenceGroup("5")
dico("Newlayer")=ReadPreferenceString("1","Add a new layer")
dico("Suplayer")=ReadPreferenceString("2","Delete the activ layer")
dico("Masklayer")=ReadPreferenceString("3","Add a layer mask")
dico("Reglayer")=ReadPreferenceString("4","Add a n Adjustement layer")

dico("Adjustlayer") = ReadPreferenceString("5","Adjustement layer")
dico("AdL_level") = ReadPreferenceString("5_1","Level")
dico("AdL_light") = ReadPreferenceString("5_2","Light/contraste")
dico("AdL_satur") = ReadPreferenceString("5_3","Saturation")
dico("AdL_balcol") = ReadPreferenceString("5_4","Color balance")
dico("AdL_blur") = ReadPreferenceString("5_5","Blur")
dico("AdL_neg") = ReadPreferenceString("5_6","Negative")
dico("AdL_pixeliz") = ReadPreferenceString("5_7","Pixelisation")

dico("Layerdown") = ReadPreferenceString("6","Move the Layer down")
dico("Layerup") = ReadPreferenceString("7","Move the Layer Up")

dico("P_l_opac") = ReadPreferenceString("8_1","Opacity")
dico("P_l_preservTra") = ReadPreferenceString("8_2","Keep the transparency")



;-- menu - tools
PreferenceGroup("6")
dico("Line")=ReadPreferenceString("1","Line")
dico("SimpleLine")=ReadPreferenceString("1_1","Simple Line")
dico("ThickLine") = ReadPreferenceString("1_2","Thick Line")
dico("SpeedLine") = ReadPreferenceString("1_3","Speed Line")
dico("RadialLine") = ReadPreferenceString("1_4","Radial Line")

dico("GeomShape")=ReadPreferenceString("2","Shapes")
dico("Sh_circle")=ReadPreferenceString("2_1","Circle")
dico("Sh_circle_outline")=ReadPreferenceString("2_2","Circle outlined")
dico("Sh_box")=ReadPreferenceString("2_3","Box")
dico("Sh_boxround")=ReadPreferenceString("2_4","Rounded Box")
dico("Sh_boxoutline")=ReadPreferenceString("2_5","Box Outlined")

dico("CustomShape")=ReadPreferenceString("3","CustomShapes")
dico("CSh_no")=ReadPreferenceString("CSh_no","-----")

dico("Brush") = ReadPreferenceString("4","Brush")   
dico("BrushCircle") =ReadPreferenceString("4_1","Brush Circle")
dico("BrushCustom") =ReadPreferenceString("4_2","Brush Custom")
dico("BrushLine") =ReadPreferenceString("4_3","Brush line")
 
;-- menu - Parameters
PreferenceGroup("7")
dico("P_random") = ReadPreferenceString("1","Random")
dico("P_r_size") =  ReadPreferenceString("1_1","Random Size")
dico("P_r_rot") =  ReadPreferenceString("1_2","Random Rotation")
dico("P_r_opac") =  ReadPreferenceString("1_3","Random Opacity")
dico("P_r_col") =  ReadPreferenceString("1_4","Random Color")
dico("P_r_dif") =  ReadPreferenceString("1_5","Random Scatter")

dico("P_brush") =  ReadPreferenceString("2","Brush Aspect")
dico("P_b_dif") =  ReadPreferenceString("2_1","Scatter")
dico("P_b_space") =  ReadPreferenceString("2_2","Brush Space")
dico("P_b_alpha") =  ReadPreferenceString("2_3","Transparence")
dico("P_b_color") =  ReadPreferenceString("2_4","Color")
dico("P_b_anim") =  ReadPreferenceString("2_5","Brush animated")

dico("P_size") =  ReadPreferenceString("3","Size of the brush")
dico("P_s_size") =  ReadPreferenceString("3_1","General Size")
dico("P_s_w") =  ReadPreferenceString("3_2","Width of the brush")
dico("P_s_h") =  ReadPreferenceString("3_3","Height of the brush")
dico("P_s_min") =  ReadPreferenceString("3_4","Minimum Size of the brush")

dico("P_Nextb") =  ReadPreferenceString("4_1","Next Brush")
dico("P_prevb") =  ReadPreferenceString("4_2","Previous Brush")

dico("P_wc_Mix") =  ReadPreferenceString("5_1","Blend mix")
dico("P_wc_visco") =  ReadPreferenceString("5_2","Viscosity")

;-- menu - interfaces
PreferenceGroup("8")
dico("Hide")=ReadPreferenceString("1","Hide All")

;-- menu - window
PreferenceGroup("9")
dico("Pref")=ReadPreferenceString("Pref","Preferences")


;-- menu - help
PreferenceGroup("10")
dico("About") = ReadPreferenceString("4","About")
dico("Maj") = ReadPreferenceString("1","Update")
dico("HelpChm") = ReadPreferenceString("2","Help (html)")
dico("HelpTxt") = ReadPreferenceString("3","Help (txt)")


; panel general

PreferenceGroup("Panel")
dico("Layers")=ReadPreferenceString("Layers","Layers")
dico("Swatch")=ReadPreferenceString("Swatch","Swatch")
dico("Options")=ReadPreferenceString("Options","Options")
dico("Infos")=ReadPreferenceString("Infos","Infos")
dico("Brush")=ReadPreferenceString("Brush","Brush")
dico("Preset")=ReadPreferenceString("Preset","Preset")
dico("Roughboard")=ReadPreferenceString("Roughboard","RoughBooard")


; UI general
PreferenceGroup("General")
dico("SizeDoc") = ReadPreferenceString("1","Size of the document")
dico("Ed_size") = ReadPreferenceString("2_1","Siz")
dico("Ed_rot") = ReadPreferenceString("2_2","Rot")
dico("Ed_tra") = ReadPreferenceString("2_3","Opac")
dico("Ed_dif") = ReadPreferenceString("2_4","Dif")
dico("Ed_mix") = ReadPreferenceString("2_5","Mix")
dico("Ed_rand") = ReadPreferenceString("3","Random")
dico("Ed_r_siz") = ReadPreferenceString("3_1","Size")
dico("Ed_r_rot") = ReadPreferenceString("3_2","Rotation")
dico("Ed_r_tra") = ReadPreferenceString("3_3","Opacity")
dico("Ed_r_dif") = ReadPreferenceString("3_4","Scatter")
dico("Ed_r_col") = ReadPreferenceString("3_5","Color")
dico("Ed_r_mix") = ReadPreferenceString("3_6","Blend (mix)")

dico("Lang") = ReadPreferenceString("5_1","Langage")

PreferenceGroup("Message")
dico("msg_notImplemented") = ReadPreferenceString("1","Not Implemented")
dico("msg_update") = ReadPreferenceString("2","The version is ok")

PreferenceGroup("button")
dico("Btn_ok") = ReadPreferenceString("1_1","Ok")
dico("Btn_cancel") = ReadPreferenceString("1_2","Cancel")


ClosePreferences()

EndIf


; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 204
; FirstLine = 151
; Folding = -
; EnableXP