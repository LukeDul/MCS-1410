#lang racket
(require racket/draw)
(require racket/gui)
;(require 2htdp/image)
;(require math)

(define (lmult c l) (map (lambda (x) (list (* (second x) c) (* (first x) c))) l))

(define target (make-bitmap 100 100)) ; A 30x30 bitmap
(define dc (new bitmap-dc% [bitmap target]))

(send dc set-pen "blue" 1 'solid)

(define zee (new dc-path%))


; List of Numbers -> List of Numbers
(define (center c l) (map (lambda (x) (list (+ (second x) (/ c 2)) (+ (first x) (/ c 2)))) l))

; Alex Harsanyi design
(define lista (center 100 (lmult 50 '((0/5 5/5) (3/5 4/5) (4/5 3/5) (3/5 1/5) (5/5 0/5) (4/5 -4/5) (1/5 -5/5)
                                                (-2/5 -4/5) (-4/5 -4/5) (-5/5 -1/5) (-3/5 -1/5) (-5/5 2/5) (-3/5 3/5) (-2/5 5/5) (0/5 5/5)))))



(define (graph lst)
  (cond
    [(empty? lst) empty]
    [else (send zee line-to (first (first lst)) (second (first lst))) (graph (rest lst))]))

(define (giraffe lst)
     (cons (send zee move-to (first (first lst)) (second (first lst))) (graph lst)))

(giraffe lista)


(send dc draw-path zee)


 (send target save-file "box.png" 'png)

(make-object image-snip% target)
