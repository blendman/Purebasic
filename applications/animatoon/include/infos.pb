
; *** info

; Animatoon version Screen
; PB : 5.73 LTS
; blendman 2015 & 2021
; testé sous win8/Win10 avec wacom : ok
; LICENCE : GPLv3.
; use this code at your own RISK !

;{ pen/tablet input test for wacom tablets and compatible devices
; using WINTAB32.dll;
; by Danilo, 2008/06/12
; Modified by blendman : 2013 & 05/2015
; Wacom SDK: http://www.wacomeng.com/devsupport/ibmpc/downloads.html
;}

;{ ************************* CHANGES ********************************

; 1. priorité *********

; URGENT
; - brush fondu alpha et size

; BUGS
; - cadre selection bug avec zoom
; - gradient linear AR
; - bug UI à l'ouverture suivante, quand on déplace les splitters en Y (swatch par exemple)
; - bug outil zoom ? : à priori non, mais à revoir (inverser avec ou sans ctrl et moins rapide)



; BRUSH
; - trait fondu (vers alpha= 0 et size =1)
; - revoir le trait en fonction du pas (distance entre les points, donc calcul de la distance si >= pas, on affiche un point 
; et on affiche le 1er aussi)
; - ajouter vectordrawing line
; - ajouter bezier sur les strokes
; - ajouter brush éditor et ne laisser que quelques gadgets sur le panneau outils (taille, alpha, dureté..)

; TOOLS
; - bug degradé linéaire !!
; - degradé ne conserve pas les couleurs si on quitte.
; - ajouter tampon
; - ajouter sorte de tampon (niveau de gris) + couleur, pour peindre de l'aquarelle (texture) avec une couleur.

; PAPER
; - ajouter paper editor
; - AR !!!! paper scale : ok when change trackbar paperScale
; ok 0.586- ajouter un fond couleur (blanc pour le moment)

; IMAGEs
; - niveau ne fonctionne pas très bien, voir en temps réel et mettre plus d'info sur les trackbar (on ne sait pas ce que c'est)

; Layers
; - revoir bm : darken, linearlight, overlay (??)

; SCREEN/CANVAS
; - ajouter un canvas output pour l'affichage sur canvas au lieu du screen (au choix) pour le preview et export.

; Interface (gadget, menu..)
; - ajouter trackbar pour : brush size, alpha
; - ajouter scrollarea gadget pour : brush (gen, tra, dyn), option paper
; - donner le choix de l'interface (parametre sur onglet gen ou séparé (sur onglet tra et dyn))
; - ajouter Emulate Numpad (on utiliser alors les touches 1 à 0 en remplacement).
; - confirmexit (option, message)

; 11/03/2021 0.588
; // New
; wip - zoom centré sur souris
; - addlogError() to write in a log error file text, if we have an error (I have to use this procedure in all error, need to update all the code ^^).
; - add an autosave
; - addautosaveTime : (+OpenOptions()/SaveOptions())
; - autosave : verify If directory save exist, If Not -> created. Then verify If directory autosave exist, If Not -> created.
; - options : add PresetBrushDir (open, save)
; //fixes
; - gradient : bug si degrade puis bouge canvas (space))
; - Box : bug si box puis bouge canvas (space))
; - bug taille H de la surface de dessin (screen ou container)
; - option ne garde pas la bank de brush quand on ferme (preset).
; - options : chemin swatch doit etre relatif
; - options : chemin RoughBoard doit etre relatif
; - options : brush/eraser/pen : chemin doit être relatif.
; - layer-fusion to bottom-layer bug if bm <> normal
; - layer : preview pas update si clicbuttonUp
; - OpenDoc() : If zoom <= 0 : zoom = 100
; // WIP
; - very WIP !!!  add main loop for macOS too (I have forgotten ^^).


; 10/03/2021 0.587.5
; // New
; - menu : saveAs (+shortcut, lang), pour l'instant ça ne fait rien.
; // changes
; - Lang : now, by defaut, lang is defined by the string if word in *.ini ="". 
; Donc, il ne devrait plus y avoir de menu ou Interface vide par la suite en tout cas ^^). 
; - nombreuses modifications dans les gadgets (& fonctions de création de l'UI) pour prendre en compte le nouveau système de language.
; Fixes
;- help : bug avec la date de création du programme.


; 9/03/2021 0.587
; // New
; - add 10 new paper
; - paper : Ajout String gadget & name Alpha
; - paper : Ajout String gadget & name scale
; - paper : Ajout String gadget & name intensity
; - when change Trackbar paper (alpha, scale) : stringgadget updated, idem when change stringgadget (alpha, scale), trackbar updated.
; - AddSTringTBGadget(gad0,gad1,gad2,val,name$,tip,x,y,w1,w2,min,max)
; - ajout d'un fond coloré, sous le papier( pour garder une transparence avec couleur blanc.
; // drawing
; - Girl with a creature (WIP)
; //test
; - texture et image papier
; - brightness, contraste : optimisation


; 8/03/2021 0.586
; // Drawing-test
; - max, creature magique, teo
; // new
; - option : save & load path (open, save)
; - save et open : garder chemin de save/open
; // Changes
; - ajout de 3 nouvelles images de brush (pour un pinceau watercolor avec grain, ou des craies grasses)
; - ajout de preset de brush (blendman/favorite) : crayon, watercolor...
; - Quand on change un brush, ça update désormais le nbre d'images de brush
; - paramètres de dureté du brush sont désormais dans l'onglet transparence (car c'est plus lié à la transparence qu'a la taille)
; - paramètres "ligne" (ligne, pas, intensité brosse...) sont désormais dans l'onglet dynamics (car lié à la dynamique du trait (type de ligne, scatter, etc...)


; 7/03/2021 0.585
; // test
; - blendmode, zoom
; // News
; - trackbar : Paper alpha , scale, intensity
; - Paper alpha : ok when change trackbar paperAlpha
; - AR !!!! paper scale : ok when change trackbar paperScale


; 6/03/2021 
; test and colors of my painting "torwald"

; 5/03/2021 0.584
; // Changes
; - save brush preset : s'ouvre désormais dans preset/bank
; - ouvrir bank preset avec getcurrentdirectory()
; // Fixes
; - stringgadget bug
; - the main windows isn't maximised
; - en openGL le paper n'est pas visible
; - gadget swatchprop n'est pas initialisé, donc avec le debugger j'avais un bug, ajout if isgadget().


; 4/03/2021 0.583
; // Change
; - import image on layer : now create a new layer


; 3/03/2021 0.582
; // Change
; - when ctrl+X : ne garde pas le dessin coupé, on ne peut pas le coller avec ctrl+V


; 24/07/2015 0.581
; // New
; - Tool fillarea : add tolerance, transparency


; 22/07/2015 0.58
; New
; - Menu sélection


; 21/07/2015 0.576
; Changes
; - when clic on view layer, now, it doesn't select the layer, it jst hide the layer (not appear on the screen)
; Fixes
; - small fixes

; 19/07/2015 0.575
; New 
; - Layer : Select alpha
; - buton swatch new + langage on some gadgets, tooltips
; - swatch : delete, insert, sort
; - buton RB new
; - some changes in the UI presets(tooltips langage, new butons..)
; - langage in layer properties
; Changes
; - Blendmode : overlay, lighten, linearburn : change the bm a little, to have alpha or better result
; Fixes
; - when open a swatch, the swatch wasn't updated
; - when changing a swatch name, the new name wasn't taken



; 18/07/2015 0.57
; New
; - Edition : trim
; - Brush : full or trim the image for the brush
; Fixes
; save : when save, the temporary file weren't erased



; 16/07/2015 0.56
; Fixes
; - bug d'ouverture : si le fichier est un ancien .ani, et qu'on ouvre avecv le nouveau, ça plantait.



; 15/07/2015 0.55
; New
; - Image : Level
; - Layer Background



; 14/07/2015 0.54
; New
; - Image : contrast
; - Image : color balance
; - Image : posterize
; - layer properties : new window with some fx (not finished)
; Fixes
; - bug with update Text (after action with tool move/rotate/transform)
; - when open a jpg, the layer was a copyimage (in 24 bit), and hasn't alpha chanel, the layer is now in 32bits


; 13/07/2015 0.53
; Fixes
; - FloodFill : doesn't take the zoom
; - when delete a layer, we can't select the new layers created
; - when tool floodfill selected, the color wasn't good (was always the brush color)
; - the pick color didn't work when the tool wasn't brush/eraser or pen. Now it works with all painting tools (floodfill, box, ellpise, text...)
; - when we use shape tool (line, box, ellipse...) and pickcolor (alt + clic) the shape was drawned. Now it is drawned only if alt (pick color) isn't pushed.
; - fixe some bugs in symetry (miror vertical, horizontal and 4 views) X and Y weren't at the good position




; 12/07/2015 0.52
; New 
; Tool move, rotate, transform : option-> action on all layers viewed
; Fixe
; - bug with cut/copy and selection



; 11/07/2015 0.51
; New
;- Menu File : new document : new window + template size



; 10/07/2015 0.50
; New
; - View  :grid
; - Tool shape : transparency for the border (ellipse, rectangle)
; Changes
; - some keyboard shortcut have now ellapsedtime
; Fixes
; - Tools shape (rectangle, circle...) were bugged with outlined + alphablend



; 09/07/2015 0.49
; New
; - New stroke "line"
; - Tool Ellipse, box : outlined, proportionnal
; - Tool line : AA, radial, speedline



; 08/07/2015 0.48
; New
; - Mask alpha : Layer gadget has now a preview for alphamask
; - Mask alpha : btn : add an alpha mask
; - Mask alpha : when clear layer ; it clear the image mask alpha if smask is seleted.
; - Mask alpha : we can select the mask image or the image layer, with clic on layer-gadget
; - Mask alpha : Fill -> now we can fill the alphamask
; Fixes
; - we couldn't delete a layer if nb of layer was < 2
; - when we selected a tool, the selection-rectangle create a text layer when we add a layer
; - layer delete : when we delete a layer, it wasn't really deleted if hte numer was > layerID
; - fixe bug with add layer
; - tool rotate : the spin parameter doesn't work in Realtime
; - for all tool, with parameter (spin, checkbox...) I verify now if hte layer isn't locked and is viewed
; - when use arc-en_ciel selector color, the first stroke still was with the old color
; - color selector : the color wasn't keep after the second stroke
; - If we use keyboard shortcuts F & D, the color change to the old color




; 07/07/2015 0.47
; Changes
; - Some changes with Water brush parameters (not finished)



; 06/07/2015 0.46
; New
; - Brush water
; Changes
; - color mix old : now, with only layer, it begin with alpha transparency depending of the % of the mix color 
; - save/load colormix parameters in pref : layer and colorMix typ, and set the parameters
; - New file format (open/save) : *.ani in now a zip (renammed by ".ani" with all the layer/info in it).
; Fixes
; - Some fixes in the color mix system (modified)
; - fixe error color with mix mode : old, inverse and new (color weren't good)
; - some fixe with the new layer system (Free gadget & image)



; 05/07/2015 0.45
; New
; - Layer lock move, lock paint
; - new layer Buton interface (preview, view,lock, name, selected), event clic on UI layer ok
; Changes
;- color mix: layer only : take only the color of the image layer, not the screen (with layer + paper)



; 04/07/2015 0.44
; - View : new option : filtering (no, bilinear)
; - Zoom : 1000%
; - Edit : select All, deselect
; Change
;- Edit : copy, cut only copy/cut the selected area (not the entire layer)
; Test
; - test to optimise the drawing



; 03/07/2015 0.43
; New
; - Menu Filters
; - Filter : Noise, Blur(by g-rom), sharpen alpha
; Test
; - plug in system for filters



; 02/07/2015 0.42
; New
; - Tool fillarea : better tool (adapted from a code by comtois)
; - layer text are saved and loaded
;- MAsk alpha: we can use a mask for the alpha of the image(not finished)
; Changes
;- Now, the clear layer fill the layer and image with a white box before to erase them
; Fixes
; - bug with color selector
; - when tool = text, we couldn't add a normal layer
; - when change tool, color solect and color image weren't updated



; 01/07/2015 0.41
; New
; - Script (test) : save, stop and run script.
; - New Menu : Script (test)
; Fixes
; - color selector fixes : the colour of the selector wasn't good if we pick the colour from the canvas area or the colorImageBG. 
; - Fixe the cursor of the color Select too, which wasn't at the good place when selecting a new color.
; Test
; - various test for animation and color selector fixes




; 30/06/2015 0.40
; New
; - Tool Text : text, fontname, fontsize, fontcolor
; Changes
; - several types of layers are available : Bitmap (defaut), text for the moment. More to come (background)
; Fixes
; - bug Bm : qd on gomme, ça n'apparait pas immédiatement
; - box bug
; - bug avec color : au départ la couleur n'est pas ok




; 29/06/2015 0.39
; New
; - Panel tool parameters : now, I delete all the gadget and gadgetitem and recreate it, depending of the action selected (brush, eraser, spray, move layer...)
; - Tool Move : parameters on panel -> pos X, Y, lock X & Y dir, view border
; - Tool rotate :  parameter in options -> angle
; - Tool Transform : parameters Width/height + proportionnal
; - Tool gradient : add radial, circular, elliptic, conical, boxed gradient
; Test
; - Stroke



; 28/06/2015 0.38
; New
; - New Brush Stroke CurveType : Dash
; - New brush Stroke Type : image or circle
; Change
; - Stroke and line modified to have a better a smoothed stroke
; - The min size of the brush was 1, it's now 0.05 (when recalculated with pressure)
; - some optimisation for brush stroke



; 27/06/2015 0.37
; New
; - panel, tool : box, gradient, line, ellipse : have some gadgets (alpha..)
; - Menu & Window preference
; - Window Info (help)
; Fixes
; - some minors fixes




; 26/06/2015 0.36
; New
; - Swatch : open, save, export, merge. We can now open a swatch (gpl format (gimp, krita, mypaint..), save it, export it, and merge several swatch
; - Swatch Properties/edit : to change the number of column, the name, add a swatch in the palette, image from an image, save, open
; - Désormais Brush et autre outils ont des paramètres séparés (brush\param devient un tableau d'action:  brush(action)\param)
; - sauvegarde des paramètres du brush, eraser and pen (pref)
; - le panel tool s'actualise en fonction de l'outil choisi. Pour le moment, seul Brush, eraser et pen sont actualisés
; - Theme : now, we can customise our icones (colors and interface for later ;))
; Fixes
; - some minor bugs fixes



; 25/06/2015 0.35
; New
; - color selector 
; - swatch : create the swatch squares (not finished)
; - New stroke type : Gersam (G-rom + Falsam)
; Test
; - a lot of tests to have a better line (bezier, bresenham algo...)
; Fixes
; - some minors bugs fixes


; 24/06/2015 0.34
; New
; - color selector (wip)
; Fixes
; - Roughboard :the canvas wasn't at the good size with some image
; Test
; - Various test to fixe the Brush\pas : wasn't the good method. I'm looking for a method to have equal distance between all dots of my stroke.



; 23/06/2015 0.33
; New
; - Image : rotate image (90,180,270, free) All layers are rotated
; - ajout d'un thread autosave() pour sauver automatiquement nos calques modifiés toutes les minutes
; - new parameter for the brush : Stroke : we can use an image (default) or the "line" stroke, which is better to draw inking line for example.
; - Layer : rotate only the current layer
; Changes
; - some modifications on the line, when brush is "smooth"


; 22/06/2015 0.32
; New
; - Tool box, ellipse, line, gradient (with color and alpha)
; - Tool rotate. 
; - buttons swatch : open, save, export (just the button ^^)



; 21/06/2015 0.31
; New
; - langage : Menu ok
; - langage : Toolbar ok
; - langage : panel name ok
; Changes
; - now, the screen is parent to a container, not the window, so it's easier to resize it with this container ! (tahnks dobro !)
; Fixes
; - the mixcolor wasn't good with brushsize < 20
; - When screenUpdate(), the alpha of the layer wasn't good if Width < Height
; - bug du screen refresh : we have to refresh the screen manually if we resize the window (feature temporary)


; 20/06/2015 0.30
; New
; - brush filter : on peut mettre des paramètres (test)
; - new Filter : sol, line. Not finished : add, dark
; - Zoom with Wheel
; - add shift (square) with transform tool
; Fixes
; - bug Crop : doesn't crop the good area
; - we didn't see the border of the layer & selection when zoom/unzoom
; - We didn't see border and selection when move the canvas
; Test
; - pour bm overlay et autre : ajout bm custom + bouton custom




; 19/06/2015 0.29
; Nouveau
; - Tool selection cadre + shortcut (M)
; - Image : crop
; - framegadget for size, aspect & line (panel tool "general")
; corrigé
; - raccourci D et F ne prenaient pas en compte le brush\sizemini > brush\size
; - je n'affichai pas les calques/paper,etc pour le mixtyp = 0 (layer above)
; - la gomme buguait car le drawingmode() n'était pas bon avec rotation-angle
; - image saved (_screen) doesn't take the good format 
; - bug : qd on ouvrait un document avec des layers avec bm screen ou overlay, etc.. les layers n'étaient pas mis à jour tout de suite
; - il y avait une inversion entre bmp et jpg dans la sauvegarde image




; 18/06/2015 0.28
; Nouveau
; - Tool move : with keyboard
; - brush follow angle
; - le color mix classic est opérationnel et topissime !
; Modifié
; - brush rotation : le random peut aller dans les deux directions
; Corrigé
; - il y avait un bug avec le lavage de pinceau (ça ne lavait pas)
; - certains gadgets param du brush n'étaient pas mis à jour qd on ouvrait un preset
; Test
; - image adjustement ok : level, contraste, brightness, teinte, TSV (HSB)
; à réfléchir 
; - optimisation (à revoir, car j'ai besoin des images): je ne dessine plus sur les images, si on est en mode screen, je récupère le dessin du sprite et je le colle sur l'image



; 17/06/2015 0.27
; Nouveau
; - spin pour opacity calque
; - ajout Nbre max d'undo
; - ajout ScrollArea pour canvas RB
; - ajout ScrollArea pour swatch
; - Ajout splitter layer/swatch
; - Ajout splitter tool/color
; - les splitters se resizent en fonction de la taille de la fenêtre
; - je sauve et charge la position de la barre de séparation des splitters dans les options (tool et layer)
; - getcolor : ajout d'option pour choisir le/les calques sur lesquels on peut prendre la couleur . (All above, layer only, all, custom). Custom pas encore possible.
; modifié
; - ajout tooltip pour colormix
; - ajout d'un panneau "tra" (transparence) pour le panel des tools-brush
; - ajout de frame gadget pour brush : alpha, rot, scatter, color, symetry
; corrigé 
; - l'export et save des RB n'enregistrait pas l'image
; Tests :
; - stroke : curve smooth (onilink code conversion)



; 16/06/2015 0.26
; nouveau
; - Brush size random
; - Brush size mini + gadget (ok avec random & pression)
; - Brush intensity : permet d'augmenter l'intensité du brush (plus ou moins foncé) 
; - RoughBoard : boutons paint, pick, load, save, export
; - on sauve la roughboard en cours à la sortie et n ouvre le nom (options)
; - Image inverse color
; - Image desaturate
; - remplir le calque avec 1 pattern
; - shortcut : ctrl+j : duplicate layer, ctrl+e : merge with botom
; - save doc : désormais, je sauvegarde le niveau de zoom
; corrigé
; - le center view ne prenait pas en compte le zoom
; - qd on redimensionnait le canvas, les layers restaient à l'ancienne taille
; - qd on bougeait un layer et qu'on en sélectionnait un autre, il appliquait le changement (x,y) au layer sélectionné.
; - bug : qd on ouvrait un document avec des layers avec bm screen ou overlay, etc.. les layers n'étaient pas mis à jour tout de suite
; test
 ; - wheel mouse (marche avec mousewheel(), mais il faut examinemouse()


; 15/06/2015 0.255
; nouveau 
; - Layer : MirorH et mirorV pour layer
; - SaveImage : jpg et bmp format ajouté
; - open : all files
; Correction
; - bug avec le resizeImage() de pb, j'ai bidouillé un truc. Du coup, maintenant, on peut utiliser le smooth sur les brush et c'est supra topissime :)
; - le move layer faisait flicker l'écran



; 14/06/2015 0.25
; nouveau 
; - doc_open : on peut désormais ouvrir des image jpg, png, bmp



; 13/06/2015 0.24
; nouveau 
; - brush symetry : h, v, h&v, 4 views (kaleidoscope)
; modification
; - désormais, on peut charger un dossier de preset autre que blendman
; Correction
; - saveimage : si l'image était plus petite que l'écran, ça prenait l'écran complet
; - saveimage : ne copiait pas toute les parties
; - saveimage: sauve désormais en une seule image toutes les parties :)
; - resizedocument n'updatait pas le bm du layer (les layers étaient noirs, on devait remettre le bm).
; - après un doc_open(), si je doc_save(), ça plantait
; - layer move : ça bugait encore sur les calques > 0 car j'avais mis layer(layerdId)\x au lieu de layer(layerId)\x



; 12/06/2015 0.23
; nouveau
; - save image : j'enregistre aussi une copie du screen pour avoir le rendu final identique à ce qu'on voit à l'écran.
; - j'ai mis à jour la plupart des presets de brush et ajouter quelques presets (ink, marker, etc..)



; 11/06/2015 0.22
; nouveau
; - edit : fill (remplir en effaçant) avec couleur du fond
; - edit : remplir la transparence avec couleur du fond
; - edit coller (clipboard)
; - edit copier (clipboard)
; - edit cut
; General 
; - découpage du fichier en plusieurs sous-fichiers (enumeration.pb, macros.pb...)
; optimisation
; - je n'utilise plus mousebutton(), releasemouse(), etc.. 
; car c'était un peu bugué et ça ralentissait . 
; J'utilise la commande #WM_leftbuttondown et up pour windows, ça va beaucoup plus vite;
; corrigé
; - lorsque j'utilisé l'outil eraser, ça flickait



; 10/06/2015 0.21
; Nouveau
; - ResizeScreen si on resize la fenêtre, ça rsize le screen et les gadgets panel. (Je dois supprimer les sprites et les recréer d'ailleurs).
; - Blendmode : inverse, linearlight, Overlay (pas tout à fait identique à toshop)
; - Layer alpha blocked
; - brush size W et H
; - brush softness
; - fx type for tool brush : pixel, noise, glass, à revoir : smudge, water, blur
; Modifié
;- qd on cré un layer, ça update les gadgets paramètres du layer
; Corrigé
; - bug tool move : le zoom n'était pas pris en compte et donc ça décallait le layer
; - save : attention, changer le nom des image, car si on a 2 calque avec le même nom, on l'écrase.
; - si Clear (ctrl+X), vérifier le bm car ça bug sinon
; - si erase, vérifier le bm car ça bug sinon



; 09/06/2015 0.20
; nouveau
; - layer delete
; - layer mergetobottom (merger avec calque vers le bas)
; - layer mergeAll 
; test : 
; - changement de cursor
; - optimisation pression_wacomtablet_ok0.13 : test du systeme de tile (encore bugué, mais on approche ^^)



; 08/06/2015 0.19
; - ajout panel couleur (BG et FG) pour futur couleur select)
; - brush : lavage. Si 1, on revient à la couleur de base dès qu'on relache la souris ou que mix = 0
; - ajout Brush visco. Désormais, on ne prend la couleur que si la viscocur = 0 sinon, viscocur - 1
; - ajout image FG, et clic sur image FG : change FG color
; - ajout Fade color avec mixing : 1 nouveau type de mélange (classic)
; - ajout bouton pour le mélange (choix du type de mélange)
; - paper : on peut désormais changer le fond, sauvegarde et load du paper
; - Tool transform : ok
; modifié :
; - taille image BG
; - ajout dans les options de brush w, h, trait, smooth, hardness, lavage, visco, alphrarand, sizemin, sizepressure, alphapressure
; Corrigé 
; - le TG des presets était coupé et on ne voyait pas l'ascenceur



; 07/06/2015 0.18
; Nouveau:
; - sauvegarde automatique des images si on ferme l'application (si on activait l'autosave)
; - brush : sizeW et sizeH : pas encore actif
; - brush trait : on peut l'activer ou non
; - brush smooth : idem
; - brush hardness : on peut régler le hard de chaque brosse
; - brush : alpha pressure
; Modifié :
; - Tool box (encore bugué)
; - paint getcolor (encore bugué)




; 06/06/2015 0.17
; Nouveau
; - ajout pression tablet !! (gros morceau :). il reste encore du boulot, mais c'est déjà pomalze :)
; - ajout d'un center aux calques, pour les transformations (rotations, miror par exemple).
; - ajout du système Tablet (structure, variables, constantes, prototypes) pour la pression des tablettes
; - Brush : pression tablet pour size 
; optimisation : 
; - j'ai supprimé un screenupdate() après qu'on ait dessiné, ça fait gagné 10 à 20fps environ
; buggué : 
; - Tool :ajout box 



; 05/06/2015 0.16
; Nouveau :
; - Image : Resize document
; - Image : resize canvas
; - File : Doc_Open() : ouvre les fichiers *.teo.
; - File : save doc(), save le fichier 
; - tool fill (un peu buggué, mais c'est du bug PB ^^
; - brush rotation
; - alpha rnd
; Modifié
; - statusbar : j'ai ajouté des champs (texte "") pour la progressbar (pour sauve, ouvrir, new et transformation diverses.
; - on peut passer de l'image brush 0 à max et de max à 0 désormais (faire le tour quoi)
; - ajout de presets crayons
; Corrigé 
; - lorsque j'appuie sur B, désormais, ça update la couleur
; - paper pas à la taille du document



; 03/06/2015 0.15
; nouveau
; - Tool eraser
; - Tool clear ( = ctrl+x)
; - ajout de 25 images de brush supplémentaires
; - ajout panneau color/swatch/roughboard/gradient
; - ajout Roughboard, on loade l'image de la roughboard par defaut
; - quand on clique sur la roughboard, on récupère la couleur sous le clic souris
; - panneau Preset, TG, bouton reload, save, export, name
; - qd on clic sur un preset ça le charge, export ça l'export, save ça sauve le preset en cours
; modifié :
; - bord autour du gadget BG color
; corrigé :
; - layer bm : efface le calque image qd on change le bm
; - bm add ok
; - bm multiply ok
; - qd on changeait l'image du brush, on ne pouvait pas avoir l'image max
; - tool move buggait avec le nouveau système de painting
; - scatter n'était pas recalculé à chaque point (pas à chaque trait)
; - qd on était sur le canvas, ça perdait le focus du gadget courant


; 02/06/2015 0.14
; nouveau :
; - tool move : désormais je demande une confirmation du changement et si oui, je l'applique.
; - tool clear : on efface le layer courant mais on ne change pas l'outil précédent
; - Ajout raccourci centerView
; - ajout trait screen
; - ajout trait image
; - ajout bouton brush next et previous
; - brush : ajout raccourci D et F (pour changer la taille)
; - on peut changer l'image du brush avec les boutons next et previous
; Menu : - ajout d'un option temps réel pour voir les changements en tps réel
; Modifié :
; - Le bouton du tool est actif au lancement de l'appli
; - openOptions et saveOptions sont opérationnels maintenant
; - désormais, je dessine directement le brush sur le sprite courant, puis sur l'image et j'update le screen avec ts les calques visibles 
; Je passe en tps réel à 30FPs (au lieu de 12 si je dessine l'image courante sur le sprite courant.
; Corrigé :
; - exportallpng : enregistrait les calques à la racine
; - Bm multiply : ajout d'une box() blanche avant l'image



; 01/06/2015 0.13
; nouveau :
; - File : new avec taille à définir
; - File : import image on layer
; - File : Save image (as png)
; - File : export all layer as png
; - File : export all layer as zip
; - Edit : clear layer
; - options : open, save, mais vide pour le moment
; - Paper : correction avec le zoom : je diminue la surface du paper, plutôt que les dalles.
; - Layer : duplicate
; - Layer blocked
; - brush scatter
; - brush mixing ok
; - brush : la couleur est ok sur l'image
; - brush : maintenant, on mixe les couleurs entre la couleur actuelle et la couleur en point(x,y) du calque
; - brush preview & update brushpreview
; - tool pipette
; - tool move layer
; ui
; - bouton mix, change le mix du brush
; - ajout toolbar  & icone : bouton pinceau, gomme, crayon, spray,tampon, etc..
; - pipette couleur (alt+clic)
; - ajout raccourci pour outil : b,e,v,k,g
; menu
; - view : resetcenter, centerview, zoom 50,100,200,300,400,500
; corrigé :
; - bug qd on peint sur l'image et que le canvas est décalé
; - qd on a un zoom et qu'on peint ça décale le painting sur l'image



; 31/05/2015 0.12
; - ajout d'un fenêtre pour charger tout (intro)
; - Ajout cbb layerBM, qd clic layer > bm actualisé
; - ajout gadget selecteur couleur
; - changer couleur brush
; - paper ou fond
; - corrigé : on peint sur le layer Id
; non fini ou buggué :
; - ajout layerBM multiply, Add screen, colorburn, linearburn, clearlight, lighten, darken


; 30/05/2015 0.11
; - je dessine sur l'écran et sur l'image active
; - si on zoome/dezoome, ça update l'image active et update le calque actif (layer(layerid)\sprite)
; - ajout de l'array dot() pour sauvegarder les points créés
; - ajout statusbar, on écrit le zoom dedans, ainsi que la taille du document
; - ajout panel tool
; - ajout gadget brush size, alpha, rotation, scatter, pas
; - ajout panel layer
; - ajout gadgets layer : view, alpha, bm, bouton +,- ht, bas
; - layer selected > info, layerId change et gadget layer update
; - layer alpha
; - layer view
; commencé, mais pas fini ou bugué 
; ok 0.13 - on peint sur le layerId
; - bug avec le zoom et les points sur l'image
; - layer bm : add


; 29/05/2015 0.10
; - premiers tests
; - ajout 2 calques : dessus, dessous
; - test drawing sprite on screen, avec rot, brush image
; - layer_add() : ajout de calque
; - ajout FPS()
; - ajouter des sprite quand on peint : devient assez lent
; - dessiner sur l'image et updater le screen avec cette image très lent pour image grande (1024*1024)
; l'ideal serait d'avoir le RTT sur surface !!
;}

;{ ************************* TODO ************************************

;{ -------- todo list priority --------------------

; URGENT

; je dois ajouter les fonctions de ces fichiers :
; animatoon drawer0.14.pb
; - fonctions de dessins top (pour des lignes), le système de trait + stroke()/dot()
; - editeur de brosse ronde (avec circle) et en dégradé, très rapide aussi (5000x5000 !)
; GM8 : 
; - fichiers bezier
; TEO :
; - le tampon
; - le dessin et trait (le brush ne tourne pas quand on clique)
; - les toolbar flottante ?
; - ajouter des sliders pour la taille et transparence
; - ajuster le "pas" (espace entre 3 points) à la taille.
; Animatoon optimised :
; - ajouter le système de stroke/dot
; - ajouter les dalles ???
; brush
; - un brush editor fenêtre séparée
; - avec ligne vector drawing
; - avec brush Circle (voir fichier brush editor)
; - brush qui diminue ou s'efface (taille, alpha)
; - brush avec fondu entre les lignes ou couleurs
; - brush noise, texture, dualbrush



; - CheckBox : paper pour colormix() : je ne sais plus ce que c'est ^^.

; Optimisation / Paint : 
; - ajout dim dot/stroke  : ajouter un tableau avec les points (dot()) et les strokes (stroke()), 
; pour garder paramètres des points (x,y, pression, transparence, taille, couleur, etc...) et les 
; - ne calculer qu'une seule fois les dots et ensuite les dessiner sur le sprite et l'image (et pas recalculer pour chacun)
; - undo/redo
; - ajouter les tile() pour le tps réel et pouvoir effacer le screen/afficher img du fond/dessin/calques dessus

; brush
; - fade size avec pas et trait
; - bezier (onilink GM8) : adaptation ok !!, reste plus qu'à l'intégrer
; - color random

; view
; - repère

; tool
; - pattern

; panel
; - gradient

; layers
; - layer link : layer son liés entre eux, si on bouge, rotate, scale les 2 sont tranformés
; - layer group : des dossier pour les regrouper (si on met sur yeux off : on ne voit plus aucun calque 
; - select alpha (ctrl+clic) comme photoshop (on clic avec ctrl sur le calque, et ça sélectionne l'alpha)
; - alphatoStroke : ??? remplir le calque 

; bacground (paper)
; - ajouter une fenêtre pour gérer les paramètres du background (paper, checker...) : scale, transparence, dureté (prise en compte lorsqu'on peint (pas encore intégré ça), 
; couleur du papier (donc, je crée une 2eme image avec le papier en mixant la couleur (blendmode color ?), voir ou non le fond, etc.

; editions
; - ctrl+X : copier le calque (la selection) avec getclipboardimage() avant d'effacer
; - ouvrir une image en tant que calque  : crée un nouveau calque plutôt que de coller l'image sur le calque courant.
; - undo
; - redo

; Images
; - HSB

;}

;{ -------- OK ---------------------------
; ok :

; 0.57
; - swatch : del, insert, sort

; 0.54
; Image : colorbalance, levels, brightness/contrast

; 0.50
; - grid


; 0.49
; - speed line
; - radial line


; 0.45 :
; - colormix sur sprite only : on prend la couleur sur l'image et non sur le screen
; - Inverse fade color avec mixing (reprise du code animatoon agk)


; 0.36
; swatch : add, pick


; 0.34, 0.35
; - couleur selector


; 0.33
; - rotation tool + edition

; 0.32
; - box
; - ellipse
; - line
; - gradient

; 0.29
; - flickering avec colormix
; - Tool M (cadre sélection)

; 0.28
; - brush follow angle,


; 0.27
; - mettre le keyboard en azerty pour fr
; - getcolor sur layer current only 

; 0.26 :
; - remplir avec motif

; 0.24 :
; - saveImage : on sauve aussi l'image qu'on visualise

; 0.22
; - remplir avec couleur fond
; - cut, copy, paste

; 0.21
; - layer bm screen
; - sizeW et sizeH
; - alpha blocké
; AR : - layer bm overlay


; 0.20
; - layer merge botom
; - layer delete
; - layer merge all


; ok 0.19
; - brush visco 
; - FG
; - transform
; - layer move up


; ok 0.18
; - trait option
; - smooth option


; ok 0.17
; - pression tablet


; ok 0.16
; - resize images
; - resize canvas
; - open doc
; - save doc
; - brush rotation
; - alpha rnd
; - tool fill

; ok 0.15
; - roughboard
; - eraser
; - rotation : ajouter la rotation sur l'image (le dessin)
; - layer move down


; ok 0.14
; - brush changer image
; - ajout trait et pas


; ok 0.13:
; - layer duplicate
; - import image on layer
; - export layer png
; - clear layer current
; - brush color sur image
; - brush mix
; - brush scatter
; - ajout getcolor, getalpha
; - layer blocked
; - pipette couleur (alt+clic)
; - tool pipette
; - move layer
; - view : ; zoom 50,100,200,300,400,500
; - center view
; - Reset view


; ok 0.12 :
; - layer bm multiply
; - layer bm add


; ok 0.11 :
; - ajout du pan (sorte de camera)
; - layer selected
; - layer alpha
; - layer view
; - ajout panel tool
; - ajout gadget brush size, alpha, rotation, scatter, pas
; - ajout panel layer
; - ajout gadgets layer : view, alpha, bm, bouton +,- ht, bas

;}

;{ -------- contenu par version // Features By version ----------


; V0.1x :
; ok - UI : menu, panel (vide), gadgets, statusbar...
; ok - menu : file / edit / view / layers / help, some menus are empty, waiting the futur features.
; ok - view : zoom (50, 100, 200, 300, 400, 500 %), reset view, center view
; ok - Canvas : move & zoom canvas
; ok - test For painting  
; > Version 0.19 OK the 9th june 2015 !
; Bonus : 
; - this version already has : eraser tool, preset, a lot of brush parameters (size, alpha, rotation, scatter, pressure tablet)
; - structure layers (bm, view, lock, image, sprite, x,y,w,h, nom) et brush (size, alpha, image)


; V 0.2x :  (actual version)
; ok - Tool : brush. 
; ok - brush parameters : size (+size width/height), opacity, scatter, rotation, change image, pressure tablet, stroke, pas, Random (Rotation, alpha), 
; ok - brush parameters : hardness, softness, smooth,color mixing, viscosity, wash), image preview,random size
; ok - preset brush (open, change, save, export). 
; ok - Some  presets : crayon, pen, pencil, watercolors, marker, calligraphy, FX, blend, charcoals, charks... (in 0.15)
; ok - tool : Eraser (same parameters As brush). (in 0.15)
; ok - Shortcut : brush (B), Eraser (E), Brush Size + (D), Brush Size - (F)
; Not ok / For next version : - Brush : pressure fade size between dots, 
; Bonus : brush intensity

; 
; V 0.3x :
; ok - Layers : add, delete, duplicate, merge With botom, merge all, Import an image on layer (ctrl+I), Change layer position (up, down)
; ok - layers parameters: view, opacity, lock, lock alpha, + some blendmode (add, multiply, clearlight, inverse).
; ok - File (+shortcuts): new doc (ctrl +N), opendoc (ctrl+O), save doc (ctrl+S), saveImage, export layer (png, jpg), export all layers in png Or zip.
; ok - Edit : clear layer (in 0.15)
; ok - Preferences : language, some options
; ok - brush follow angle,
; Not ok :/for a next version : - Brush : fade alpha, fade size
; 

; V 0.4x :
; ok - Edit : resize document, resize canvas (in 0.16)
; ok - tool : transform layer (Width/height + proportionnal (+shift)) (in 0.20)
; ok - tool : transform layer -> parameters Width/height + proportionnal (in 0.39)
; ok - Tool : move layer (hand (free))
; ok - Tool : move With keyboard (arrow) (in 0.28)
; ok - Tool : Move direction locked (move in width Or height), Define the new position)
; ok - Tool : rotate layer
; ok - Tool : rotate layer, parameter in options : angle
; ok - Shape tool : gradient (linear,radial, circulare,elliptic,boxed,conical), box (+round) & Ellipse (full) (in 0.26/0.38)
; ok - box (outlined + proportionnal)
; ok - Ellipse (outlined, + proportionnal)
; ok - Panel tool option change in fonction of the selected tool.
; ok - Line Tool : line (in 0.23)
; ok - Line Tool : radial line, speed line (in 0.49)
; BONUS : 
; - Image filters : noise, blur
; not ok (because purebasic don't have AA drawing): AA box & ellipse
; 
; 
; V 0.5x :
; ok - Color selector (in 0.34/0.35)
; ok - Swatch : open (*.gpl), save, merge, new, add, change column, change name (in 0.36)
; ok - Swatch : delete swatch
; ok - Roughboard : open, save, draw (in 0.21)
; ok - Roughboard : pick color (in 0.20)
; ok - Tool Text (in 0.40)
; - Layer group
; ok (plus ou moins) - linked layers
; Bonus : posterize, trim



; V 0.6x :
; ok - Edit : cut, copy, paste (in 0.22)
; - Image : hue/saturation
; ok - image : brightness/contrast, color balance, level
; ok - Transformation : miror Horizontal, miror vertical (in 0.255)
; ok - transformation : rotation (90, 180, 270, free)
; ok - Layer Inverse color
; ok - Brush : water (dillution) (in 0.45)

; 
; V 0.7x :
; ok - Fill With BG color (in 0.22)
; ok - Tool : selection (rectangle)
; - Tool selection : Brush selection.
; - Menu selection : +, -, random, inverse
; - Move selection 
; ok - selection square : cut, copy, paste selection. 
; - Paint on selection
; ok - Fill With Pattern
; ok - Layer : image repeated (background)
; ok - Layer : Select alpha (in 0.575)
; - Brush : add noise, dynamic brush
; 
; 
; V 0.8x : FX
; AR ok : - Brush Type : Glass, Pixel, noise (in 0.21)
; - Particles : add system, x,y,life, type (water, normal, ), opacity
; - Brush blendmode drawing : add, multiply
; ok - Alpha mask (in 0.50)
; - Adjustment layer : level, brightness, saturation
; - Tool : pattern

; 
; V 0.9x :
; ; ok : - Brush symetry (horizontal, vertical, H&V, kaleidoscop) (in 0.24)
; - Undo/redo : For brush painting. I hope To add the undo For some actions (delete layers
; - improve brush engine : strokes are now saved For undo And better performance.
; - brush : Improve brush stroke > "smooth" the stroke curve (sort of bezier For stroke curve).
; - Image : Convert To alpha (stroke)
; ok - brush And eraser are differents tools
; - Brush : random color

; V 1.0x :
; - brush curve bezier : avoir de belles courbes
; - optimisation (dalle ? preview plus petit ?) voir branch/drawing_optimisation
; - double brush qui s'influencent
; - brush prend matière du papier si on appuie fort
; - plus on peint, moins il y a d'eau et plus le pinceau devient "dur"
; - taille de la ligne : réduction progressive en fonction de la pression 
; (actuellement, les ligne ont la taille du 1er point, donc ça fait un truc crénelé)
; - fondu (transparence (déjà ajouté dans animatoon_pb, vers 0.29x)
; - fondu taille (idem que transparence)
; - remplir avec motif
; - peindre avec un motif
; - pinceau : peindre avec un brush+motif (en modeoverlay ou multiply ?)
; - paramètres d'outils : mettre les outils de base 
; - onglet et fenêtre brush éditor :avec tout : taille, opacité, rotation, fondu, dynamique (pression, aléatoire...), 
; couleur, image (1+2), blendmode, etc..



; 1.5 ajout vectoriel
; - ajouter forme vectorielle (ajouter le code de cartoon ?)
; - ligne /courbe vectoriel




; pour un autre logiciel (animation 2D) : 
; 
; V 1.0x :
; - animation Module : Interface (anim layer, frame dock, buttons...)
; - animation : add frame, delete frame, move frame, duplicate frame
; - Animation layers : camera, image, shadow, fx, sound
; - play, stop, loop, start /End frame, preview, set framerate
; - save animation / load animation (animatoon format)
; - save animation As png (all frames are saved As png)
; - oignon skining



; 1.0
; - animation : add frame, duplicate frame, del frame, move frame
; - setframerate (speed), start, end anim
; - play, stop, loop
; - oignon skinning

; 1.1
; - animation : camera layer, move camera, rot, zoom, fx (shake)
; - bitmap layer
; - sprite layer : move, rot, scale, symetry, skew ?

; 1.2
; - fx particles

;}

;}

;{ ************************* BUGS ************************************

; - Subsystem opengl :  background repeated n'apparaissent pas (fond noir),avec opengl : utiliser square.
; - bug BM : colorburn pas bon
; - bug bm : certains BM buguent avec l'opacité
; - bug si pas de pression : brush pourri
; - si ouvre file avec texte : pas demander fontrequester
; - si ctrl+T (transform), il y a un bord noir ensuite
; - text : on doit pouvoir éditer le texte (couleur, string, size...)
; - si on gomme avec un calque au dessus de notre calque, ca flickering

; ------- Fixes // Corrigé -------:
; O.584
; - bug subsystemopengl : le paper n'apparait pas.

; autre version : 
; - bug qd on peint, ça flicke en OpenGL (ok si clearscreen())

; 0.54 :
; - bug layer texte avec V
; - layertext : si change font : pas d'update
; - bug layer texte affichage update

; 0.53 :
; - bug symetry

;0.50 :
; - bug colorbg
; - si F ou D : color revient à l'ancienne

; 0.41 :
; - color select, : si on pick la couleur ou si on utilise le colorrequester() ou au départ, le color selector n'est pas bon

; 0.40
; - bug Bm : qd on gomme, ça n'apparait pas immédiatement
; - box bug
; - bug avec color : au départ la couleur n'est pas ok

; 0.29
; - qd on ouvre, pas d'update des bm
; - inversion bmp/jpg avec saveimage

; 0.255
; - brush : hardness + smooth bug avec rotation : avec une technic un peu bilouteuse, car c'est le resizeImage() de pb qui merdoule ^^

; 0.24 :
; - bug saveimage
; - bug move encore
; - bug doc_open() suivi de doc_save() : plante

; 0.22 :
; - bug transform tool avec zoom : le cadre est décalé par rapport à la souris

; 0.21
; - qd resizeScreen : faire un screenupdate sur chaque calque 
; - tool move : bug si zoom différent de 100
; - save : attention, changer le nom des image, car si on a 2 calque avec le même nom, on l'écrase.
; - si Clear (ctrl+X), vérifier le bm car ça bug sinon
; - si erase, vérifier le bm car ça bug sinon
; - bug BM : linear light

; 0.19
; - quand on zoome, ça ne prend pas en compte le blendmode
; semble ok sur screenoutput() - qd on peint avec mixing, il arrive que la couleur ne soit pas prise car on dépasse le canvas alors qu'on est dessus (pb avec le zoom et le if x> ...

; 0.18 
; - quand on zoome : ça affiche même les calques cachés

; 0.16
; - paper pas à la taille du document

; 0.15 :
; - layer bm : efface le calque image qd on change le bm

; 0.14
; - saveall png enregistre les calques à la racine
; - gros bug layer bm (c'était purebasic qui buguait)
; - rotation brush : il manque la rotation du brush sur l'image
; - pb avec les blendmode en tps reel si on dessine trop vite :( : 
; à priori ok j'ai 30fps et je descend à 22
; j'ai aussi modifé le mousebuton() en le sortant de la boucle, ça évite de trop planter
; je dessine désormais sur le sprite le brush, plutôt que l'image complète

; 0.13
; - couleur du brush sur image reste blanc
; - pas d'update si on bouge le canvas
; - bug brush position sur image si canvas bougé
; - bug size brush sur image

; 0.11
; - corriger bug souris gestion pas terrible

;}



; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 23
; FirstLine = 12
; Folding = G-
; EnableXP
; EnableUnicode