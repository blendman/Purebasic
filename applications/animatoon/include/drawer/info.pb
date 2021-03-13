; pen/tablet input test for wacom tablets and compatible devices
; using WINTAB32.dll
;
; by Danilo, 2008/06/12
; Modified by blendman : 2013 & 05/2015
; PB 5.22LTS
; Wacom SDK: http://www.wacomeng.com/devsupport/ibmpc/downloads.html


; --------------- CHANGES ---------------

; 17/06/2015 0.15



; 11/06/2015 0.14
; - ajout des stroke et dots
; - ajout du systeme de fade size


; 09/06/2015 (0.13)
; - ajout des tile sur les layer et pas en general
; - ajout alt pour prendre la couleur sur le canvas


; 28/05/2015 (0.12)
; - ajout d'un scrollarea pour le canvas
; - ajout d'une structure doc (pour doc\w,h,name$)
; - je n'update plus à chaque fois que j'ai tracé un trait, mais uniquement lors de certaines opérations
; - test : ajout de tile pour les image du dessus



; 10/05/2015 (0.11)
; correction bug : les layers n'apparaissent pas sur le canvas
; layer : ajout image au dessus et en dessous
; save : correction
; export all layer
; Import image on current layer
; change name layer
; layer duplicate ok
; petit optimisation du canvas : j'écrase les calque de dessous et de dessus pour n'avoir que 3 images à afficher
; ajout icones
; ajout statusbar
; ajout brush typ : brush et eraser


; 09/05/2015 (0.10)
; brush & gadget : scatter, trait, pas, size, alpha, pressure (size, alpha), color
; menu : save, export layer
; layer : add, select, alpha, view
; export image layer, save image (with all layers)



; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 11
; EnableUnicode
; EnableXP