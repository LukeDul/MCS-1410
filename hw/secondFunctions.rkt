;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname secondFunctions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Number -> Number
; takes a number and outputs its square root. 
(define (my-square-root n) (sqrt n))


; Number, Number -> Number
; takes two parameters, a and b,
; and produces the length of the hypotenuse of a right
; triangle that has sides lengths a and b
(define (hypotenuse a b)
  (sqrt
   (+
    (expt a 2)
    (expt b 2))))

 
; Number -> Number 
; Consumes a number r and produces the volume of a sphere with radius r
(define (volume r) (* (/ 4 3) pi (expt r 3)))


; Number, Number -> Number 
; consumes two numbers, h hours and m minutes, and outputs the corresponding 
; total number of minutes
(define (hours-to-minutes h m) (+ m (* h 60)))


; Number, Number, Number, Number, Number, Number -> Number 
; Consumes six numbers (a, b, c, x, y, z),
; and produces the distance from the point (a,b,c) to the point (x,y,z)
(define (distance a b c x y z)
  (sqrt (+ (expt (- x a) 2) (expt (- y b) 2) (expt (- z c) 2))))


; Number, Number -> Number
; Consumes two numbers, 
; and produces the number that is farther away from 10
(define (farther n t)
        (cond [(> (abs (- 10 n)) (abs(- 10 t))) n]
              [else t]))


; Number, Number, Number, Number -> Number 
; Consumes four numbers, where each number is either 0 or 1,
; and produces another number that is either 0 or 1.
; Given 0 1 1 0 Output: 0
; Given 0 0 1 0 Output: 1
; Given 1 0 1 1 Output: 1 
(define (parity a b c d)
        (if ( = (modulo (+ a b c d) 2) 0) 0 1))


; Number, String, String -> Image 
; Consumes 3 parameters: a number, and two strings and produce two circles and a triangle
; beside each other in a horizontal line. 
(define (shapes n str1 str2)
  (beside (circle (/ n 2) 'solid str1)
          (triangle n 'solid str2)
          (circle (/ n 2) 'solid str1)))


; Number, String, String -> Image 
; Consumes three parameters:
; width, a number telling how wide the house should be, and
; roof-color, a string telling what color the roof should be, and
; wall-color, a string telling what color the wall should be and produces an image of a house. 
(define (house width roof-color wall-color)
  (above (triangle width 'solid roof-color)(square width 'solid wall-color)))


; String -> Boolean
; Consumes a string, str, and outputs whether its length is greater than 10 as a boolean
(define (>10? str) (> (string-length str) 10))


; String, String, String, String, String -> String
; takes in a sentence (five separate strings) and outputs one of:
;   •    outrageously pretentious
;   •    pretentious
;   •    acceptable
; according to the lengths of the words in the sentence.
(define (pretentiousness-detector a b c d e)
  (cond [(and (>10? a) (>10? b) (>10? c) (>10? d) (>10? e)) "outrageously pretentious"]
      [(or (>10? a) (>10? b) (>10? c) (>10? d) (>10? e)) "pretentious"]
      [else "acceptable" ]))