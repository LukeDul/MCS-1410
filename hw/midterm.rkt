;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname midterm) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#| Luke Dulworth MCS-1410 Midterm 
For the Midterm you are required to work entirely alone, except that you may ask Dr. Hochberg or Dr. Chastain for help.

There are no restrictions as to what built-in functions you may use for these questions unless explicitly stated.

You must write function contracts and one-line descriptions for each of the functions that you write.
|#


;1. Product

; a and b are numbers. You should define Problem1 to be their product.
; Note: You will not be writing a function for this problem.
(define a 1 )
(define b 1 )

(define Problem1 (* a b))


; 2. Perimeter

; a and b are numbers, the sides of a rectangle. 
; You should define Problem2 to be the perimeter of the rectangle with width a and height b.
; Note: You will not be writing a function for this problem.

(define Problem2 (* 2 (+ a b)))


; 3. Both Numbers Even?

; a and b are Numbers.
; Create an expression that produces #true (or #t) if they are both even,
; otherwise #false (or #f). Define Problem3 to be that Boolean value.
; Note: You will not be writing a function for this problem.

(define Problem3
  (cond
    [(and (even? a) (even? b)) #t]
    [else #f]))


; 4. Distance from (1, 2)

; P is a posn. Your expression should produce its distance from the point (1, 2).
; Define Problem4 to be that value. 
; Note: You will not be writing a function for this problem.
(define P (make-posn (random 1 100) (random 1 100)))

; distance = sqrt (x-x1^2 +y-y1^2)

(define Problem4
  (local
    [(define A (- (posn-x P) 1))
     (define B (- (posn-y P) 2))]
    (sqrt (+ (sqr A) (sqr B)))))
    


; 5. x^2 + x + 1

; Write a function called my-poly that consumes a number, x,
; and produces the value of x^2 + x + 1

(define (my-poly x)
  (+ 1 x (sqr x)))


;6. Left or Right

; Write a function that takes two posn as input, and tells whether the first is left or right of the second,
; or neither. Here are some sample check-expects.

(define (left-or-right P1 P2)
  (local
    [(define x1 (posn-x P1))
     (define x2 (posn-x P2))]
  (cond
    [(> x1 x2) "Right"]
    [(< x1 x2) "Left"]
    [else "Neither"])))

; (check-expect (left-or-right (make-posn 1 2) (make-posn 3 4)) "Left")
; (check-expect (left-or-right (make-posn 5 2) (make-posn 3 4)) "Right")
;(check-expect (left-or-right (make-posn 3 2) (make-posn 3 4)) "Neither")



; 7. All Equal?

; Write a function called all-equal that takes three numbers as input,
; and produces "All Equal" if they are all equal, or "Not All Equal" if not.

(define (all-equal a b c)
  (if (= a b c) "All Equal" "Not All Equal"))
      

  

; 8. Clicked in a Square

; We define a SQ structure to hold a square:

; SQ is a structure to hold square
; tl is a Posn, giving the top-left corner of the square
; side is a Number, giving the side length of the square

(define-struct SQ (tl side))

; You should write a function, point-in-square, that tells whether a given posn P is inside a given square S.
; A click on the boundary should count as inside the square. Here are some check-expects:

(define (point-in-square? P S)
  (local
    [(define min-x (posn-x (SQ-tl S)))
     (define min-y (posn-y (SQ-tl S)))
     (define max-x (+ min-x (SQ-side S)))
     (define max-y (+ min-y (SQ-side S)))
     (define x (posn-x P))
     (define y (posn-y P))]
    (if (and (>= x min-x) (<= x max-x)
             (>= y min-y) (<= y max-y))
        #true
        #false)))
  

(define sq1 (make-SQ (make-posn 0 0) 50))
(check-expect (point-in-square? (make-posn 20 20) sq1) #true)
(check-expect (point-in-square? (make-posn 20 50) sq1) #true)
(check-expect (point-in-square? (make-posn 60 50) sq1) #false)
(check-expect (point-in-square? (make-posn 60 3) sq1) #false)
(check-expect (point-in-square? (make-posn -1 -1) sq1) #false)




;9. All Equal in a List of Numbers

;Write a function called list-all-equal that takes a non-empty list of numbers, and returns #true if they all have the same value, and #false otherwise.



(define (list-all-equal lon)
  (cond
    [(empty? lon) #true]
    [(empty? (rest lon)) #true]
    [(= (first lon) (first (rest lon))) (list-all-equal (rest lon))]
    [else #false]))
  



(define (equal-helper lon all-equal?)
  (if all-equal? 
    (cond
      [(empty? lon) 0]
      [else (if (= (first lon) (equal-helper (rest lon) all) #true #false))]
    #false )))


;10. Non-decreasing List

; Write a function called increasing? that decides whether each number in a list is at least as big as the number before it. It should return #true or #false.

; You may assume that the list contains at least one number. And if the list has exactly one number, then it should return #true.

 #|
11. Bridgely

A list of numbers is called "bridgely" if it contains at least 3 numbers, and every number in the list, except for the first and the last, is greater than both the first and the last number.

Thus, these lists are bridgely:
(list 1 2 3 4 5 6 5 4 3 2 1)
(list 0 4 4 4 4 4 2)

And these are not:
(list 1 2 3 4 5)
(list 1 1 2 3 4 3 2 1)

Write a bridgely? function that takes a list of at least 3 numbers and returns #true if it is bridgely, otherwise #false.
|#





; 12. Binary Necklace

;Write a function called binary-necklace that takes a list of numbers, all 0 or 1, and produces a necklace representing the list.

;0's should produce 'DarkBlue beads of size 10, and 1's should produce 'Gold beads of size 7.
;These beads should be strung together into a necklace, as shown below for the list (list 0 1 1 0 1 0 0 1).

  |#

;List of Numbers -> Boolean
; Takes a List of Numbers, lon, and produces #true if all the elements in the list are equal otherwise produces #false.
    

(define (binary-necklace lon)
  (local
    [(define blue-bead (circle 10 'solid 'darkblue))
     (define gold-bead (circle 7 'solid 'gold))]
    (cond
      [(empty? lon) empty-image]
      [(= (first lon) 1) (beside blue-bead (binary-necklace (rest lon)))]
      [(= (first lon) 0) (beside gold-bead (binary-necklace (rest lon)))])))


;13. Keep the Short Words

;Write a function called short-words that takes as input a list of strings, and produces a new list containing only those words in the input list that had 4 or fewer characters.


; List of Strings -> List of Strings
; Takes a List of Strings, los, and produces a new list containing only the strings in the input list that had 4 or fewer characters.
(define (short-words los)
  (cond
    [(empty? los) empty]
    [(<= (string-length (first los)) 4) (cons (first los) (short-words (rest los)))]
    [else (short-words (rest los ))]))


(check-expect
   (short-words (list "Whenever" "my" "awesome" "mind" "is" "challenged" "creativity" "defeats" "numb" "defeatism"))
                (list "my" "mind" "is" "numb"))



; 14. Moving Lasers

; Write a function, move-lasers, that takes as input a list of posns,
; and produces a new list of posns consisting of all of the posns in the input list moved 5 pixels to the right.
; But any laser that has gone off screen after being moved should not be in the list. The screen has width 200.

; List of Posns -> List of Posns
; Given a List of Posns, lop, produces a new list containing the same Posns with their X values increased by 5.
; If the increased X value is greater than 200 that Posn is not included in the new list. 
(define (move-lasers lop)
  (cond
    [(empty? lop) empty] 
    [else
     (local
       [(define x (posn-x (first lop)))
        (define y (posn-y (first lop)))]
     (if (> (+ x 5) 200)
         (move-lasers (rest lop))
         (cons (make-posn (+ x 5) y) (move-lasers (rest lop)))))]))


(check-expect
  (move-lasers
    (list (make-posn 10 10) (make-posn 20 20) (make-posn 100 100)
          (make-posn 195 195) (make-posn 198 198)))
    (list (make-posn 15 10) (make-posn 25 20) (make-posn 105 100)
          (make-posn 200 195)))



#| 15. Fractal

Write a function called frac that takes a number n as input, and produces the nth stage of the fractal. Note that the smallest square, when n = 0, has side 5.

Here is a sequence of images formed by calling (build-list 6 frac).  |#


; Number -> Image
; Given a Number, depth, produces an image of the given depth of a fractal
(define (frac depth)
  (cond
    [(zero? depth) (square 5 'solid 'white)]
    [else
     (local
      [(define r (frac (- depth 1)))]
       (beside/align "center"   (above r r) (flip-horizontal r)))]))
 

