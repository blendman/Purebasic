


Macro Layer_DrawImg(u,alpha)
  If layer(u)\Typ = #Layer_TypBG
    For i=0 To layer(u)\w / layer(u)\W_Repeat 
      For j =0 To layer(u)\h / layer(u)\H_Repeat 
        DrawAlphaImage(ImageID(layer(u)\image),i*layer(u)\W_Repeat ,j*layer(u)\H_Repeat,alpha)
      Next j
    Next i
  Else
    DrawAlphaImage(ImageID(layer(u)\image),0,0,alpha)
  EndIf  
EndMacro


; Layer UI & gadget
Procedure Layer_importImage(update=1)
  
  filename$ = OpenFileRequester("Import Image as a new layer","","Allformat|*png;*.jpg;*.bmp|png|*.png|jpg|*.jpg|bmp|*.bmp|",0)
  
  If filename$ <>""
    
    temp = LoadImage(#PB_Any,Filename$)
    If temp  = 0
      MessageRequester("Error", "Unable to image the image as new layer.")
    Else
      
      ; on ajoute un layer
      Layer_Add()
      
      ; et on dessine l'image dessus.
      If StartDrawing(ImageOutput(layer(LayerId)\image))
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        DrawAlphaImage(ImageID(temp),0,0)
        StopDrawing()
      EndIf
    
      If update
        NewPainting = 1
        ScreenUpdate()
      EndIf
      
      FreeImage2(temp)
    EndIf
  EndIf
  
EndProcedure
Procedure Layer_UpdateList(u=-1)
  
  IE_UpdateLayerUi() 

EndProcedure
Procedure IE_UpdateLayerUi() 
  
  n = ArraySize(layer())
  
  If OpenGadgetList(#G_LayerList)
    
    For i =0 To n
       Layer_updateUi(i)  
    Next
    CloseGadgetList()
    
  EndIf

  
EndProcedure


; blendmode
Procedure Layer_ConvertToBm(i)
  
  If IsImage(layer(i)\ImageTemp) = 0
    Layer(i)\ImageTemp = CreateImage(#PB_Any,doc\w,doc\h, 32,#PB_Image_Transparent)
  EndIf

  If StartDrawing(ImageOutput(layer(i)\ImageTemp))
    
    DrawingMode(#PB_2DDrawing_AllChannels)
    
    ; d'abord, on doit ajouter une box de la couleur nécessaire, pour certain BM
    Select Layer(i)\bm
        
      ;Case #Bm_Darken
        ;Box(0,0,doc\w,doc\h,RGB(255,255,255))
        
;       Case 
        
    EndSelect
    
        
    
    ; puis pour le mask alpha
    If layer(layerid)\MaskAlpha =1
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      DrawAlphaImage(ImageID(Layer(i)\ImageAlpha),0,0)    
      
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@Filtre_MaskAlpha())
    Else
      DrawingMode(#PB_2DDrawing_AlphaBlend)
    EndIf
    
    SetBm(i,0)    

   ;  DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawAlphaImage(ImageID(layer(i)\Image),0,0)    
    StopDrawing()    
  EndIf
    
EndProcedure
Procedure Layer_GetBm(id)
  ; à changer si on ajoute des blendmode supplémentaires !
  ; Voir LAyer_SetBm()
  Select Layer(id)\bm
    Case #Bm_Normal
      bm = #SetBm_normal
      
    Case #Bm_Multiply
      bm = #SetBm_multiply
      
    Case #Bm_Add
      bm = #SetBm_Add
      
    Case #Bm_Screen
      bm = #SetBm_Screen
      
    Case #Bm_Clearlight
      bm = #SetBm_ClearLight
      
    Case #Bm_ColorBurn
      bm = #SetBm_ColorBurn
    
    Case #Bm_Darken
      bm = #SetBm_Darken
      
    Case #Bm_LinearLight
      bm = #SetBm_LinearLight
      
    Case #Bm_Overlay
      bm = #SetBm_Overlay
      
    Case #Bm_Inverse
      bm = #SetBm_Invert
      
    Case #Bm_LinearBurn
      bm = #SetBm_LinearBurn
      
    Case #Bm_Lighten
      bm = #SetBm_Lighten
      
  EndSelect
  ProcedureReturn bm
EndProcedure
Procedure Layer_SetBm(bm)
  
  Select bm
      
    Case #SetBm_normal
      Layer(Layerid)\bm = #Bm_Normal
      
    Case #SetBm_Multiply 
      Layer(Layerid)\bm = #Bm_Multiply
      
    Case #SetBm_Add
      Layer(Layerid)\bm = #Bm_Add
      
    Case #SetBm_Screen
      Layer(Layerid)\bm = #Bm_Screen
      
    Case #SetBm_ClearLight
      Layer(Layerid)\bm = #Bm_Clearlight
      
    Case #SetBm_Darken
      Layer(Layerid)\bm = #Bm_Darken
      
    Case #SetBm_ColorBurn
      Layer(Layerid)\bm = #Bm_ColorBurn
      
    Case #SetBm_LinearLight
      Layer(Layerid)\bm = #Bm_LinearLight
      
    Case #SetBm_LinearBurn
      Layer(Layerid)\bm = #Bm_LinearBurn
      
    Case #Setbm_Overlay
      Layer(Layerid)\bm = #Bm_Overlay
      
    Case #SetBm_Invert
      Layer(Layerid)\bm = #Bm_Inverse
      
    Case #SetBm_Lighten
      Layer(Layerid)\bm = #Bm_Lighten
      
    Case #SetBm_Custom
      Layer(Layerid)\bm = #Bm_Custom
      
  EndSelect
  
  Layer_ConvertToBm(LayerId)
  
EndProcedure



; Layer text
Procedure Layer_UpdateText(i=0,w=0,h=0,mode=0)
  
  ; mode = 2 : only when creating the layer (layer_add())
  With  Layer(i)
    
    
    If StartDrawing(ImageOutput(\Image))      
      DrawingFont(FontID(\FontID))
      H = TextHeight(\Text$)
      W = TextWidth(\Text$)
      ;Debug "nouvelle taille avant calcul : "+Str(W)+"/"+Str(H)
      StopDrawing()
    EndIf
    
    If W > 0 And H > 0
      \W = W
      \H = H
      \NewW = \W
      \NewH = \H
      \CenterX = \W/2
      \CenterY = \H/2
      ResizeImage(\Image,\w,\h)
      ResizeImage(\ImageBM,\w,\h)
    EndIf
    
    ; then we draw the text on the sprite and image
    If StartDrawing(ImageOutput(\Image))
      ; DrawingMode(#PB_2DDrawing_AllChannels)
      ; Box(0, 0, \W, \H, RGBA(0,0,0,255))
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      Box(0, 0, \W, \H, RGBA(0,0,0,0))
      
      DrawingFont(FontID(\FontID))
      DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)
      DrawText(0, 0,\Text$, RGBA(Red(\FontColor),Green(\FontColor),Blue(\FontColor),255))    
      StopDrawing()
    EndIf
    
    
    If mode <> 2 ; mode = 2 : for layer_add() only
      
      FreeSprite2(\sprite)
      \sprite = CreateSprite(#PB_Any,\w,\h,#PB_Sprite_AlphaBlending)
      
      If StartDrawing(SpriteOutput(\Sprite))
        Box(0,0,\w,\h,RGBA(255,255,255,255))
        DrawingMode(#PB_2DDrawing_AlphaChannel)
        Box(0,0,\w,\h,RGBA(0,0,0,0))
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        DrawAlphaImage(ImageID(\image),0,0)
        StopDrawing()
      EndIf 
       ; ZoomSprite(\sprite,\w,\h)
       
    EndIf
    
    
  EndWith
  
EndProcedure
Procedure Layer_ChangeText()
  
  
  With layer(layerid)
    text$ = InputRequester(Lang("Text"),Lang("New Text"),\Text$)
    FontRequester( \FontName$, \FontSize,#PB_FontRequester_Effects,\FontColor,\FontStyle)  
    \FontName$ = SelectedFontName()
    \FontSize  = SelectedFontSize()
    \FontStyle = SelectedFontStyle()
    \FontColor = RGB(Red(brush(action)\Color),Green(brush(action)\Color),Blue(brush(action)\Color)) ; SelectedFontColor()
    FreeFont(\FontID)
    \FontID = LoadFont(#PB_Any,\FontName$,\FontSize,\FontStyle)
    
    Layer_UpdateText(LayerId,0,0,2)
    
    FreeSprite2(\sprite)
    \sprite = CreateSprite(#PB_Any,\w,\h,#PB_Sprite_AlphaBlending)
    
    If StartDrawing(SpriteOutput(\Sprite))
      Box(0,0,\w,\h,RGBA(255,255,255,255))
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      Box(0,0,\w,\h,RGBA(0,0,0,0))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      DrawAlphaImage(ImageID(\image),0,0)
      StopDrawing()
    EndIf
  EndWith

  ScreenUpdate()
  
  
EndProcedure



; add, delete
Procedure Layer_Add(x=0,y=0,txt$="")
  
  Select OptionsIE\LayerTyp
      
    Case #Layer_TypText 
      If openmenu = 0
        FontRequester("Arial", 12, #PB_FontRequester_Effects)  
        FontName$ = SelectedFontName()
        FontSize  = SelectedFontSize()
        ; Debug FontSize
        FontStyle = SelectedFontStyle()
        FontColor = brush(action)\color ; SelectedFontColor()
      EndIf
      
  EndSelect
  
  ReDim layer(LayerNb)
  n = ArraySize(layer())
  LayerId = n
  

  With layer(n)
    
    \typ = OptionsIE\LayerTyp
    
    \id = LayerIdMax ; id unique, même si on supprime un layer
    
    \ImgLayer = CreateImage(#PB_Any, 220,25); for the gadget

    \bm = #Bm_Normal
    \view = 1
    \alpha = 255
    \ordre = n
    
    Select \typ 
        
      Case #Layer_TypBG
        \h = Doc\h
        \w = Doc\w
        \name$ = "Background"+Str(LayerIdMax)
        \W_Repeat = 100
        \H_Repeat = 100
        Debug "bg !!!"
        
      Case #Layer_TypBitmap
        \h = Doc\h
        \w = Doc\w
        \name$ = "Layer"+Str(LayerIdMax)
        
      Case   #Layer_TypText
        \FontName$ = FontName$
        \FontSize  = FontSize
        \FontStyle = FontStyle
        \FontColor = FontColor
        \FontID = LoadFont(#PB_Any,\FontName$,\FontSize,\FontStyle)
        
        \w = 32
        \h = 32
        \name$ = "Text"+Str(LayerIdMax)
        \Text$ = txt$
        \x = x
        \y = y
        
      Default 
        \h = Doc\h
        \w = Doc\w
        \name$ = "Layer"+Str(LayerIdMax)
        
    EndSelect
    
    \NewW = \w
    \NewH = \h
    \CenterX = \w/2
    \CenterY = \h/2
   
      
    If \typ = #Layer_TypBG
      \Image = CreateImage(#PB_Any,\W_Repeat,\H_Repeat,32,#PB_Image_Transparent)
      Debug ImageWidth(\image)
    Else
      \Image = CreateImage(#PB_Any,\w,\h,32,#PB_Image_Transparent)
    EndIf
    \ImageBM = CreateImage(#PB_Any,\w,\h,32,#PB_Image_Transparent)
    \ImageAlpha = CreateImage(#PB_Any,\w,\h,32,#PB_Image_Transparent)
    If StartDrawing(ImageOutput(\ImageAlpha))
      ;Box(0,0,\w,\h,RGBA(255,255,255,0))    
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      ; Circle(\w/2,\h/2,50,RGBA(0,0,0,255))
      Box(0,0,\w,\h,RGBA(0,0,0,0)) ; on efface tout
      ;Box(0,0,\w,\h,RGBA(255,255,255,255)) ; et on révèle tout
      Box(0,0,\w,\h,RGBA(0,0,0,255)) ; et on révèle tout
      
      StopDrawing()
    EndIf
    
    If StartDrawing(ImageOutput(\Image))
      Box(0,0,\w,\h,RGBA(255,255,255,255))    
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      Box(0,0,\w,\h,RGBA(0,0,0,0))
      StopDrawing()
    EndIf
    
    If \Typ = #Layer_TypText
      Layer_UpdateText(n,0,0,2)
    EndIf
    
    \sprite= CreateSprite(#PB_Any,\w,\h,#PB_Sprite_AlphaBlending)
    If StartDrawing(SpriteOutput(\Sprite))
      Box(0,0,\w,\h,RGBA(255,255,255,255))
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      Box(0,0,\w,\h,RGBA(0,0,0,0))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      Layer_DrawImg(LayerId,255)  
      StopDrawing()
    EndIf
    
    ; Debug "sprite size : "+Str(SpriteWidth(\sprite))+"/"+Str(SpriteHeight(\Sprite))
    ; Debug "Image size : "+Str(ImageWidth(\Image))+"/"+Str(ImageHeight(\Image))
    

    
  EndWith  
  
  ; SortStructuredArray(layer(), #PB_Sort_Ascending, OffsetOf(sLayer\ordre),  TypeOf(sLayer\ordre))
  
  ; SetGadgetState(#G_LayerList,LayerId)
  UpdateGadgetLayer(LayerId) ; set the parameters of the new layer( bm, opacity...)
  IE_UpdateLayerUi() 
  
  ; on ajoute 1 au nombre total de layers
  LayerNb + 1
  
  ; idem pour layer IDmax, c'est un nombre qu'on garde, pour avoir des id unique pour les calques.
  LayerIdMax + 1
  
EndProcedure
Procedure Layer_Delete()
  
  ; DeleteArrayElement(layer(), layerid)
  FreeGadget2(layer(LayerId)\IG_LayerMenu)
  FreeImage2(layer(LayerId)\Image)
  FreeImage2(layer(LayerId)\ImageBM)
  FreeImage2(layer(LayerId)\ImageAlpha)
  FreeImage2(layer(LayerId)\ImageTemp)
  FreeSprite2(layer(LayerId)\Sprite)
  
  If layerid <ArraySize(layer())
    
    For a=layerId To ArraySize(layer())-1
      Layer(a) = layer(a+1)
      Layer(a)\ordre -1
    Next
    
  EndIf
  
  ReDim layer(ArraySize(layer())-1)
  ; on update le gadget liste layer
  LayerNb - 1
  LayerId -1
  Layer_UpdateList()
  CheckIfInf(LayerId,0)
  ScreenUpdate(1)
  
EndProcedure



;update
Procedure Layer_UpdateUi(i)
  
  n =ArraySize(layer())
  
  With layer(i)
    
    nom${12} = \Name$
    s = 19
    temp = CopyImage(\Image,#PB_Any)
    ResizeImage(temp, s, s)
    
    checker = CopyImage(#Img_Checker,#PB_Any)
    ResizeImage(checker, s, s) 
    
    ; d'abord, on update l'image du gadget-layer
    If StartDrawing(ImageOutput(\ImgLayer))
      DrawingMode(#PB_2DDrawing_Default)
      If i = layerId
        
        DrawImage(ImageID(#Img_LayerCenterSel),0,0)
      Else
        DrawImage(ImageID(#Img_LayerCenter),0,0)
      EndIf
      
      If \MaskAlpha =2 ; on dessine sur l'apha du calque
        d=1
      EndIf
      
      DrawingMode(#PB_2DDrawing_Outlined)
      Box(22+d*20,2,s+2,s+2,RGBA(0, 0, 0, 255))
      
      DrawingMode(#PB_2DDrawing_Default)
      Box(23+d*20,3, s, s,RGBA(80,80,80, 255))
      
      DrawingMode(#PB_2DDrawing_AlphaBlend) 
      If \View =1
        DrawAlphaImage(ImageID(#ico_LayerEye),5,8)
      EndIf 
      
      
        
      DrawImage(ImageID(checker), 23,3)
      DrawAlphaImage(ImageID(temp), 23,3)
      
      If \MaskAlpha >=1
        FreeImage2(temp)
        temp = CopyImage(\ImageAlpha,#PB_Any)
        ResizeImage(temp,s,s)
        StopDrawing()
        If StartDrawing(ImageOutput(temp))
          DrawingMode(#PB_2DDrawing_AlphaClip)
          Box(0,0,s,s,RGBA(255,255,255,255))
          If \MaskAlpha =3
            DrawingMode(#PB_2DDrawing_AlphaBlend)
            Line(0,0,s,s,RGBA(255,0,0,255))
            Line(0,s,0,0,RGBA(255,0,0,255))
          EndIf
          StopDrawing()
        EndIf
        If StartDrawing(ImageOutput(\ImgLayer))
        EndIf        
        DrawAlphaImage(ImageID(temp), 44,3) 
        d=1
      EndIf
      
      DrawingMode(#PB_2DDrawing_Transparent)  
      DrawText(44+d*22,4,nom$) 
      
      DrawingMode(#PB_2DDrawing_AlphaBlend)  
      If \Locked =1
        DrawAlphaImage(ImageID(#ico_LayerLocked),104,4)
      EndIf 
      
      StopDrawing()           
    EndIf
    
    FreeImage2(temp)
    FreeImage2(checker)
    
    ; creation ou update du gadget pour le layer 
    If IsGadget(\IG_LayerMenu)  And \IG_LayerMenu > #G_LastGadget
      
      If StartDrawing(CanvasOutput(\IG_LayerMenu))
        DrawImage(ImageID(\ImgLayer), 0, 0)
        StopDrawing()
      EndIf
      ResizeGadget(\IG_LayerMenu, #PB_Ignore, 1 + 26*(n-\Ordre), #PB_Ignore, #PB_Ignore)
      
    Else
      
      \IG_LayerMenu = CanvasGadget(#PB_Any, 0 , 1 + 26*(n-\Ordre), 220, 25)
      If StartDrawing(CanvasOutput(\IG_LayerMenu))
        DrawImage(ImageID(\ImgLayer), 0, 0)
        StopDrawing()
      EndIf
    EndIf
    
    
  EndWith
    
EndProcedure
Procedure Layer_UpdateImg()
  
  If layer(layerid)\Haschanged = 1
    layer(layerid)\Haschanged = 2
    CopySprite(Layer(layerid)\sprite,#Sp_CopyForsave,#PB_Sprite_AlphaBlending)
    file$ = "saveForImg_"+Str(layerId)+".png"
    SaveSprite(#Sp_CopyForsave,file$,#PB_ImagePlugin_PNG)
    FreeSprite2(#Sp_CopyForsave)
    FreeImage2(Layer(LayerId)\Image)
    Layer(LayerId)\Image = LoadImage(#PB_Any,file$) 
  EndIf
  
EndProcedure
Procedure Layer_Update(i)
  
  If StartDrawing(SpriteOutput(layer(i)\Sprite))
    DrawingMode(#PB_2DDrawing_AlphaChannel)
    Box(0,0,layer(i)\w,layer(i)\h,RGBA(0,0,0,0))
    
    ; display the alpha mask    
    If layer(i)\MaskAlpha =1
      DrawingMode(#PB_2DDrawing_AlphaChannel)
      DrawAlphaImage(ImageID(Layer(i)\ImageAlpha),0,0)    
      
      DrawingMode(#PB_2DDrawing_CustomFilter)
      CustomFilterCallback(@Filtre_MaskAlpha())
    Else
      DrawingMode(#PB_2DDrawing_AlphaBlend)
    EndIf
    ;DrawAlphaImage(ImageID(Layer(i)\image),0,0)
    Layer_DrawImg(i,255)
    StopDrawing()
  EndIf
  
EndProcedure
Procedure Layer_Bm2(i) ; pour calculer le bm sur les images // calcul the bm on images
  
  ; puis on fixe le bm // set the bm
  Select layer(i)\bm 
      
    ; Case #Bm_Normal
      ; DrawingMode(#PB_2DDrawing_AlphaBlend)
      
    Case #Bm_Normal ; normal            
      DrawingMode(#PB_2DDrawing_AlphaBlend | #PB_2DDrawing_Transparent)
      
    Case #Bm_Add                        
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)                 
      CustomFilterCallback(@bm_add()) 
      
    Case #Bm_Multiply              
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_multiply())
      
    Case #Bm_overlay               
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_overlay())
      
    Case #Bm_screen             
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_screen()) 
      
    Case #Bm_Inverse                
      DrawingMode(#PB_2DDrawing_XOr|#PB_2DDrawing_AlphaBlend)
      
    Case #Bm_ColorBurn
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_ColorBurn()) 
      
    Case #Bm_Dissolve               
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_Dissolve()) 
      
    Case #bm_Difference
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_difference()) 
      
    Case #Bm_Darken
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_darken())  
      
    Case #Bm_Lighten
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_lighten())    
      
    Case #Bm_Exclusion
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_Exclusion())   
      
    Case #Bm_Clearlight
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_clearlight())  
      
    Case #Bm_Hardlight
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_hardlight())  
      
    Case #Bm_Colorlight
      DrawingMode(#PB_2DDrawing_CustomFilter | #PB_2DDrawing_Transparent)     
      CustomFilterCallback(@bm_ColorLight()) 
      
      
  EndSelect
 
EndProcedure
Procedure Layer_Bm(i) ; pour le bm sur les sprite (l'affichage) // bm on sprite (preview)
      
  Select layer(i)\bm 
      
    Case #Bm_Normal
      SpriteBlendingMode(#PB_Sprite_BlendSourceAlpha, #PB_Sprite_BlendInvertSourceAlpha)
      
    Case #Bm_Add
      ; SpriteBlendingMode(#PB_Sprite_BlendOne,#PB_Sprite_BlendInvertSourceAlpha) 
      SpriteBlendingMode(#PB_Sprite_BlendOne,#PB_Sprite_BlendOne) 
      
    Case #Bm_Screen
      SpriteBlendingMode(#PB_Sprite_BlendOne,#PB_Sprite_BlendInvertSourceColor) 
      
    Case #Bm_Darken
      SpriteBlendingMode(5,7)  
      
    Case #Bm_Multiply
      ; SpriteBlendingMode(5,4)  
      SpriteBlendingMode(0,2)  
      ;//multiply
      ; draw_set_blend_mode_ext(bm_dest_color, bm_inv_src_alpha); 
      ;//draw_set_blend_mode_ext(bm_dest_alpha,bm_zero); 
      ;//draw_set_blend_mode(bm_dest_color);             
      
    Case #Bm_Lighten
      ; SpriteBlendingMode(#PB_Sprite_BlendDestinationColor,#PB_Sprite_BlendOne)  
      SpriteBlendingMode(4,8)  
      ;//Light      
      ;draw_set_blend_mode_ext(bm_dest_color, bm_one); 
      ;//draw_set_blend_mode_ext(bm_src_color,bm_src_color); 
      ;//draw_set_blend_mode_ext(bm_zero, bm_zero) 
      ;//draw_set_blend_mode(bm_dest_color);             
      
    Case #Bm_Clearlight
      SpriteBlendingMode(2,4)        
      
    Case  #Bm_ColorBurn
      ; SpriteBlendingMode(10,6)  
      SpriteBlendingMode(4,0)  
      ; color burn//sqr - (color burn)  puissance
      ;//draw_set_blend_mode_ext(bm_src_color, bm_zero);  
      ;//draw_set_blend_mode_ext(bm_one, bm_dest_color);      //bien si fond = gris 60 
      ;draw_set_blend_mode_ext(10,6);     
      
    Case  #Bm_Overlay
      ;SpriteBlendingMode(4,4)  
      SpriteBlendingMode(2,4)  
      
    ;Case  #Bm_Overlay2
      ;SpriteBlendingMode(2,4)  
      
    Case  #Bm_Inverse
      SpriteBlendingMode(5,0)  
      
    Case  #Bm_LinearBurn
      ; SpriteBlendingMode(4,1)  
      SpriteBlendingMode(4,6)  
      
    Case #Bm_Custom
      SpriteBlendingMode(Blend1,blend2)  
      
    Case  #Bm_LinearLight
      SpriteBlendingMode(4,2)  
      ;// light burn    
      ;//draw_set_blend_mode_ext(bm_dest_color, bm_zero);
      ;draw_set_blend_mode_ext(4,2); 
      
      
  EndSelect
  
EndProcedure



; draw
Procedure Layer_Draw(i)
  
  z.d = OptionsIE\zoom * 0.01
  w.d = Layer(i)\w * z
  ;w= w/100
  h.d = Layer(i)\h * z
  ;h = h/100 
  Layer_Bm(i)
  ZoomSprite(Layer(i)\Sprite,w,h)
  DisplayTransparentSprite(Layer(i)\Sprite,canvasX+layer(i)\x * z,canvasY+layer(i)\y * z,layer(i)\alpha)
  SpriteBlendingMode(#PB_Sprite_BlendSourceAlpha, #PB_Sprite_BlendInvertSourceAlpha)

EndProcedure
Procedure Layer_DrawBorder(i)
  
  If layer(i)\selected Or OptionsIE\Selection = 1
    
    z.d = OptionsIE\zoom * 0.01
    If StartDrawing(ScreenOutput())
      DrawingMode(#PB_2DDrawing_Outlined)
      ; bordure du calque
      If layer(layerId)\selected
        Box(canvasX+Layer(layerId)\x*z,canvasY+layer(layerID)\y*z,layer(layerId)\w*Z,layer(layerId)\h*z,RGB(255,0,0))
      EndIf
      
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_XOr)
      ; la sélection
      If OptionsIE\Selection = 1
         Box(canvasX+OptionsIE\SelectionX*z,canvasY+OptionsIE\Selectiony*z,OptionsIE\SelectionW*Z,OptionsIE\SelectionH*z,RGB(0,0,0))
      EndIf

      StopDrawing()
    EndIf
    
  EndIf
  
EndProcedure
Procedure Layer_DrawAll()
  
  For i=0 To ArraySize(layer())
    If Layer(i)\view 
      Layer_Draw(i)
      If i = layerId
        If OptionsIE\Shape=1 
          DisplayTransparentSprite(#Sp_LayerTempo,canvasX,canvasY,layer(layerid)\alpha)  
        EndIf
      EndIf  
    EndIf
  Next i
  
EndProcedure



; free, clear
Procedure Layer_FreeAll()
  ; procedure qu'on utilise pour supprimer tous les layers.
  ; Par exemple, lorsqu'on crée un nouveau document
  
  For i = 0 To ArraySize(layer())
    
    FreeImage2(Layer(i)\Image)
    FreeImage2(Layer(i)\ImageBM)
    FreeImage2(Layer(i)\ImageTemp)
    FreeImage2(Layer(i)\ImgLayer)
    FreeGadget(Layer(i)\IG_LayerMenu)
    FreeSprite2(Layer(i)\Sprite)
    
  Next i
  
  ReDim Layer(0)
  LayerNb = 0
  LayerIdMax = 0

EndProcedure
Procedure Layer_Clear(i, onlyAlpha=0)
  
  If layer(layerid)\MaskAlpha = 2
    img = layer(i)\ImageAlpha
  Else
    img = layer(i)\image
  EndIf
  
  If  StartDrawing(ImageOutput(img))
    ;If onlyAlpha = 1
      Box(0,0,LAyer(i)\W+20,LAyer(i)\h+20,RGBA(255,255,255,255))
    ;EndIf    
    DrawingMode(#PB_2DDrawing_AlphaChannel)
    If OptionsIE\Selection
      x = OptionsIE\SelectionX
      y = OptionsIE\SelectionY
      w = OptionsIE\SelectionW
      h = OptionsIE\SelectionH
      Box(x,y,w,h,RGBA(0,0,0,0))
    Else
      Box(0,0,LAyer(i)\w+20,LAyer(i)\h+20,RGBA(0,0,0,0))
    EndIf    
    StopDrawing()
  EndIf
  
  If  StartDrawing(SpriteOutput(layer(i)\Sprite))
    If onlyAlpha = 1
      Box(0,0,Layer(i)\w+20,Layer(i)\h+20,RGBA(255,255,255,255))
    EndIf    
    DrawingMode(#PB_2DDrawing_AlphaChannel)
    Box(0,0,Layer(i)\w+20,Layer(i)\h+20,RGBA(0,0,0,0))
    StopDrawing()
  EndIf 
  
  NewPainting = 1
  ScreenUpdate(1) 
                         
EndProcedure



; change position (order in the layer list)
Procedure Layer_ChangePos(dir=1)
  
  ; dir = 1 : on monte d'une position
  ; dir = -1, on descnd d'une position
  
  ; on verifie qu'on peut bien bouger le layer courrant
  
  ; Debug Str(Layerid)+ " - "+Str(Layer(LayerId)\ordre) + "/"+Str(ArraySize(layer()))
  
  If (dir=1 And Layer(LayerId)\ordre<ArraySize(layer()))  Or (dir=-1 And Layer(LayerId)\ordre>0)
    
    i = layerid
    j = layerid+dir
    layer(LayerId)\ordre + dir
    NewOrdre = layer(LayerId)\ordre
    layer(LayerId+dir)\ordre - dir
    
    ; Trie le tableau en fonction du champ 'ordre' qui est un long  ;
    If dir=1
      SortStructuredArray(layer(), #PB_Sort_Ascending, OffsetOf(slayer\ordre),  TypeOf(slayer\ordre),i,j)
    Else
      SortStructuredArray(layer(), #PB_Sort_Ascending, OffsetOf(slayer\ordre),  TypeOf(slayer\ordre),j,i)
    EndIf
    
    
    For i = 0 To ArraySize(layer())
      If layer(i)\ordre = NewOrdre
        LayerId = i
        Break
      EndIf
    Next i
    
    Layer_UpdateList(1)
    ScreenUpdate()
    
    IE_UpdateLayerUi() 
    ; SetGadgetState(#G_LayerList,LayerId)
    
  EndIf

EndProcedure



; operation on layers 
Procedure Layer_Merge(mode=0)
  
  NewPainting = 1

  If mode = 0 ; Only Two layers (from top to bottom) :: seulement 2 layer vers le bas
    
    ; convert the layer bm if needed
    Layer_convertToBm(LayerId-1)
    Layer_convertToBm(LayerId)
    
    Tmp = CreateImage(#PB_Any,doc\w,doc\h,32,#PB_Image_Transparent)
    If StartDrawing(ImageOutput(tmp))
      ;DrawingMode(#PB_2DDrawing_AlphaBlend)
      
      Layer_Bm2(LayerId-1)
      DrawAlphaImage(ImageID(layer(LayerId-1)\ImageTemp),0,0,layer(layerId-1)\alpha) 
      
      Layer_Bm2(LayerId)
      DrawAlphaImage(ImageID(layer(LayerId)\ImageTemp),0,0,layer(layerId)\alpha) 
      
      StopDrawing()
    EndIf
    
    FreeImage2(layer(LayerId-1)\Image)
    Layer(LayerId-1)\Image = CopyImage(tmp,#PB_Any)
    FreeImage2(tmp)
    Layer_Delete()
    
  ElseIf mode = 1 ; merge all
    
    ; CHange the image with blendmode // d'abord, on doit modifier l'image en fonction du blendmode
    For i = 0 To ArraySize(layer())
      With layer(i)
        If \view
          Layer_convertToBm(i)
        EndIf
      EndWith
    Next i
    
    ; ensuite on crée une image temporaire sur laquelle on va dessiner tous les calques
    Tmp = CreateImage(#PB_Any,doc\w,doc\h,32,#PB_Image_Transparent)
    If StartDrawing(ImageOutput(tmp))
      DrawingMode(#PB_2DDrawing_AlphaBlend)  
      For i = 0 To ArraySize(layer())
        With layer(i)
          If \view
            Layer_Bm2(i)
            DrawAlphaImage(ImageID(\ImageTemp),0,0,\alpha) 
          EndIf
        EndWith
      Next i
      StopDrawing()
    EndIf
    
    ; puis on libère la mémoire, on supprime ce qui ne sert plus.
    Layer_FreeAll() 
    Layer_Add()
    FreeImage2(Layer(layerId)\Image)
    Layer(LayerId)\Image = CopyImage(tmp,#PB_Any)
    FreeImage2(tmp)
    
  ElseIf mode = 2 ; merge visible
    
    
  ElseIf mode = 3 ; merge linked
    
    
  EndIf
  
EndProcedure
Procedure Layer_Fill(mode=0)
  
  
  If layer(layerid)\MaskAlpha >= 2
    img = layer(i)\ImageAlpha
  Else
    img = layer(i)\image
  EndIf
  
  If layer(layerid)\MaskAlpha = 3
    MessageRequester(Lang("Info"),Lang("The layer mask is hiden"))
    ProcedureReturn 0
  EndIf
  
  If mode = 0 ; on remplit avec une couleur
    
    tmp = CopyImage(Img, #PB_Any)
        
    If StartDrawing(ImageOutput(tmp))
      DrawingMode(#PB_2DDrawing_AllChannels)
      Box(0,0,doc\w,doc\h, RGBA(Red(Brush(Action)\ColorBG\R),Brush(Action)\ColorBG\G,Brush(Action)\ColorBG\B,255))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      DrawAlphaImage(ImageID(Img),0,0)      
      StopDrawing()
    EndIf
    FreeImage2(Img)
    If layer(layerid)\MaskAlpha = 2
      layer(i)\ImageAlpha= CopyImage(tmp,#PB_Any)
    Else
      layer(i)\image= CopyImage(tmp,#PB_Any)
    EndIf
    Newpainting = 1
    ScreenUpdate()
    FreeImage2(tmp)
    
  ElseIf mode = 1 ; on efface le calque avec le couleur de fond
        
    If StartDrawing(ImageOutput(img))
      DrawingMode(#PB_2DDrawing_AllChannels)
      Box(0,0,doc\w,doc\h, RGBA(Red(Brush(Action)\ColorBG\R),Brush(Action)\ColorBG\G,Brush(Action)\ColorBG\B,255))
      StopDrawing()
    EndIf
    Newpainting = 1
    ScreenUpdate()
    
  ElseIf mode = 2 ; on remplit (en effaçant) avec un pattern
    
    File$ = OpenFileRequester("Open An image","","Image|*.jpg;*.png;*.bmp",0)
    If file$ <>"" 
      
      tmp = LoadImage(#PB_Any, file$)
      If tmp <> 0
        
        w = ImageWidth(tmp)
        h = ImageHeight(tmp)
        
       ; tmp = CopyImage(layer(layerId)\Image, #PB_Any)
        If StartDrawing(ImageOutput(img))
          DrawingMode(#PB_2DDrawing_AllChannels)
          Box(0,0,doc\w,doc\h, RGBA(0,0,0,0))
          For i = 0 To doc\w/w
            For j = 0 To doc\h/h
              DrawAlphaImage(ImageID(tmp),i*w,j*h)
            Next j
          Next i
          
          StopDrawing()
        EndIf
        
        FreeImage2(tmp)
        Newpainting = 1
        ScreenUpdate(1)        
      EndIf
      
    EndIf
    
    
    
    
    
  EndIf
  
  
EndProcedure
Procedure Layer_ValidChange(Action,i=-1)
  
  If i=-1
    i=layerid
  EndIf
  
  
  If Action = #Action_Move Or Action = #Action_Transform Or Action = #Action_Rotate
    
    If OptionsIE\confirmAction = 1
      resultat=MessageRequester("Confirm?","Do you want to apply the transformation ?",#PB_MessageRequester_YesNo)
    EndIf
  
    If resultat =  #PB_MessageRequester_Yes  Or OptionsIE\ConfirmAction = 0
      
      Select layer(i)\Typ 
          
          Case #Layer_TypBitmap
            
            tmp = CopyImage(layer(i)\Image,#PB_Any)
            rotimg = tmp
            
            ; on dessine sur la nouvelle image
            If StartDrawing(ImageOutput(tmp))                
              DrawingMode(#PB_2DDrawing_AllChannels)
              Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
              DrawingMode(#PB_2DDrawing_AlphaBlend)
              DrawAlphaImage(ImageID(layer(i)\Image),layer(i)\x,layer(i)\y)
              StopDrawing()
            EndIf
            
            If Action = #Action_Transform          
              
              ResizeImage(tmp,Layer(i)\w,Layer(i)\h)  
              Layer(i)\w = doc\w
              Layer(i)\h = doc\h
              Layer(i)\NewW = doc\w
              Layer(i)\NewH = doc\h
              
            ElseIf action = #action_rotate
              
              rotimg = RotateImageEx2(ImageID(tmp),layer(i)\Angle)
              FreeImage2(tmp)
              
              w = ImageWidth(rotimg)
              h = ImageHeight(rotimg)
              
              w1 = ImageWidth(layer(i)\Image)
              h1 = ImageHeight(layer(i)\Image)
              
              xn = -(w-w1)/2
              yn = -(h-h1)/2
              
              
            EndIf
            
            If StartDrawing(ImageOutput(layer(i)\Image))
              DrawingMode(#PB_2DDrawing_AllChannels)
              Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
              DrawingMode(#PB_2DDrawing_AlphaBlend)         
              DrawAlphaImage(ImageID(Rotimg),xn,yn)
              StopDrawing()
            EndIf
            
            FreeImage2(rotimg)
            
          Case #Layer_TypText
            Layer_UpdateText(i,Layer(i)\w,Layer(i)\h,1)
            ; Layer_Update(i) 
            
            
        EndSelect
    
    EndIf
    
    Select layer(i)\Typ 
        
      Case #Layer_TypBitmap
        Layer(i)\selected = 0
        Layer(i)\x = 0
        Layer(i)\y = 0       
        Layer(i)\w = doc\w
        Layer(i)\h = doc\h
        Layer(i)\NewW = doc\w
        Layer(i)\NewH = doc\h
        Layer(i)\Angle = 0        
        RotateSprite(layer(i)\Sprite,0,0)
        
      Case #Layer_TypText
        RotateSprite(layer(i)\Sprite,0,0)
        Layer(i)\selected = 0
        Layer(i)\Angle = 0
        
    EndSelect

    
    NewPainting = 1
    ScreenUpdate(1)  
    
  EndIf
  
  
EndProcedure
; layer_move : see UpdateTool(), in gadgets, UI, updates... (gadgets.pbi)
Procedure Layer_Rotate(i,angle)
  
  tmp = CopyImage(layer(i)\Image,#PB_Any)
  
;   ; on dessine sur la nouvelle image
;   If StartDrawing(ImageOutput(tmp))                
;     DrawingMode(#PB_2DDrawing_AllChannels)
;     Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
;     DrawingMode(#PB_2DDrawing_AlphaBlend)
;     DrawAlphaImage(ImageID(layer(i)\Image),0,0)
;     StopDrawing()
;   EndIf
  
    
  rotimg = RotateImageEx2(ImageID(tmp),angle)
  FreeImage2(tmp)
  
  w = ImageWidth(rotimg)
  h = ImageHeight(rotimg)
  
  w1 = ImageWidth(layer(i)\Image)
  h1 = ImageHeight(layer(i)\Image)
  
  xn = -(w-w1)/2
  yn = -(h-h1)/2

  If StartDrawing(ImageOutput(layer(i)\Image))
    DrawingMode(#PB_2DDrawing_AllChannels)
    Box(0,0,doc\w,doc\h,RGBA(0,0,0,0))
    DrawingMode(#PB_2DDrawing_AlphaBlend)         
    DrawAlphaImage(ImageID(Rotimg),xn,yn)
    StopDrawing()
  EndIf
  
  FreeImage2(rotimg)
  
  
EndProcedure



; temporary layer
Procedure Layer_DrawTempo()
    
  If OptionsIE\Shape >=1
    If action >= #Action_Line And Action <= #Action_Gradient
      
      x = OptionsIE\ShapeX-canvasX
      y = OptionsIE\ShapeY-canvasY
      w = OptionsIE\shapeW
      h = OptionsIE\shapeH
      col = RGBA(Brush(Action)\ColorBG\R,Brush(Action)\ColorBG\G,Brush(Action)\ColorBG\B,Brush(Action)\alpha)
      
      If OptionsIE\ShapeTyp >=1 And action >= #Action_Line
        OptionsIE\Shape = 2
        If StartDrawing(SpriteOutput(layer(LayerId)\Sprite))
          DrawShape(0)
          StopDrawing()
        EndIf
        If StartDrawing(ImageOutput(layer(LayerId)\Image))
          DrawShape(0)
          StopDrawing()
        EndIf
      Else
        If StartDrawing(SpriteOutput(#sp_LayerTempo))
          DrawShape()
          StopDrawing()
        EndIf
      EndIf
      
    EndIf
  EndIf
  
EndProcedure


; alpha selection
Procedure Layer_SelectAlpha()
    
  ;CreateImage2(#Img_AlphaSel,doc\w,doc\h,"Alpha selection",32,#PB_Image_Transparent)
  CopyImage(layer(layerid)\Image, #Img_AlphaSel)
  If StartDrawing(ImageOutput(#Img_AlphaSel))
    DrawingMode(#PB_2DDrawing_AlphaClip)
    Box(0,0,doc\w,doc\h,RGBA(255,255,255,255))
    StopDrawing()
  EndIf
  OptionsIE\SelectAlpha = 1
  
EndProcedure

; windows
; windowprop sur window.pbi
; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 922
; FirstLine = 63
; Folding = AgpAAAAAAUGHA9DAAAe5
; EnableXP
; EnableUnicode