;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname fibonacci) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 0 1 1 2 3 5 8 13

; find nth number in fibonacci sequence

(define (fib n)
  (cond [(= n 0) 1]
        [(= n 1) 1]
        [(= n 2) 1]
        [else (+ (fib (sub1 n)) ( fib (- n 2)))]))

; takes too long, an exponential amount of time.

 (time (fib 25))