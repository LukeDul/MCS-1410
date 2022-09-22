;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname listFunctions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Luke Dulworth
; List Functions Homework

; 1. Number of Items in a Small List

; Write a function my-list-count that takes a list of size 0, 1, 2 or 3, and produces the length of the list.

; List -> Number
; Produces the number of items in the list l
; The list is guaranteed to have size 0, 1, 2 or 3

(define (my-list-count l)  (length l))

; 2. Sum of a Small List of Numbers

; Write a function my-list-sum that consumes a list of size 1, 2 or 3, and produces the sum of the elements of the list.

; List of Numbers -> Number
; Produces the sum of the numbers in a list.
; The list is guaranteed to have size 1, 2 or 3

(define (my-list-sum lon) (+ (list-ref lon 0) (list-ref lon 1) (list-ref lon 2)))

; 3. Number of Odd Items in a Small List

; Write a function my-list-odd that consumes a list of size 0, 1, 2 or 3, and produces the number of odd numbers in that list.

; List of Numbers -> Number
; Produces the number of odd items in a list lon of numbers
; The list is guaranteed to have size 0, 1, 2 or 3.


(define (my-list-odd lon) (length (filter odd? lon)))


; 4. Number of Odd Items in any list

; Write a function my-list-odd that consumes a list of any size, and produces the number of odd numbers in that list.

; List of Numbers -> Number
; Produces the number of odd items in a list lon of numbers

(define (my-list-odd2 lon) (length (filter odd? lon)))



; List -> Boolean
; outputs #true if l is an empty list, and outputs #false if it is not an empty list. 
;   l - list which we are testing for being empty or not

;(define (empty? l) (if (eq? l empty) #true #false))