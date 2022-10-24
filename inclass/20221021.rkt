;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |20221021|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Higher Order Functions

map, filter, foldr, foldl

anytime you have a comparison or a binary operation(+,-)
map and filter will not work for these because they only take one argument

foldr

replace (cons with f
replace empty with initial value


anonymous functions

(map (lambda (y) (* y y y) 1)

|#


(define (sum-list lst) (foldr + 0 lst))

(define (all-equal-to-num num lst)
  (cond
    [(odd? (length lst))
     (= (foldr - num lst) 0)]
    [else
     (= (foldr - num lst) num)]))



