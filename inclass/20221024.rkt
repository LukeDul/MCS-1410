;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |20221024|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|

λ lambdas

consider using lambdas when using higher order functions (map, fold etc.)
or single use functions

a function as an argument is basically a combination of functions

fold l is much faster than fold r x 
|#

(define (quadruple x) (* x 4))

(map (λ (x) (* x 4)) '(1 2 3))
; vs.
(map quad '(1 2 3))
