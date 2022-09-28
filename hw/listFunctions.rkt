;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname listFunctions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Write a function my-list-count that takes a list of size 0, 1, 2 or 3, and produces the length of the list.

; Each time it tests if the list is empty
;   if empty it returns zero
;   if not empty it adds 1 and trys again 
;   if empty within the recursion it adds zero and exits (because it does not call itself again)
; Given: '( '1 '2 '3 '4 '5) Output: 5
; Recursion Visualization: 1 + (1 + (1 + ( 1 + (1 + 0))))

; List -> Number
; Produces the number of items in the list l
; The list is guaranteed to have size 0, 1, 2 or 3
(define (my-list-count l)
  (cond
    [(empty? l) 0]
    [else (+ 1 (my-list-count (rest l)))] ; f of rest of l (recursive functions call themselves on smaller and smaller inputs. 
    ))

; Write a function my-list-sum that consumes a list of size 1, 2 or 3, and produces the sum of the elements of the list.

; List of Numbers -> Number
; Produces the sum of the numbers in a list.
; The list is guaranteed to have size 1, 2 or 3

(define (my-list-sum lon)
  (cond
    [(empty? lon) 0]
    [else (+ (first lon) (my-list-sum (rest lon)))]
    ))

; Each time it tests if the list is empty
;   if empty it returns zero
;   if not empty it adds the first item and trys again 
;   if empty within the recursion it adds zero and exits (because it does not call itself again)
; Given: '(1 2 3 4 5) Output: 15
; Recursion Visualization: 1 + (2 + (3 + ( 4 + (5 + 0))))

; Write a function my-list-odd that consumes a list of size 0, 1, 2 or 3, and produces the number of odd numbers in that list.

; List of Numbers -> Number
; Produces the number of odd items in a list lon of numbers
; The list is guaranteed to have size 0, 1, 2 or 3.

(define (my-list-odd lon)
  (cond
   [(> (my-list-count lon) 4) "Error: only takes lists of size 0, 1, 2 or 3"]
   [(empty? lon) 0]
   [(odd? (first lon)) (+ 1 (my-list-odd (rest lon)))]
   [else (+ 0 (my-list-odd (rest lon)))]
   ))

(define (my-list-odd lon)
  (cond
    []))

; Write a function my-list-odd that consumes a list of any size, and produces the number of odd numbers in that list.

; List of Numbers -> Number
; Produces the number of odd items in a list lon of numbers
(define (my-any-list-odd lon)
  (cond
   [(empty? lon) 0]
   [(odd? (first lon)) (+ 1 (my-any-list-odd (rest lon)))]
   [else (+ 0 (my-any-list-odd (rest lon)))]
   ))


; Number, Number -> List 
; Given two numbers produce a list that contains all integers between those two numbers

;(define (builder min)(append (list min)
          ;(builder (list (add1 (first min))))))