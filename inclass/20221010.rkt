;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |20221010|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Next assignment due next monday
we can use List

given list of posns

local variables (+ functions (discouraged)



(local [(define...)
        (define...)
        (define...)
        (define...)]
  expression) ; this expression may make use of the variables (and functions)
              ; defined in the local block.


Local variables can make code more readable.

(every lang has these concepts)

Global Table of Defined Values
   Variable | Value
       P    | "---"
   Function | Definition

Every function also has a table of defined variables

Local Table of Defined Values
   Variable | Value
       P    | "---"
   Function | Definition

When looking for a variable every language checks the local list of defined values
then the global list of defined values.

They are not always aesthetic but critical.

gives time of funvgion
(time function)

IMPORTANT 
every pair of matching parenthesis has a value
always be able to answer this when writing code
ex: the value of a cond is the val next to the first true test

|#


(define (distance P Q)
  (local [(define a (posn-x P))
          (define b (posn-y P))
          (define c (posn-x Q))
          (define d (posn-y Q))
          (define dx ( - c a))
          (define dy (- d b))]
    (sqrt (+ (sqr dx) (sqr dy)))))

(check-expect (distance (make-posn 0 0) (make-posn 5 12)) 13)


; List of Numbers -> Number
; Produce the max element of lon
; O(n) = 2^n
(define (my-max lon)
  (cond
    [(= (length lon) 1) (first lon)]
    [ (> (first lon) (my-max (rest lon))) (first lon) ]
    [else (my-max (rest lon))]))

(check-expect (my-max (list 1 2 3 4 5 6 7 8 9)) 9)

; this is bad because you call my-max twice so its 2^n each element doubles the run time 
; you cannot have two recursive function calls without being in danger


; O(n) = 30
; Using
(define (mymaxl lon)
  (if (= (length lon) 1)
      (first lon)
      (local [(define m (mymaxl (rest lon)))]
        (if (> (first lon) m)
            (first lon)
            m))))
            


