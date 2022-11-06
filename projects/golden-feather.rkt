;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname golden-feather) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; madeline is the playable character
; the heading is in degrees, 0-360
; x & y determine madeline's position 
(define-struct madeline (heading x y))

(define velocity 1)





; the canvas upon which everything will be drawn  
(define canvas
  (local
    [(define width 500)
     (define height 500)
     (define background-color "white")
     (define transparency "solid")]
    (rectangle width height transparency background-color)))

; Number -> Number
; Given a number returns 0 if the number is 360, otherwise returns the number.
(define (zero-heading num)
  (if (= num 360) 0 num))


; Structure -> Structure
; Changes the HEADING of madeline based upon WASD. 
; Given a madeline structure, makes a new madeline structure with its heading, madeline-heading, mutated based upon which key was pressed. 
(define (key-handler structure a-key)
  (local
    [(define heading (zero-heading (madeline-heading structure))) ; ensures the heading does not get incremented above 360
     (define x (madeline-x structure))
     (define y (madeline-y structure))]
    
    (cond
      [(key=? a-key "a") (make-madeline
                          (- heading 5) ; angles madeline to the left 
                          x
                          y)] 
      [(key=? a-key "d") (make-madeline
                          (+ heading 5) ; angles madeline to the right 
                          x
                          y)]))) 


; Structure -> Structure
; Changes the position of madeline based upon her heading.  
(define (tock structure)
  (local
    [(define heading (zero-heading (madeline-heading structure)))
     (define x (madeline-x structure))
     (define y (madeline-y structure))]
    
    (cond
      [(= heading 0) (make-madeline heading x (- y velocity))]
      [(= heading 90) (make-madeline heading (- x velocity) y)]
      [(= heading 180) (make-madeline heading x (+ y velocity))]
      [(= heading 270) (make-madeline heading (+ x velocity) y)]
      
      [(and (> heading 0) (< heading 90)) (make-madeline heading (+ x velocity) (+ velocity y))] ; Quadrant I
      [(and (> heading 270) (< heading 360)) (make-madeline heading (- x velocity) (+ velocity y))] ; Quadrant II
      [(and (> heading 180) (< heading 270)) (make-madeline heading (- x velocity) (- velocity y))] ; Quadrant III
      [(and (> heading 90) (< heading 180)) (make-madeline heading (+ x velocity) (- velocity y))]))) ; Quadrant IV

(define (draw structure)
  (local
    [(define heading (madeline-heading structure))
     (define x (madeline-x structure))
     (define y (madeline-y structure))]
    
    (place-image (circle 10 'solid 'green) x y canvas)))
    
; defines the starting state of the world 
(define initial-world-state
  (local
    [(define initial-x 250)
     (define initial-y 250)
     (define initial-heading 0)] ; a heading of zero means the madeline is pointing straight forward
    (make-madeline initial-heading initial-x initial-y)))

(big-bang initial-world-state
  (on-tick tock)
  (to-draw draw)
  (state #t)
  (on-key key-handler))
                            