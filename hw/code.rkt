;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname code) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;1. Product

; Produces the product of two numbers
(define Problem1 (* a b))

; 2. Perimeter

; Produces the perimeter of rectangle 
(define Problem2 (* 2 (+ a b)))

; 3. Both Numbers Even?

; Determines if two numbers are both even 
(define Problem3
  (cond
    [(and (even? a) (even? b)) #t]
    [else #f]))

; 4. Distance from (1, 2)

; Calculates the distance from the point (1, 2)
(define Problem4
  (local
    [(define A (- (posn-x P) 1))
     (define B (- (posn-y P) 2))]
    (sqrt (+ (sqr A) (sqr B)))))

; 5. x^2 + x + 1

; Evaluates a polynomial
(define (my-poly x)
  (+ 1 x (sqr x)))


;6. Left or Right

; Posn, Posn -> String
; Takes two Posns and produces whether the first is left or right of the second, or neither.
(define (left-or-right P1 P2)
  (local
    [(define x1 (posn-x P1))
     (define x2 (posn-x P2))]
  (cond
    [(> x1 x2) "Right"]
    [(< x1 x2) "Left"]
    [else "Neither"])))


; 7. All Equal?

; Number, Number, Number -> String
; Takes three numbers as input, and produces "All Equal" if they are all equal, or "Not All Equal" if not.
(define (all-equal a b c)
  (if (= a b c) "All Equal" "Not All Equal"))


; 8. Clicked in a Square

; Structure, Posn -> Boolean
; Takes a Posn, P, and a Structure, S, and returns #true if the Posn is within the coordinates of the S, #false otherwise. 
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


;9. All Equal in a List of Numbers

; List of Numbers -> Boolean
; Takes a non-empty list of numbers, lon, and returns #true if they all have the same value, and #false otherwise.
(define (list-all-equal lon)
  (cond
    [(empty? lon) #true]
    [(empty? (rest lon)) #true]
    [(= (first lon) (first (rest lon))) (list-all-equal (rest lon))]
    [else #false]))



;10. Non-decreasing List

; List of Numbers -> Boolean
; Takes a non-empty list of numbers, lon, and returns #true if each number in the list is at least as big as the number before it, and #false otherwise.
(define (increasing? lon)
  (cond
    [(empty? lon) #true]
    [(empty? (rest lon)) #true]
    [(>=  (first (rest lon)) (first lon)) (increasing? (rest lon))]
    [else #false]))


; List -> List
; Takes a List, lst, and and produces a new list identical the the given list but without the last element. 
(define (last-element-remover lst)
  (cond
    [(empty? lst) empty]
    [(empty? (rest lst)) (last-element-remover (rest lst)) ]
    [else (cons (first lst) (last-element-remover (rest lst)))]))


; List of Numbers, Number -> Boolean
; Takes a list of numbers, lon, and a number, n, and produces #true if n is greater than each element in lon, otherwise #false. 
(define (num-bigger? lon n)
  (cond
    [(empty? lon) #true]
    [(< n (first lon)) (num-bigger? (rest lon) n)]
    [else #false]))


; List -> Variable 
; Takes a List, lst, and produces the last element in list. 
(define (my-last lst)
  (cond
    [(empty? lst) empty]
    [(empty? (rest lst)) (first lst)]
    [else (my-last (rest lst))]))

  
; List of Numbers -> Boolean 
; Takes a list of at least 3 numbers, lon, and if the given list is a bridgely produces #true, otherwise #false.
(define (bridgely? lon)
  (if (< (length lon) 3)
      #false
  (if (and (num-bigger? (last-element-remover (rest lon)) (first lon))
           (num-bigger? (last-element-remover (rest lon)) (my-last lon)))
      #true
      #false)))


; List of Numbers -> Boolean
; Takes a List of Numbers, lon, and produces #true if all the elements in the list are equal otherwise produces #false.
(define (binary-necklace lon)
  (local
    [(define blue-bead (circle 10 'solid 'darkblue))
     (define gold-bead (circle 7 'solid 'gold))]
    (cond
      [(empty? lon) empty-image]
      [(= (first lon) 0) (beside blue-bead (binary-necklace (rest lon)))]
      [(= (first lon) 1) (beside gold-bead (binary-necklace (rest lon)))])))


; List of Strings -> List of Strings
; Takes a List of Strings, los, and produces a new list containing only the strings in the input list that had 4 or fewer characters.
(define (short-words los)
  (cond
    [(empty? los) empty]
    [(<= (string-length (first los)) 4) (cons (first los) (short-words (rest los)))]
    [else (short-words (rest los ))]))


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


; Number -> Image
; Given a Number, depth, produces an image of the given depth of a fractal
(define (frac depth)
  (cond
    [(zero? depth) (square 5 'solid 'black)]
    [else
     (local
      [(define r (frac (- depth 1)))]
       (beside/align "center"   (above r r) (flip-horizontal r)))]))