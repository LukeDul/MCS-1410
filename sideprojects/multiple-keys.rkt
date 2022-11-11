;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname multiple-keys) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct keyboard [a s])

(define (tock struct)
    (local [(define a (keyboard-a struct))
            (define s (keyboard-s struct))]
      (make-keyboard a s)))
      
(define (key-handler struct input-key)
  (local [(define a (keyboard-a struct))
          (define s (keyboard-s struct))]
    
    (cond [(key=? input-key "a") (make-keyboard #true s)]
          [(key=? input-key "s") (make-keyboard a #true )])))

(define (release-handler struct input-key)
  (local [(define a (keyboard-a struct))
          (define s (keyboard-s struct))]
    
    (cond [(key=? input-key "a") (make-keyboard #f s)]
          [(key=? input-key "s") (make-keyboard a #f )])))

(define (draw struct) (square 100 'solid 'red ))

(define initial-keyboard (make-keyboard #f #f))

(big-bang initial-keyboard
  (state #t)
  (on-tick tock 0.1) 
  (to-draw draw)
  (on-key key-handler)
  (on-release release-handler))