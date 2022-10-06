;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname firstListFunctions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 1. Sum of List of Numbers

; List of Numbers -> Number
; Produces the sum of the numbers in a list. 0 if the list is empty.
(define (my-list-sum lon) 
  (cond
    [(empty? lon) 0]
    [else (+ (first lon) (my-list-sum (rest lon)))]
    ))

; 2. Number of Items

; List -> Number
; Produces the number of items in the list l
(define (my-list-count l)
  (cond
    [(empty? l) 0]
    [else (+ 1 (my-list-count (rest l)))] ; f of rest of l (recursive functions call themselves on smaller and smaller inputs. 
    ))



; 3. Number of Odd Items

; List of Numbers -> Number
; Produces the number of odd items in a list l of numbers
(define (my-list-odd lon)
    (cond
   [(empty? lon) 0]
   [(odd? (first lon)) (+ 1 (my-list-odd (rest lon)))]
   [else (+ 0 (my-list-odd (rest lon)))]
   ))

; 4. Crossed Out Vowels

; Racket has the built-in functions string->list and list->string
; that do much of the work. You should play with these, to get a feel for how they work.
; Also note that a "character" in Racket is a new type that we haven't seen yet.
; Character literals look like this: #\a representing a lower-case "a", or #\3 to represent the character "3".
; You can use the functions char? and char=? for characters, the same way you use string? and string=? for strings.

; All you have to do for this assignment is to finish the replace-vowels function, as described in the comments.


; String -> String
; Takes an input string, and returns that string with vowels crossed out
(define (redact-vowels s)
  (list->string (replace-vowels (string->list s))))


;Example: "incarcerated" -> "xncxrcxrxtxd"

(define (v->x c)
  (cond
    [(char=? c #\a) #\x]
    [(char=? c #\i) #\x]
    [(char=? c #\e) #\x]
    [(char=? c #\o) #\x]
    [(char=? c #\u) #\x]
    [else c]))

; List of Char -> List of Char
; Replaces vowel charactes in the list with #\x
(define (replace-vowels loc)
  (cond
    [(empty? loc) empty]
    [else (cons (v->x (first loc)) (cons (replace-vowels (rest loc)) empty))]
    ))


; 5. Every Other Letter
; List of Letters -> String
; Concatenates the letters to make the string, but only every other letter! Only works for lists of odd length.
(define (recurse_odd lol)
  (cond
    [(empty? lol) ""]
    [else (if (even? (my-list-count (rest lol)))
              (string-append (first lol) (recurse_odd (rest lol)))
              (string-append "" (recurse_odd (rest lol)))
              )]))

; List of Letters -> String
; Concatenates the letters to make the string, but only every other letter! Only works for lists of even length.
(define (recurse_even lol)
  (cond
    [(empty? lol) ""]
    [else (if (odd? (my-list-count (rest lol)))
              (string-append (first lol) (recurse_even (rest lol)))
              (string-append "" (recurse_even (rest lol)))
              )]))


; List of Letters -> String
; Concatenates the letters to make the string, but only every other letter!
(define (oddLetters->string lol)
  (cond
    [(empty? lol) ""]
    [(odd? (my-list-count lol)) (recurse_odd lol)]
    [(even? (my-list-count lol)) (recurse_even lol)]))

(check-expect (oddLetters->string (list "f" "u" "n")) "fn")
(check-expect (oddLetters->string (list "f" "l" "u" "e" "n" "t")) "fun")
(check-expect (oddLetters->string empty) "")




; 6. Position * Value

; List of Numbers -> List of Numbers
; Replaces each element of a list with its value multiplied by its position
; 0th number multiplied by 0, 1st number multiplied by 1, etc...
(define (create-index lst)
  (cond
    [(empty?) empty)]
    [else (cons (cons empty))]) 


(define (index-mult-list lon)
  (cond
    [(empty? lon) empty]
    [else (cons (* (first lon) (find-index (first lon))) (cons (index-mult-list (rest lon)) empty))]))
;(check-expect (index-mult-list (list 1 1 1 1 1 1)) (list 0 1 2 3 4 5))
;(check-expect (index-mult-list (list 1 2 -3 1.5)) (list 0 2 -6 4.5))
;(check-expect (index-mult-list empty) empty)


#|

; 7. Position * Value Helper Function

;Multiplies the number by its position
;by adding one to the multiplier each recursion
;lon and a number->lon 
(define (posn-multiplier lon i) ...)

; The check-expects below might be helpful as you design this solution.
; (Note that you should not include check-expects in Mimir submissions. It crashes Mimir...)

; ( define l1 (cons 3 (cons 2 (cons 4 empty))) )
; ( define l2         (cons 2 (cons 4 empty))  )
; ( check-expect (posn-multiplier l1 0)   (cons 0 (cons 2 (cons 8 empty))) )
; ( check-expect (posn-multiplier l2 1) 

; 8. First and Last

; List of Things -> List of Two Things
; Returns a list containing the first and last items of a list.
; If the list has just one item, it returns a list with just that item.
; If the list has no items, it returns empty.
(define (first-and-last lot) ... )

|#