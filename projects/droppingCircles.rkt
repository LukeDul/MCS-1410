;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname droppingCircles) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; The game will have up to one ball on the screen at any time. 
; The balls slide down the screen at different speeds, 
; and have different sizes and colors. 
; To make it fun, and pretty.

; The user clicks on the balls to get points,
; and clicking on a ball makes it disappear.
; If ten balls go off the bottom of the screen, the game ends.

; What information is need to start the game from pause?
;  World State
;  Ball-Radius
;  Ball-Color
;  Ball-Position
;  Ball-Speed

;  Missed-Balls
;  Clicked-Balls

; Functions

; on-click
; on-tick
; draw

(define-struct WorldState ())