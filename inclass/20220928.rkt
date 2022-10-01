;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |220928|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#| in class | 28 September 2022

A list is either:
1. empty 
2. (cons item list)  

L = [A Y Y Y Y]

(first L) = A
(rest L) = '(Y Y Y Y)

Recursion from a Different Perspective

Subproblems and division of labor

Subproblems are components that need to be combined to produce the solution of a Problem

Delay solving a problem P until you solve a smaller, nested problem within P.

Football play:
Get the ball as close to the other end of the field as possible.

QuarterBack ---> Wide Reciever

RULES FOR DESIGNING A RECURSIVE FUNCTION

 1. recursive call must be on a smaller subproblem : (length l = (1 + (length rest of l))
 2. the smallest subproblem must be solved manually so that it does recurse eternally : length is empty

length of l
 |
 v
length of rest of l
 |
 v
length of rest of rest of l
 |
 .
 .
 .
 v
length of empty

[ 3 1 4 1 5 ] --> [ 0 1 8 3 20] ie multiply by index

subproblem: apply problem to the rest

[ 3 1 4 ] --double--> [ 6 2 8 ]

(cons

subproblem: apply problem to first 

subproblem: apply problem to rest)

the alternative to recursion is map and an anonymous function lambda λ

|#

(define (double lon)
  (cond
   [(empty? (first lon)) lon]
   [else (cons (first lon) (double (rest lon)))])) ; not working

