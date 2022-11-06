;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname txt-file-processing) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/batch-io)

; Problem 1: Seventeenth Item in a List
; Write a function to find the 17th item in a list.

; List, Number -> Element
; Given a list, lst, and a number, start-index, returns the 17th element in the list.
(define (seventeenth-helper lst start-index)
  (local
    [(define index (+ start-index 1))]
    (cond
      [(empty? lst) 0]
      [(= index 17) (first lst)]
      [else (seventeenth-helper (rest lst) index)])))  
    


; List -> Element
; Given a list, lst, returns the 17th element in the list.
(define (seventeenth lst)
  (seventeenth-helper lst 0))


; Problem 2: Longest Word in the Text
; Write a function to find the longest word in the file given by the parameter filename.
; Note the given check-expects, and the included small test file.
; Your code does not need to worry about punctuation.


; List of Strings, String -> String
; Given a list of strings, words, and a string, word, returns the longest string. 
(define (longest-word-helper word words)
  (cond
    [(empty? words) ""]
    [(empty? (rest words)) word]
    [(> (string-length word) (string-length (first words))) (longest-word-helper word (rest words))]
    [else (longest-word-helper (first words) (rest words))]))


; List of Strings -> String
; Given a list of strings, words, returns the longest string. 
(define (longest-word-in-a-file filename)
  (local
    [(define words (read-words filename))]
    (longest-word-helper "" words)))
  

; (check-expect (longest-word-in-a-file "txt-files/test1.txt") "love")
; (check-expect (longest-word-in-a-file "txt-files/test2.txt") "farmhouse")

; Problem 3: Shortest Line in a File
; For this problem, produce the line in the file that has the least number of words.
; Again, no need to worry about punctuation. Your function should produce a list of the words on that line
 
(define (shortest-line-in-a-file filename) ... )

; (check-expect (shortest-line-in-a-file "test1.txt") (list "Such" "indomitable" "effervescence" "accomplishes" "magnificance"))
; (check-expect (shortest-line-in-a-file "test2.txt") (list "Hourglass") )