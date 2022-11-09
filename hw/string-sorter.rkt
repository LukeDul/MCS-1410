;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname string-sorter) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require racket/list)

; Given an item and a list, insert the item in the correct place
(define (insert s los)
  (cond [(empty? los) (list s)]
        [(string<? s (first los)) (cons s los)]
        [else (cons (first los) (insert s (rest los)))]))

; List of Strings, List of Strings -> List of Strings
; sort los
(define (insertion-sort-helper unsorted sorted)
  (cond [(empty? unsorted) sorted]
        [else (insertion-sort-helper (rest unsorted) (insert (first unsorted) sorted))]))

; List of Strings -> List of Strings
; sort los
(define (insertion-sort los)
  (insertion-sort-helper los empty))


; List of Strings -> List of Strings
; quick sort
 ; element < pivot
; element = pivot 
; element > pivot 
 

; why is insertion so much slower than quicksort


; merge sort 