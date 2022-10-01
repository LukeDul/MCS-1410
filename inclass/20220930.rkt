;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |20220930|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#| in class notes 30 September 2022

for first list functions due monday at midnight 

only use first rest and empty?

cannot use map or other list functions


recursion with lists trick

f(l) = g (h (first), f(rest))

FUNCTIONS THAT CREATE LISTS
(triple empty) 
(triple l)
(cons (cons (rest (triple l) empty)

|#

; List -> List
; Triple each element of the inputted list and output it as a new list. 
(define (triple l)
  (cond
    [(empty? l) empty] ; base case 
    [else (cons (* 3 (first l)) (cons (triple (rest l)) empty))]
    ))

#|

|#
