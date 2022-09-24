;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname in-class-220912) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; Define world-state
; world-state is a number
; gives the distance of the center of the paddle from the top of the screen

; Global variables (capital by convention)

(define WIDTH 800)

(define HEIGHT 400)

(define BOARD_COLOR 'green)

(define PADDLE_COLOR 'black)


; Worldstate -> Image
; ws is the worldstate
(define (draw ws) (place-image (rectangle 10 25 'solid PADDLE_COLOR) (- WIDTH 30) ws
                               (overlay (rectangle 10 HEIGHT 'solid 'white)
                                        (rectangle WIDTH HEIGHT 'solid BOARD_COLOR))))

; WorldState, Number, Number, Mouse-Event -> WorldState
(define (move ws x y evt) y)

(define initial-ws (/ HEIGHT 2)) ; middle of the height

(big-bang initial-ws
  (to-draw draw) ; for drawing
  (on-mouse move)) ; to respond to mouse movement