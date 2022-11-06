;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname txt-file-processing) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List, Number -> Element
; Given a list, lst, and a number, start-index, returns the 17th element in the list.
(define (seventeenth-helper lst start-index)
  (local
    [(define index (+ start-index 1))]
    (cond
      [(empty? lst) 0]
      [(= index 17) (first lst)]
      [else (seventeenth-helper (rest lst) index)])))  
    


; List-> Eleme nt
; Given a list, lst, returns the 17th element in the list.
(define (seventeenth lst)
  (seventeenth-helper lst 0))