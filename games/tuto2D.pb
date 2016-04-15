
;{ Infos

; ici, on peut indiquer les informations pour le jeu : 
; la date de création, le nom, les développeurs, la version de purebasicles changements, la todolists, les bugs rencontrés à corriger, 

; PB version : 5.42
; Dev : blendman
; date : mai 2012 - revision 14/04/2016

;**** CHANGES
; personnellement, pour tous mes codes, j'utilise la technique suivante pour indiquer les changements :
; [Date] (version) (nombre de jours travaillé sur le programme)

; [14 avril 2016] (0.03) (3)
; - mise en forme pour purebasic 5.42

; [2 octobre 2015] (0.02) (2)
; - modification du code pour purebasic 5.31 et +
; - ajout de tests pour certaines procédures, pour éviter les plantages.
; - ajout d'informations
;}


;{ les constantes
; elles commencent toutes par # et sont invariables
#window = 0; pour la fenêtre
#loadsprite = 0; juste pour savoir si on charge les images ou non (dans la partie "ouverture de la fenêtre")

Enumeration ; les numéros pour les sprites
            ; les enumeration permettent d'énumérer facilement plusieurs constantes qui se suivent et se définissent d'elles-mêmes
            ; l'inconvénient de l'énumération pour les sprites est que c'est statique : on définit à l'avance le nombre de sprites pnj ou de monstres. 
            ; pour pouvoir avoir un nombre dynamique (si on ne sait pas exactement combien on a de sprites ou si on ne veut pas changer dès qu'on ajoute un sprite)
            ; il faudrait utiliser la création de numéro d'image de manière dynamique, avec par exemple un tableau
            ; Pnj[0].sprite = Loadsprite(#pb_any, filename$)
            ; CEpendant, l'idéal avec pb, est de charger un sprite et si on en a besoin d'en faire une copie ensuite. (ça revient à charger une image et à l'utiliser).
            ; dans cet exemple, on va garder la création statique des numéros d'image avec l'énumération
    #perso1 ; vaut "0"
    #pnj1   ; vaut 1
    #pnj2   ; vaut 2
    #mob1   ; vaut 3
    #mob2   ; vaut 4, etc....
EndEnumeration

;}

;{ structures
;{ carte
Structure stCarte ; pour créer une carte (map)
    width.w : height.w
    nom.s : numero.a
EndStructure
Global carte.stCarte
; j'utilise des globales pour pouvoir passer chaque élément (carte, camera, player, pnj), sans soucis dans les procédures.
; on pourrait utiliser des pointeurs pour ça (*carte.stcarte), mais ce n'est pas pour débutant, donc on utilisera les globales ici.

With carte ; j'initialise la carte
    \nom = "Les Plaines Dherb"
    \numero = 1; par ex, c'est la carte N°1
    \width = 4000  ; 4000 pixels de large
    \height = 3000 ; 3000 pixels de haut
EndWith
;}
;{ pnj, ennemi
Structure stPnj ; pour les ennemis/pnj..
                ; on met les champs que l'on veut ici, si on utilise  ":", on gagne des lignes ;)
    Sprite.w    ; le numéro du sprite
    x.w : y.w   ; position. Dans certains cas, on doit utiliser un float (.f) ou un double (.d) (nombre à virgule), pour plus de précision.
    nom.s
EndStructure
; on créé un tableau global pour 40 pnjs/ennemis
Global Dim pnj.stpnj(39) ; de 0 à 39, ça fait 40, on créé un tableau avec 40 pnjs

; on initialise nos pnj/ennemi
For i = 0 To ArraySize(pnj())
    With pnj(i)
        \nom = "pnj"+Str(i); str() sert à transformer une variable en texte
        \sprite = #pnj1 + Random(1) ; random() sert à sortir un nombre au hasard (nombre défini en paramètre)
        \x = Random(carte\width)-32 ; position x au hasard en fonction de la largeur de la carte - la taille du sprite
        \y = Random(carte\height)-32; position y au hasard en fonction de la hauteur de la carte - la taille du sprite
    EndWith 
Next i
;}
;{ player
Structure StPlayer Extends stPnj ; une structure pour le joueur
                                 ; on ne peut pas utiliser le define dans une structure
                                 ; extends, permet de créer une structure qui utilise les champs d'une autre structure (c'est une sorte de copier-coller des champs)
                                 ; on hérite des champs de stpnj, c'est à dire : nom, sprite, x, y et race
    classe.s                     ; la classe du personnage
    vitesse.a                    ; vitesse de déplacement du personnage. Si on utilise des floats ou double pour la position, il faudrait mettre ici aussi un .f ou .d
    race.s
EndStructure
Global player.StPlayer

With player ; j'initialise le joueur
    \classe = "elfe"
    \nom ="Roberto"
    \race = "elfe bleu turquoise"
    \sprite = #perso1
    \vitesse = 3
    \x = 50+Random(50)
    \y = 50+Random(50)
EndWith
;}
;{ camera
Structure Stcamera ; pour créer une caméra virtuelle
    x.w : y.w
EndStructure
Global camera.Stcamera
;}
;}

;{ declaration des procedures (ce sont des fonctions qu'on peut utiliser))
; on declare 1 procedure, car on l'a écrite en bas du code.
; pour éviter certains déclarations, on pourrait mettre les procédures ici.
Declare AddSprite(sprite,size,color)
;}

;{ macros : ce sont un peu comme des procedures, sauf que le code est copié à chaque fois
Macro BorneValeurMini(x,val)
    If x < val : x = val : EndIf ; pour vérifier si on n'est pas <0
EndMacro
Macro BorneValeurMaxi(x,val)
    If x > val : x = val : EndIf ; pour empêcher d'être supérieur à une valeur, par exemple pour ne pas dépasser la taille de la map
EndMacro
;}

;{ initialisation : on initialise les libs utilisées (directX sous windows, OpenGL sous linux, les sprites, sprite3D et clavier)
; il faut toujours tester toutes les fonctions, pour éviter les plantages..
; je  mets un message d'erreurs si j'amais ça ne s'initialise pas, pour qu'on sache où est le soucis. 
If InitSprite() = 0
    MessageRequester("Info", "Erreur de chargement de directX (ou openGL)")
    End ; on ferme l'application
EndIf
If InitKeyboard()= 0
    MessageRequester("Info", "Erreur de chargement du clavier") 
    End
EndIf
;}

;{ ouverture de la fenêtre
If OpenWindow(#window,0,0,800,600,"Base Jeu Scrolling",#PB_Window_ScreenCentered|#PB_Window_MaximizeGadget) = 0
    MessageRequester("Info", "Erreur d'ouverture de la fenêtre")
    End ; on ferme l'application
EndIf
If OpenWindowedScreen(WindowID(#window),0,0,800,600,0,0,0,#PB_Screen_SmartSynchronization)= 0
    MessageRequester("Info", "Erreur d'ouverture de la fenêtre")
    End
EndIf
UseJPEGImageDecoder() : UsePNGImageDecoder() ; pour charger des jpg ou des png (avec canal alpha)
                                             ;{ charger tes images/sprite
If #loadsprite = 1
    ; si vous voulez charger des images , changer le chemin c:/images/ton_perso1.jpg , c:/images/ton_perso2.png et c:/images/ton_perso3.png
    
    LoadSprite(#perso1,"c:/images/ton_perso1.jpg", #PB_Sprite_AlphaBlending); si c'est un jpg, pas de canal alpha
    LoadSprite(#pnj1,"c:/images/ton_perso2.png", #PB_Sprite_AlphaBlending)  ; c'est un png, on peut avoir un canal alpha
    LoadSprite(#pnj2,"c:/images/ton_perso3.png", #PB_Sprite_AlphaBlending)  ; c'est un png, on peut avoir un canal alpha
                                                                            ;}
                                                                            ;{ créer un sprite (si besoin)
Else                                                                        ; on n'utilise pas d'image pour nos sprites, on peut les créer 
    AddSprite(#perso1,32,RGBA(125,0,0,254))                                      ; le joueur
    AddSprite(#pnj1,32,RGBA(0,125,0,254))                                        ; les pnjs
    AddSprite(#pnj2,32,RGBA(0,0,125,254))                                        ; les pnjs
EndIf
;}
;}

;{ boucle repeat

Repeat
    
    Repeat 
        event = WindowEvent() ; on attend un évènement dans la fenêtre et on stocke celui dans la variable event
                              ; que je n'ai pas déclarée d'ailleurs, et que je déclare ici même=
        Select event          ; on va vérifier quel évènement a lieu
            Case #PB_Event_CloseWindow; si on clique sur la croix
                quit = 1              ; on quitte
        EndSelect
        
    Until event = 0 Or quit = 1
    
    If ExamineKeyboard(); nécessaire pour voir si tu utilises le clavier
                        ;{ déplacement du joueur
        If KeyboardPushed(#PB_Key_Right) And player\x < carte\width
            player\x + player\vitesse
            camera\x = player\x - 800/2 ; la résolution du jeu/2 ; mise à jour de la camera
            BorneValeurMini(camera\x,0)
            BorneValeurMaxi(camera\x,carte\width- 800/2)
        EndIf
        If KeyboardPushed(#PB_Key_Left) And player\x >-16
            player\x - player\vitesse
            camera\x = player\x - 800/2 ; la résolution du jeu/2 ; mise à jour de la camera
            BorneValeurMini(camera\x,0)
            BorneValeurMaxi(camera\x,carte\width- 800/2)
        EndIf
        If KeyboardPushed(#PB_Key_Up) And player\y > -16
            player\y - player\vitesse
            camera\y = player\y - 600/2 ; mise à jour de la camera
            BorneValeurMini(camera\y,0)
            BorneValeurMaxi(camera\y,carte\height- 600/2)
        EndIf
        If KeyboardPushed(#PB_Key_Down)And player\y < carte\height
            player\y + player\vitesse
            camera\y = player\y - 600/2 ; mise à jour de la camera
            BorneValeurMini(camera\y,0)
            BorneValeurMaxi(camera\y,carte\height- 600/2)
        EndIf
    EndIf
    ;}
    
    ;{ affichage du jeu
    ClearScreen(RGB(125,125,125)); on efface l'écran avec du gris
    
    ; d'abord je dessine tous les pnj. j'aurai pu aussi utiliser une list(), ou une map(), mais pour ce 1er exemple, j'ai utilisé un tableau
    For i = 0 To ArraySize(pnj())
        DisplayTransparentSprite(pnj(i)\sprite,pnj(i)\x-camera\x,pnj(i)\y-camera\y)
    Next i 
    DisplayTransparentSprite(#perso1,player\x-camera\x,player\y-camera\y) 
    
    If StartDrawing(ScreenOutput())
        DrawingMode(#PB_2DDrawing_Transparent); on met le mode transparent pour le texte
        DrawText(player\x-camera\x,player\y-camera\y,Str(player\x)+"/"+Str(player\y))
        StopDrawing()
    EndIf
    
    FlipBuffers(); on "flippe" le buffer, utile pour les jeux vidéos, histoire de ne pas avoir de flickering, tearing (écran déchiré)
                 ;}
    
    
Until KeyboardPushed(#PB_Key_Escape) Or quit = 1

End ; pas obligé, mais ça indique qu'on a terminé

;}

;{ les procedures
; creation des sprites
Procedure AddSprite(sprite,size,color)
    
    If CreateSprite(sprite,size,size,#PB_Sprite_AlphaBlending) : EndIf; j'utilise #PB_Sprite_Texture, car on va en faire un sprite3D juste après
                                                                      ; on dessine sur le sprite créé (ici, juste un cercle)
    If StartDrawing(SpriteOutput(sprite))         ; on lui indique sur quoi on va dessiner
        
        DrawingMode(#PB_2DDrawing_AllChannels)
        Box(0,0,OutputWidth(),OutputHeight(),RGBA(0,0,0,0))
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        Circle(size/2,size/2,size/2,color)
        StopDrawing()
    EndIf
    
EndProcedure

;}

;{ si besoin, les data sections
DataSection
    image1:
    ; chemin de ton image
    ; pour l'utiliser, dans la section charger tes images :
    ; CatchSprite(sprite,?image1,#PB_Sprite_Texture|#PB_Sprite_Alpha)
EndDataSection
;}
; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 212
; FirstLine = 199
; Folding = ---------
; EnableUnicode
; EnableXP