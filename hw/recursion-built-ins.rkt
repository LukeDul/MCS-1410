;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname recursion-built-ins) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Hello Intro CS students,  below I describe the latest homework assignment.  

Please submit on Gradescope (though we might change this).

|#



; Write one-liners for the following functions, using
; map, filter, foldl, foldr and/or lambda.
; Other helpful functions: sqr, even?, odd?, empty?, cons?



; The lists l and m are defined here to use in the check-expects below
(define l (list 10 20 30 40 50 60 70 80))
(define m (list 1 2 3 4))
(define imlist (list (square 10 'outline 'purple) (triangle 50 'solid 'magenta)
(circle 25 'solid 'black) (star 44 'outline 'green)))



; Problem 1: List of Squares

; Creates a list of squares whose sides are 10 times the numbers in the list
(require 2htdp/image)



; List of Numbers -> List of Images
; Given a list of numbers, lon, produces a list of squares with a size ten times each element in the list 
(define (blue-squares lon) (map (lambda (element) (square (* element 10) 'solid 'blue)) lon))
  
(check-expect (blue-squares m)
              (list (square 10 'solid 'blue) (square 20 'solid 'blue)
                   (square 30 'solid 'blue) (square 40 'solid 'blue)))



; Problem 2: Sum of Odd Numbers

; Computes the sum of the odd numbers in a list, using filter and fold. No need for a lambda.

; List of Numbers -> Number
; Given a list of numbers, lon, produces the sum of all the odd numbers in lon
(define (sod lon) (foldl + 0 (filter odd? lon)))
                   
(check-expect (sod l) 0)
(check-expect (sod m) 4)



; Problem 3: Sum of Square of Odds

; Computes the sum of the squares of the odd numbers in a list, using map, filter and fold. 

; List of Numbers -> Number
; Given a list of numbers, lon, produces the sum of the squares of all the odd numbers in lon.
(define (soos lon) (foldl + 0 (map sqr (filter odd? lon))))

(check-expect (soos l) 0)
(check-expect (soos m) 10)



; Problem 4: Round up Odd

; Adds one to each odd number, leaves even numbers unchanged. This should use a lambda.

; List of Numbers -> List of Numbers
; Given a list of numbers, lon, produces a list of numbers with 1 added to each odd number in lon. 
(define (rod lon) (map (lambda (element) (if (odd? element) (+ 1 element) element)) lon))

(check-expect (rod l) l)
(check-expect (rod m) (list 2 2 4 4))



; Problem 5: Sum of Posns
; Use a lambda, with map, filter and/or fold, to produce the sum of a 
; list of posns. (See the check-expect)

; List of Posns -> Posn
; Given a list of posns, lop, produces a posn containing the sum of all the posns in lop. 
(define (sum-lop lop) (foldl (lambda (posn1 posn2) (make-posn (+ (posn-x posn1) (posn-x posn2)) (+ (posn-y posn1) (posn-y posn2)))) (make-posn 0 0) lop))

(check-expect (sum-lop (list (make-posn 1 2) (make-posn 3 4) (make-posn 5 6))) (make-posn 9 12))


; Problem 6: Align the Posns

; Given a list of Posns, modify them all so that their y-coordinates all become 17.

; List of Posns -> List of Posns
; Given a list of posns, lop, produces lop with all y-coordinates changed to 17.
(define (y17 lop) (map (lambda (position) (make-posn (posn-x position) 17)) lop))
 (check-expect (y17 (list (make-posn 1 2) (make-posn 3 4)))
               (list (make-posn 1 17) (make-posn 3 17)))



; Problem 7: Sum of Rectangle Areas
; Produce the sum of all the areas of 
; the rectangles in list loR.

(require 2htdp/image)

; List of Images -> Number
; Given a list of rectangles loR, produces the area of all the rectangles. 
(define (sum-recA loR) (foldl + 0 (map (lambda (element) (* (image-width element) (image-height element))) loR)))

(check-expect (sum-recA (list (rectangle 10 10 'solid 'red)
                              (rectangle 20 30 'solid 'blue)
                              (rectangle 30 30 'outline 'green))) 1600)


#|

Problem 8: Circles Inscribed in Squares

Given a list of lightblue squares, generate a single image that consists of those squares with red outline circles inscribed inside them.

Please use overlay to put the circles atop the squares.

Here is an example of before and after:


(require 2htdp/image)
(define (inscribeC loS) ...)
(check-expect (inscribeC (list (square 30 'solid 'lightblue)
                               (square 50 'solid 'lightblue)
                               (square 40 'solid 'lightblue)))
              (beside (overlay (circle 15 'outline 'red) (square 30 'solid 'lightblue))
                      (overlay (circle 25 'outline 'red) (square 50 'solid 'lightblue))
                      (overlay (circle 20 'outline 'red) (square 40 'solid 'lightblue))))

;Problem 9: Sum of Red Areas

; You are given a list of red squares with blue circles inscribed within them. Your job is to write a function that will produce the sum of the red areas.

; Example List:



(require 2htdp/image)
(define (sumRedA loi) ...)
(check-within (sumRedA (list (overlay (circle 20 'solid 'red) (square 40 'solid 'blue))
                             (overlay (circle 25 'solid 'red) (square 50 'solid 'blue))
                             (overlay (circle 10 'solid 'red) (square 20 'solid 'blue)))) 965.708 0.001)

; Problem 10: Number of Squares <50

; Given a list of square images, produce the number 
; of those images with a side length less than 50.
(require 2htdp/image)
(define (<50 loS) ...)

; Problem 11: Sum of Red Areas 2

; Example List:



; Given a list loi, which is a list of square images similar to the list in the 
; description, produce the sum of the areas of the red sections.
(require 2htdp/image)
(define (sumRedA2 loi) ...)

; Problem 12: Number Clicked

; Given a list of ball structures and a mouse-click location (x, y), 
; return the number of balls that were clicked on.

; Size is the radius of the ball
; (px, py) is the center of the ball
(define-struct ball (size px py))

(define (numClicked x y lob) ...)

; Number, Number, Number, Number -> Number
; Distance function. Use if you wish.
(define (distance a b c d) (sqrt (+ (sqr (- c a)) (sqr (- d b)))))

|#
