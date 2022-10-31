;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname asteroid-game) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct asteroid [shape x y hitbox-radius])

(define-struct ship [shape x y heading])

(define-struct world-state [ship asteroid-list])

(define (tock world-state))

(define (draw world-state))

(define (keyboard-handler world-state))

(define initial-world-state
  (local
    [(define initial-x 0)
     (define initial-y 0)
     (define initial-heading 0)]
     (make-world-state (make-ship initial-x initial-y initial-heading)
                       (list empty)))) ; no asteroids 


(big-bang initial-world-state
 (to-draw draw) ; for drawing
 (on-key keyboard-handler) ; to respond to key press
 (on-tick tock) ; every clock tick
 (name "asteroids")
 (stop-when gameover)
 (state #f)) ; #t for debugging worldState )