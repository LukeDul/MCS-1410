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

; on-mouse
; on-tick
; draw

; Color Randomizer
; Speed Randomizer
; Size Randomizer

(define WINDOW-HEIGHT 500)

(define WINDOW-WIDTH 300)

(define MAX-MISSES 10) ; number of misses allowed before game over

(define MAX-RADIUS 30)

(define MIN-RADIUS 10)

(define MAX-SPEED 10)

(define MIN-SPEED 3)

(define COLOR-SET (list 'red 'green 'blue 'yellow 'orange))

(define BALL-START (- -5  MAX-RADIUS)) ; -5 is a small buffer so the ball doesnt drop too quickly 
         
(define-struct ws (misses points ball-radius ball-color ball-speed ball-y game-over))


; Number, Number, Number, Number -> Number
; d(A, B) = sqrt((x2 -x1)^2 + (y2 - y1)^2) 
(define (distanceBetweenTwoPoints Ax Ay Bx By) (sqrt (+ (expt (- Bx Ax) 2)
                                                        (expt (- By Ay) 2))))

(define colors (list 'red 'green 'blue 'yellow 'orange))
; use mouse movement as randomizer
; outputs a random color from a list of colors   
(define (colorRandomizer n) (if (= n 1) 'red 'red))

; Number, Number -> Number
; takes a seed and a range and outputs a number within that range
(define (randomizer seed range) (modulo seed range))

; Number, Number -> List
; takes a minimum and a maximum and builds a list
; Given 1, 10 Output: '(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
; base case is when list rest = max
; list (min, min +1, (min +1) +1 ... n+1 = max)
; (define (listBuilder min max)
  ; (rest (cons min (cons (add1 min) empty))))
;  
; worldState -> worldState 
; tock pseudocode
;   upon ball deaths equal to MAX-MISSES
;    end game 
;   upon ball death ( current ball-y - radius > goal line )
;    mutate ball-radius
;    mutate ball-color
;    mutate ball-speed
;    reset ball-y 
;   otheriwse
;    increment ball-y according to ball-speed
(define (tock worldState)
  (cond
    [(>= (ws-misses worldState) MAX-MISSES)
     (make-ws
      (+ 1 (ws-misses worldState)) ;increment misses
      0 ;retain points
       10 ; mutate radius
      'red ; mutate color
      2 ; mutate speed
      (+ (ws-ball-y worldState) (ws-ball-speed worldState))
      #true)]
    
    [(>= (- (ws-ball-y worldState) (ws-ball-radius worldState)) WINDOW-HEIGHT)
     (make-ws
      (+ 1 (ws-misses worldState)) ;increment misses
      (ws-points worldState) ;retain points
      (randomizer 1 MAX-RADIUS) ; mutate radius
      (colorRandomizer 1) ; mutate color
      (randomizer 1 MAX-SPEED) ; mutate speed
      BALL-START
      #false)]
    
    [else
     (make-ws
      (ws-misses worldState) ;retain misses
      (ws-points worldState) ;retain points
      (ws-ball-radius worldState) ; retain radius 
      (ws-ball-color worldState) ; retain color
      (ws-ball-speed worldState) ; retain speed
      (+ (ws-ball-y worldState) (ws-ball-speed worldState))
      #false)])) ; mutate ball-y. ie move the ball down


; worldState -> Image
; draws a rectangle overlayed by a circle (ball (ws-ball worldState)) 
(define (draw worldState)
    (place-image
     (if (ws-game-over worldState)
         (text "GAME OVER" 24 'red)
         (circle (ws-ball-radius worldState) 'solid (ws-ball-color worldState))) ;ball image
     (/ WINDOW-WIDTH 2) ; x
     (ws-ball-y worldState) ; y
     (rectangle WINDOW-WIDTH WINDOW-HEIGHT 'solid 'black))) ; background


; worldState -> worldState
; if the distance between mouse coords and ball coords is <= ws-ball-radius and mouse is clicked
;  increment points
;  remove ball
;  drop another ball
; else
;  return worldState ie do nothing 
(define (mouse-handler worldState m-x m-y click)
  (cond
    [(and
      (<= (distanceBetweenTwoPoints (/ WINDOW-WIDTH 2) (ws-ball-y worldState) m-x m-y ) (ws-ball-radius worldState))
      (mouse=? click "button-down"))
     (make-ws
      (ws-misses worldState)       ;retain misses
      (+ 1 (ws-points worldState)) ; increment points
      (random MIN-RADIUS MAX-RADIUS)         ; mutate radius
      (list-ref colors (random 0 4)) ; mutate color
      (random MIN-SPEED MAX-SPEED) ; mutate speed
      BALL-START
      #false)]
    [else worldState]))  
 

(define init-ws (make-ws 0 0 MAX-RADIUS 'red 3 (- BALL-START 50) #false)) ; 50 is an extra buffer for the initial drop

(big-bang init-ws
 (to-draw draw) ; for drawing
 (on-mouse mouse-handler) ; to respond to key press
 (on-tick tock) ; every clock tick
 (name "CLICK THE BALL OR YOU MIGHT DIE") 
 (state #f)) ; #t for debugging worldState )
 