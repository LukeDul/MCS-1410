;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |20221018|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#| Recursion w/ Images 

Start with a triangle then start subdividing it into smaller triangles 

each step is called DEPTH-n


|#


(define (fractal depth width)
  (cond
    [(zero? depth) (triangle width 'solid 'white)]
    [else
     (local
      [(define r (fractal (- depth 1) width))]
       (above r (beside r r)))]))
