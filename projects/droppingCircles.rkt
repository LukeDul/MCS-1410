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

; Color Randomizer
; Speed Randomizer
; Size Randomizer
(define WINDOW-HEIGHT 400)

(define WINDOW-WIDTH 200)

(define window (rectangle WINDOW-HEIGHT WINDOW-WIDTH 'solid 'gray))

(define ball-x (/ WINDOW-WIDTH 2))
         
(define-struct ws (misses points ball))

(define-struct ball (radius color speed x y))

(define init-ball (make-ball 10 'red 5 ball-x 0))

(define init-ws (make-ws 0 0 initball))



; worldState -> worldState 
; tock pseudocode
;   upon ball death ( current ball-y - radius > goal line )
;    mutate ball-radius
;    mutate ball-color
;    mutate ball-speed
;    reset ball-x and ball-y
;   otheriwse
;    increment ball-y according to ball-speed
(define (tock worldState) ())

; worldState -> worldState 
(define (mouse-handler worldState) ())



; worldState -> Image
; draws a rectangele overlayed by a circle (ball (ws-ball worldState)) 
(define (draw worldState) ())

(big-bang init-ws
 (to-draw draw) ; for drawing
 (on-key key-handler) ; to respond to key press
 (on-tick tock)) ; every clock tick
         