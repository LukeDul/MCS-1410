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
(define WINDOW-HEIGHT 500)

(define WINDOW-WIDTH 300)

(define MAX-MISSES 10) ; number of misses allowed before game over

(define MAX-RADIUS 30)

(define MIN-RADIUS 10)

(define MAX-SPEED 10)

(define MIN-SPEED 5)

(define COLOR-SET (list 'red 'green 'blue 'yellow 'orange))

(define ball-start 0)

(define window (rectangle WINDOW-HEIGHT WINDOW-WIDTH 'solid 'gray))

(define ball-x (/ WINDOW-WIDTH 2))
         
(define-struct ws (misses points ball-radius ball-color ball-speed ball-y))

; outputs a random color from a list of colors  
(define (colorRandomizer n) (if (= n 1) 'red 'red))

; outputs a random radius within the bounds of MAX-RADIUS and MIN-RADIUS (MIN-RADIUS <= RADIUS <= MAX-RADIUS)
(define (radiusRandomizer n)(if (= n 1) 10 10))

; outputs a random speed within the bounds of MAX-SPEED and MIN-SPEED (MIN-SPEED <= SPEED <= MAX-SPEED)
(define (speedRandomizer n)(if (= n 1) 1 1))

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
    [(= (ws-misses worldState) MAX-MISSES)
     (stop-with "GAME OVER")]
    
    [(>= (ws-ball-y worldState) WINDOW-HEIGHT)
     (make-ws      (+ 1 (ws-misses worldState)) ;increment misses
                   (ws-points worldState) ;retain points
                   (radiusRandomizer 1) ; mutate radius
                   (colorRandomizer 1) ; mutate color
                   (speedRandomizer 1) ; mutate speed
                   ball-start)]
    
    [else
     (make-ws (ws-misses worldState) ;retain misses
                   (ws-points worldState) ;retain points
                   (ws-ball-radius worldState) ; retain radius
                   (ws-ball-color worldState) ; retain color
                   (ws-ball-speed worldState) ; retain speed
                   (+ (ws-ball-y worldState) (ws-ball-speed worldState)))])) ; mutate ball-y. ie move the ball down


; worldState -> Image
; draws a rectangele overlayed by a circle (ball (ws-ball worldState)) 
(define (draw worldState) (overlay/xy
                           (rectangle WINDOW-WIDTH MAX-RADIUS 'solid 'white) ; covers ball entrance 
                            0 0
                           (underlay/xy
                            (rectangle WINDOW-WIDTH WINDOW-HEIGHT 'solid 'black) ; background
                            ball-x
                            (ws-ball-y worldState)
                            (circle (ws-ball-radius worldState) 'solid (ws-ball-color worldState)))))

; Number, Number, Number, Number -> Number
; d(A, B) = sqrt((x2 -x1)^2 + (y2 - y1)^2) 
(define (distanceBetweenTwoPoints Ax Ay Bx By) (sqrt (+ (expt (- Bx Ax) 2)
                                                        (expt (- By Ay) 2))))

; worldState -> worldState
; if the distance between mouse coords and ball coords is <= ws-ball-radius and mouse is clicked
;  increment points
;  remove ball
;  drop another ball 
(define (mouse-handler worldState m-x m-y click)
  (cond
    [(and (<= (abs (distanceBetweenTwoPoints m-x m-y ball-x (ws-ball-y worldState)))
              (+ 5 (ws-ball-radius worldState)))
          (mouse=? click "button-down"))
            (make-ws
             (ws-misses worldState)       ;retain misses
             (+ 1 (ws-points worldState)) ; increment points
             (radiusRandomizer 1)         ; mutate radius
             (colorRandomizer 1) ; mutate color
             (speedRandomizer 1) ; mutate speed
             ball-start)]
    [else worldState]
    ))  


(define init-ws (make-ws 0 0 10 'red 10  ball-start))

(big-bang init-ws
 (to-draw draw) ; for drawing
 (on-mouse mouse-handler) ; to respond to key press
 (on-tick tock)) ; every clock tick
 
 