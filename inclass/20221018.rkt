;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |20221018|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#| Recursion w/ Images and map 

Start with a triangle then start subdividing it into smaller triangles 

each step is called DEPTH-n
|#


(define (my-sqr n) (* n n))

 
(define (my-map f l)
  (cond
    [(empty? l) empty]
    [else (cons (f (first l)) (my-map f (rest l)))]))


(define (sierpinksi-triangle depth width)
  (cond
    [(zero? depth) (triangle width 'solid 'white)]
    [else
     (local
      [(define r (sierpinksi-triangle (- depth 1) width))]
       (above r (beside r r)))]))


(define (sierpinksi-carpet size color)
  (if
    (<= size 2)
    (square size 'outline color)
    (local
      [(define recurse (sierpinksi-carpet (/ size 3) color))
      (define center-square (square (/ size 3) 'solid 'white))]
      (overlay (square size 'outline color)(above (beside recurse recurse recurse)
                                                    (beside recurse center-square recurse)
                                                    (beside recurse recurse recurse))))))

     