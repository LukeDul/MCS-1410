;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |20221028|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define bw (read-words "in-out.txt" )) ; list of all words in one list
(define bl (read-words/line "in-out.txt" )) ; 2D list of words based on line 

(define (word-frequency word lst) (length (filter (lambda (element) (string=? element word)) lst)))

;currying
; (define (eq? w s) (equal? w s) )
; vs.
; (lambda (s) (equal? w s))