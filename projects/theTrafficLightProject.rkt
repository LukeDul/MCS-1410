;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname theTrafficLightProject) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Luke Dulworth

; Depict a Traffic light using Big Bang (working with your small group):
; Which is...
; Red for 5 sec 
; Green for 4 sec
; Yellow for 1 sec
; Back to Red for 5 sec, and so forth (in a loop). 
; Three lights in a column (in a box), the one that is ON should be depicted as solid, and the other two should be depicted in outline.
; Also, if the user presses a space bar, the light should turn green.

(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")

(define-struct ws (color time))


(define background (rectangle 200 400 'solid 'gray))



; String -> Next Color
; Takes the WorldState and outputs the next color
; Given ws-color

(define (stepper color)
  (cond
    [(string=? color RED) GREEN]
    [(string=? color GREEN) YELLOW]
    [(string=? color YELLOW) RED]
    ))


; COLOR, TIME -> Boolean
; COLOR is a String, RED, GREEN or YELLOW 
; TIME is a Number

; Takes COLOR and TIME and outputs a Boolean that indicates whether the given COLOR has been on for long enough.

; Given: RED & 5 Output: #true
; Given: GREEN & 4 Output: #true
; Given: YELLOW & 1 Output: #true

; Given: RED & 4 Output: #false
; Given: GREEN & 3 Output: #false
; Given: YELLOW & 0 Output: #false
(define (match? color cur_time)
  (cond
    [(and (string=? color RED)    (= cur_time 4)) #true]
    [(and (string=? color GREEN)  (= cur_time 3)) #true]
    [(and (string=? color YELLOW) (= cur_time 0)) #true]
    [else #false]) )


; WorldState -> WorldState
; Takes a WorldState and outputs a new WorldState that has been mutated by TIME, key_handler, and COLOR.
; [NOTE: Tock runs once per second]

; Logic:
;    1. IF COLOR and TIME matches or Spacebar has been pressed : Mutate WorldState
;        [ if match() returns true or key_handler returns #true ]
;    2. ELSE                                                   : increment TIME

; Given: (ws RED, 5) Output: (ws GREEN, 0)
; Given: (ws GREEN, 4) Output: (ws YELLOW, 0)
; Given: (ws YELLOW, 1) Output: (ws RED, 0)

; Given: (ws RED, 4) Output: (ws RED, 5)
; Given: (ws GREEN, 3) Output: (ws GREEN, 4)
; Given: (ws YELLOW, 1) Output: (ws RED, 0)
(define (tock ws)
        (cond
          [(match? (ws-color ws) (ws-time ws)) (make-ws (stepper (ws-color ws)) 0)]; Mutate WorldState 
          [else (make-ws (ws-color ws)(add1 (ws-time ws)))]); increment TIME 
 )


; WorldState, String -> Image
(define (light color ws)
  (circle 50 (if (string=? color (ws-color ws)) 'solid 'outline) color))


; World State -> Image
; Takes the current world state and draws it
; Given: (make-ws "red" 0) Output: red traffic light solid, rest outlined
(define (draw ws)
  (overlay (above (light "red" ws)
                      (light "green" ws)
                      (light "yellow" ws)
                      ;(beside (text "Timer:" 24 "Black")(text (number->string(ws-time ws)) 24 'Black))
                      )

               background))


; WorldState -> WorldState
(define (key-handler ws a-key) 
  (cond
    [(key=? a-key " ") (make-ws GREEN 0)]
    [else ws]))



(define init-ws (make-ws RED 0))

(big-bang init-ws
 (to-draw draw) ; for drawing
 (on-key key-handler) ; to respond to key press
 (on-tick tock 1)) ; every clock tick