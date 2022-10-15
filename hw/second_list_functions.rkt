;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname second_list_functions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 1. Sum of the Odd Numbers in a List of Numbers

; List of Numbers -> Number
; Produces the sum of the odd numbers in a list. 0 if the list is empty.
(define (my-list-sum lon)
  (cond
    [(empty? lon) 0]
    [(odd? (first lon)) (+ (first lon) (my-list-sum(rest lon)))]
    [else (+ 0 (my-list-sum(rest lon)))]))
    


; 2. Number of Items greater than 5

; List -> Number
; Produces the number of items in the list lon that are greater than 5
(define (my-list-count lon)
  (cond
    [(empty? lon) 0]
    [(> (first lon) 5) (+ 1 (my-list-count (rest lon)))]
    [else (+ 0 (my-list-count (rest lon)))]))



; 3. Just the Odd Items

; List of Numbers -> List of Numbers
; Produces a new list with just the odd items in a list l of numbers
(define (my-list-odd lon)
  (cond
    [(empty? lon) empty]
    [(odd? (first lon)) (cons (first lon) (my-list-odd(rest lon)))]
    [else (my-list-odd(rest lon))]))



; 4. Concatenate a List of Strings

; You are given a list of strings, and you want to combine them into a single string.
; Write the function "concatn8" to do this. For example, given the list:

; los = ["now" "I" "am" "happy"]

;(concat los) would produce "nowIamhappy."

; List of Strings -> String
; Concatenates the strings in los into a single string.
(define (concatn8 los)
  (cond
    [(empty? los) ""]
    [else (string-append (first los) (concatn8(rest los)))]))

#|
5. Every Third Letter

; List of Letters -> String
; Concatenates the letters to make the string, but only every third letter!
(define (every-third lol) ... )

;(check-expect (every-third (list "f" "u" "n")) "f")
;(check-expect (every-third (list "f" "l" "u" "e" "n" "t")) "fe")
;(check-expect (every-third (list "f" "i" "g" "u" "r" "i" "n" "e")) "fun")
;(check-expect (every-third (list "d" "y" "n" "a" "s" "t" "y")) "day")
;(check-expect (every-third empty) "")

6. First Number, First String

Write a function fnfs that takes as input a list containing at least one number and at least one string and produces a list of two items. The first item in the list should be the first number, and the second item in the list should be the first string. Below are some sample check-expects:

; List -> List 
(define (fnfs l) .. )
(check-expect (fnfs (list 1 "a")) (list 1 "a"))
(check-expect (fnfs (list "a" 1)) (list 1 "a"))
(check-expect (fnfs (list 1 2 3 4 5 "a" "b")) (list 1 "a"))
(check-expect (fnfs (list "a" "b" "c" "d" "e" 1 2 3 4 5)) (list 1 "a"))
(check-expect (fnfs (list "a" 1 "b" 4 "c" 7 "d" "e" 1 2 "x" 3 "y" 4 5)) (list 1 "a"))

7. Highest Point

; List of Posn -> Posn
; Returns the highest posn from a list of posn of size at least 1
; (Highest means that it's y-coordinate is least.)
(define (highest lop)
   ...)
;(check-expect (highest (list (make-posn 1 2)
;                             (make-posn 5 6)
;                             (make-posn 0 1)
;                             (make-posn 3 4))) (make-posn 0 1))

8. Squarify

Example:

(squarify (list 10 30 50 20 40))



; List of Number -> Image
; produces a sequence of squares whose sizes are given by the list
; The list may be empty, in which case it should return an empty-scene
; of size 0x0:  (empty-scene 0 0)   (This is built-in to DrRacket.)

(define (squarify lon)
  ...)

;(check-expect (squarify (list 10 30 50 20 40))
;              (beside (square 10 'solid 'blue) (square 30 'solid 'blue)
;                      (square 50 'solid 'blue) (square 20 'solid 'blue)
;                      (square 40 'solid 'blue))

9. Bar Graph

Example:

(bar-graph (list 10 30 50 20 40))



; List of Number -> Image
; produces a visual representation of the numbers in a sort of bar graph
; use "beside/align" with the "bottom" option.
(define (bar-graph lon)
  ...)
;(check-expect (bar-graph (list 70 50 30 10 20 40 60))
;               (beside/align "bottom" (rectangle 10 70 'solid 'red)
;                             (rectangle 10 50 'solid 'red)
;                             (rectangle 10 30 'solid 'red)
;                             (rectangle 10 10 'solid 'red)
;                             (rectangle 10 20 'solid 'red)
;                             (rectangle 10 40 'solid 'red)
;                             (rectangle 10 60 'solid 'red)))
|#