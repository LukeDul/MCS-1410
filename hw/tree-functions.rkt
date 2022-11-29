;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname tree-functions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require racket/string)

; item is some thing, that data in the tree
; left is a tree
; right is a tree
(define-struct tree (item left right count))

; We have to manually define an empty-tree
(define empty-tree (make-tree "" 0 0 0))

; Tree -> Boolean
; Returns #true if t is the empty-Tree
(define (empty-tree? t) (string=? (tree-item t) ""))
(check-expect (empty-tree? empty-tree) #t)
(check-expect (empty-tree? (make-tree "test" empty-tree empty-tree 1)) #f)

; Tree, String -> Tree
; Inserts String item into the sorted binary tree tf
(define (tree-insert item t)
  (cond [(empty-tree? t) (make-tree item empty-tree empty-tree 1)]
        [(string=? (string-downcase item) (string-downcase (tree-item t)))
         (make-tree (tree-item t)
                    (tree-left t)
                    (tree-right t)
                    (+ (tree-count t) 1))]
        [(string<? (string-downcase item) (string-downcase (tree-item t)))
         (make-tree (tree-item t)
                    (tree-insert item (tree-left t))
                    (tree-right t)
                    (tree-count t))]
        [else
         (make-tree (tree-item t)
                    (tree-left t)
                    (tree-insert item (tree-right t))
                    (tree-count t))]))


(define (in-tree? t w)
  (cond
    [(empty-tree? t) #false]
    [(string=? (tree-item t) w) #true]
    [(string<? (tree-item t) w) (in-tree? (tree-right t) w)]
    [(string>? (tree-item t) w) (in-tree? (tree-left t) w)]
    ))

(define tree0 (foldl tree-insert empty-tree (string-split "this is a tree")))
(define tree1 (foldl tree-insert empty-tree (string-split "whose woods these are I think I know his house is in the village though he will not see me stopping here to watch his woods fill up with snow")))
(define tree2 (foldl tree-insert empty-tree (string-split "not at first sight nor with a dribbed shot love gave the wound which while I breathe will bleed but known worth did in mine of time proceed till by degrees it had full conquest got")))
(define tree3 (foldl tree-insert empty-tree (string-split "the good the bad the good and the ugly")))


; Write a function, num-leaves, that returns the number of leaves in a binary tree. 

; tree -> Number
; Counts the number of leaves in a tree. 
;(define (num-leaves tree)...)

;(check-expect (num-leaves tree0) 2)

;(check-expect (num-leaves tree1) 9)

;(check-expect (num-leaves tree2) 11)

;(check-expect (num-leaves tree3) 2)


; Tree -> Number
; returns the total number of nodes in a tree 
(define (tree-size tree)
  (length (tree-size-helper tree)))


; Tree -> List
; appends each item of each node to a list 
(define (tree-size-helper tree) 
  (cond [(empty-tree? tree) empty]
        [else (append (tree-size-helper (tree-right tree)) (cons (tree-item tree) (tree-size-helper (tree-left tree))))]))


(check-expect (tree-size tree0) 4)
(check-expect (tree-size tree1) 27)
(check-expect (tree-size tree2) 36)


; Tree -> Number
; returns the height of the given tree
(define (tree-height tree)
  (height-helper tree 0))


; Tree -> Number
; returns the height of the given tree
(define (height-helper tree height)
  (cond [(empty-tree? tree) (- height 1)]
        [(> (height-helper (tree-left tree) height) (height-helper (tree-right tree) height)) (height-helper (tree-left tree) (+ 1 height))]
        [else (height-helper (tree-right tree) (+ 1 height))])) 


(check-expect (tree-height tree0) 2) 
(check-expect (tree-height tree1) 9) 
(check-expect (tree-height tree2) 9) 


; Tree -> List of Lists
; returns a list of the items in the given tree with their counts sorted alphabetically.  
(define (tree-sort tree)
  (reverse (sort-helper tree)))

; Tree -> List of Lists
; returns a list of the items in the given tree with their counts unsorted.
(define (sort-helper tree) 
  (cond [(empty-tree? tree) empty] 
        [else (append (sort-helper (tree-right tree)) (cons (list (tree-item tree) (tree-count tree)) (sort-helper (tree-left tree))))]))


(check-expect (tree-sort tree0) (list (list "a" 1) (list "is" 1) (list "this" 1) (list "tree" 1)))
(check-expect (tree-sort tree3) (list (list "and" 1) (list "bad" 1) (list "good" 2) (list "the" 4) (list "ugly" 1)))


(define (total-count tree)
  (foldl (lambda (x1 x2) (+ x1 x2)) 0 (total-count-helper tree)))

(define (total-count-helper tree) 
  (cond [(empty-tree? tree) empty]
        [else (append (total-count-helper (tree-right tree)) (cons (tree-count tree) (total-count-helper (tree-left tree))))]))


