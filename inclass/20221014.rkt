;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |20221014|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Standard deviation
sd(x) = sqrt(avg (sq list (x - avg( x))))

|#




(define-struct WS [ ballx bally xl yl ])
(define (change-ballpos ws x y) (make-WS x y (WS-xl ws) (WS-yl ws)))
(define (randomfrac y))
(define (avg l))


; List, Number -> List 
; Takes a list and a number as input and outputs a list containing each element minus x
(define (list_minus lon x)
  (cond
    [(empty? lon) empty]
    [else (cons (- (first lon) x)
                (list_minus (rest lon) x))]))


; List -> List
(define (sqlist lon)
  (cond [(empty? lon) empty]
        [else
         (cons (* (first lon) (first lon))
               (sqlist (rest lon)))]))

; List -> Number
; Given a list of numbers, lon, outputs the standard deviation, a Number,
; of the elements of lon 
(define (st_dev lon) (sqrt (avg (sqlist (list_minus lon (avg lon))))))

; Number, Number, Number -> Number
; Take a convex combination of x and y with weight lambda
(define (concomb x y l))


;WorldState -> Number
; Give a lambda which is >0 if the sd of xl and yl are both small enough, 0 o/w
(define (reliable ws (if
                      (and (< (st_dev (WS-xl ws)) 1)
                           (< (st_dev (WS-yl ws)) 1))
                      .01 0)))

(define (render ws)
  (place-image (circle 10 'solid 'white) (WS-ballx ws) (WS-bally ws)
               (place-image (square 50 'solid 'black) 575 575
                            (overlay (square 500 'outline 'black) (square 600 'solid 'green)))))

(define (tock ws)
  (change-ballpos ws (+ WS-ballx ws0 (* 8 (randokmfrac 100)))
                  (+ WS-ballx ws0 (* 8 (randokmfrac 100)))))
                

(define (move ws x y evt)
  (make-Ws (concomb (avg (WS-xl ws)) (WS-ballx ws) (reliability ws))
           (concomb (avg (WS-yl ws)) (WS-bally ws) (reliability ws))
           (adduptotem x (WS-xl ws)) (adduptoten y (WS-yl ws))))
           

(define (sheep-in-goal? ws))




                  