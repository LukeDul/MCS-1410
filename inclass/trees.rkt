;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname trees) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; tree 
(define-struct tree [item left right count])

(define empty-tree (make-tree "" 0 0 0))

(define (empty-tree? tree) (equal? empty-tree tree))


; Tree, String -> Boolean
; Checks if tree contains word. 
(define (tree-has? tree word)
  (cond [(empty? tree) #f]
        [else (or (string=? (tree-item tree) word)
                  (tree-has? (tree-left tree) word)
                  (tree-has? (tree-right tree) word))]))


(define the-tree (make-tree "teachpack" (make-tree "gui" (make-tree "2hdtp" empty-tree empty-tree 1) empty-tree 1)
                       (make-tree "universe" empty-tree (make-tree "web-io" empty-tree empty-tree 1) 1) 1))



; Tree, String -> Tree
; inserts the string, item, into the sorted binary tree, tree. 
(define (tree-insert item tree)
  (cond [(equal? tree empty-tree) (make-tree item empty-tree empty-tree 1)]
        [(string=? item (tree-item tree)) (make-tree item empty-tree empty-tree (+ 1 (tree-count tree)))] 
        [(string<? item (tree-item tree)) (make-tree
                                           (tree-item tree)
                                           (tree-insert item (tree-left tree))
                                           (tree-right tree)
                                           (tree-count tree))]
        [(string<? item (tree-item tree)) (make-tree
                                           (tree-item tree)
                                           (tree-right tree)
                                           (tree-insert item (tree-left tree))
                                           (tree-count tree))]))

(define hi (tree-insert "hi" empty-tree))