;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CodetestingSuiteMidtermV4) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Q1
(define a 2)
(define b 1)

(define Problem1 (* a b))

(check-expect Problem1 2)

; Q2

(define Problem2 (* 2 (+ a b)))

(check-expect Problem2 6)

; Q3 

(define Problem3
  (cond
    [(and (even? a) (even? b)) #t]
    [else #f]))

(check-expect Problem3 #false)

;Q4
(define P (make-posn 1 4))

(define Problem4
  (local
    [(define A (- (posn-x P) 1))
     (define B (- (posn-y P) 2))]
    (sqrt (+ (sqr A) (sqr B)))))
    
(check-expect Problem4 2)

;Q5

(define (my-poly x)
  (+ 1 x (sqr x)))

(check-expect (my-poly 4) 21)
(check-expect (my-poly 0) 1)
(check-expect (my-poly 2) 7)


;Q6


(define (left-or-right P1 P2)
  (local
    [(define x1 (posn-x P1))
     (define x2 (posn-x P2))]
  (cond
    [(> x1 x2) "Right"]
    [(< x1 x2) "Left"]
    [else "Neither"])))

(check-expect (left-or-right (make-posn 1 2) (make-posn 3 4)) "Left")
(check-expect (left-or-right (make-posn 5 2) (make-posn 3 4)) "Right")
(check-expect (left-or-right (make-posn 3 2) (make-posn 3 4)) "Neither")

;Q7


(define (all-equal a b c)
  (if (= a b c) "All Equal" "Not All Equal"))

(check-expect (all-equal 0 0 0) "All Equal")
(check-expect (all-equal 1 0 0) "Not All Equal")
(check-expect (all-equal 0 1 0) "Not All Equal")
(check-expect (all-equal 0 1 1) "Not All Equal")

;Q8

(define-struct SQ (tl side))

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

;Q9

(define (list-all-equal lon)
  (cond
    [(empty? lon) #true]
    [(empty? (rest lon)) #true]
    [(= (first lon) (first (rest lon))) (list-all-equal (rest lon))]
    [else #false]))

(check-expect (list-all-equal (list 0 0 0)) #true)
(check-expect (list-all-equal (list 1 0 0)) #false)
(check-expect (list-all-equal (list 0 1 0)) #false)
(check-expect (list-all-equal (list 0 1 1)) #false)
(check-expect (list-all-equal empty) #true)
(check-expect (list-all-equal (list 1)) #true)
(check-expect (list-all-equal (list 1 2)) #false)

;Q10

(define (increasing? lon)
  (cond
    [(empty? lon) #true]
    [(empty? (rest lon)) #true]
    [(>=  (first (rest lon)) (first lon)) (increasing? (rest lon))]
    [else #false]))

(check-expect (increasing? (list 0 0 0)) #true)
(check-expect (increasing? (list 1 0 0)) #false)
(check-expect (increasing? (list 0 1 0)) #false)
(check-expect (increasing? (list 0 1 1)) #true)
(check-expect (increasing? empty) #true)
(check-expect (increasing? (list 1)) #true)
(check-expect (increasing? (list 1 2)) #true)

;Q11

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

(check-expect (bridgely? (list 0 0 0)) #false)
(check-expect (bridgely? (list 1 0 0)) #false)
(check-expect (bridgely? (list 0 1 0)) #true)
(check-expect (bridgely? (list 0 1 1)) #false)
(check-expect (bridgely? empty) #false)
(check-expect (bridgely? (list 1)) #false)
(check-expect (bridgely? (list 1 2)) #false)
(check-expect (bridgely? (list 1 3 2)) #true)

; Q12
(define 0b (circle 10 "solid" "DarkBlue"))
(define 1b (circle 7 "solid" "Gold"))
 
(define (binary-necklace lon)
  (local
    [(define blue-bead (circle 10 'solid 'darkblue))
     (define gold-bead (circle 7 'solid 'gold))]
    (cond
      [(empty? lon) empty-image]
      [(= (first lon) 0) (beside blue-bead (binary-necklace (rest lon)))]
      [(= (first lon) 1) (beside gold-bead (binary-necklace (rest lon)))])))

(check-expect (binary-necklace empty) (empty-scene 0 0))
(check-expect (binary-necklace (list 0 0 0)) (beside 0b 0b 0b))
(check-expect (binary-necklace (list 0 1 0)) (beside 0b 1b 0b))
(check-expect (binary-necklace (list 0)) 0b)
(check-expect (binary-necklace (list 0 1)) (beside 0b 1b))

; Q13

(define (short-words los)
  (cond
    [(empty? los) empty]
    [(<= (string-length (first los)) 4) (cons (first los) (short-words (rest los)))]
    [else (short-words (rest los ))]))

(check-expect
   (short-words (list "Whenever" "my" "awesome" "mind" "is" "challenged" "creativity" "defeats" "numb" "defeatism"))
                (list "my" "mind" "is" "numb"))

(check-expect
   (short-words empty) empty)

(check-expect
   (short-words (list "Whenever"))
                empty)

(check-expect
   (short-words (list "my"))
                (list "my"))

(check-expect
   (short-words (list "Whenever" "my"))
                (list "my"))

; Q14

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

(check-expect
  (move-lasers
    empty)
    empty)

(check-expect
  (move-lasers
    (list (make-posn 10 10)))
    (list (make-posn 15 10)))

(check-expect
  (move-lasers
    (list (make-posn 198 198)))
    empty)